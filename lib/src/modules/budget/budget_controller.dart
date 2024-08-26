import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/helpers/message.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/models/material_items_budget_model.dart';
import 'package:js_budget/src/models/material_model.dart';
import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/models/service_model.dart';
import 'package:js_budget/src/models/workshop_expense_items_budget_model.dart';
import 'package:js_budget/src/modules/material/material_controller.dart';
import 'package:js_budget/src/modules/payment/payment_history/payment_history_controller.dart';
import 'package:js_budget/src/repositories/budget/transform_budget_json.dart';
import 'package:js_budget/src/utils/utils_service.dart';
import 'package:signals/signals.dart';

import 'package:js_budget/src/models/budget_model.dart';
import 'package:js_budget/src/models/items_budget_model.dart';
import 'package:js_budget/src/repositories/budget/budget_repository.dart';

class BudgetController with Messages {
  BudgetController({
    required BudgetRepository budgetRepository,
  }) : _budgetRepository = budgetRepository;

  final BudgetRepository _budgetRepository;
  final _totalBudgets = signal<double>(0.0);
  Signal<double> get totalBudgets => _totalBudgets;
  final subDiscount = signal<double>(0.0);
  final totalDiscount = signal<double>(0.0);

  final _totalWorshopExpense = signal<double>(0.0);
  Signal<double> get totalWorshopExpense => _totalWorshopExpense;

  final _totalFreight = signal<double>(0.0);
  Signal<double> get totalFreight => _totalFreight;

  final _totalMaterial = signal<double>(0.0);
  Signal<double> get totalMaterial => _totalMaterial;

  final _totalTerm = signal<int>(0);
  Signal<int> get totalTerm => _totalTerm;

  final _totalGrossValue = signal<double>(0.0);
  Signal<double> get totalGrossValue => _totalGrossValue;

  final _totalService = signal<double>(0.0);
  Signal<double> get totalService => _totalService;

  final _profitMargin = signal<double>(0.0);
  Signal<double> get profitMargin => _profitMargin;

  final _data = ListSignal<BudgetModel>([]);
  ListSignal<BudgetModel> get data => _data
    ..sort(
      (a, b) => b.id.compareTo(a.id),
    );

  final _dataFiltered = ListSignal<BudgetModel>([]);
  ListSignal<BudgetModel> get dataFiltered => _dataFiltered
    ..sort(
      (a, b) => b.id.compareTo(a.id),
    );

  final model = signal<BudgetModel>(BudgetModel());

  void calculateGrossTotal() {
    totalGrossValue.value = totalMaterial.value +
        totalWorshopExpense.value +
        profitMargin.value +
        totalFreight.value +
        totalService.value;
  }

  double sumValueProducts(ListSignal<ItemsBudgetModel> data) {
    double value = 0.0;
    data.asMap().forEach((key, item) {
      if (item.product != null) {
        value += item.subValue;
      }
    });
    return double.parse(value.toStringAsFixed(2));
  }

  (List<WorkshopExpenseItemsBudgetModel>, List<MaterialItemsBudgetModel>)
      findBudgetByDate(String date) {
    List<WorkshopExpenseItemsBudgetModel> workshopExpense = [];
    List<MaterialItemsBudgetModel> materialItem = [];
    List<BudgetModel> budgets = [];

    for (var dt in data) {
      final (year, month, day, _, _) = UtilsService.extractDate(dt.createdAt!);
      final dataCreatedAt =
          UtilsService.dateFormatText(DateTime(year, month, day));

      if (dataCreatedAt.toLowerCase().contains(date.toLowerCase())) {
        budgets.add(dt);
      }
    }

    final (workshopExpenseItems, materialItems) =
        _getItemsExpenseWorkshopMaterial(budgets);
    workshopExpense.addAll(workshopExpenseItems);
    materialItem.addAll(materialItems);

    _totalWorshopExpense.value = _sumWorkshopExpense(workshopExpense);
    _totalMaterial.value = _sumMaterial(materialItem);

    final (totalGrossValue, totalService) =
        _calculateServiceAndGrossValue(budgets);
    _totalService.value = totalService;
    _totalGrossValue.value = totalGrossValue;
    return (workshopExpense, materialItem);
  }

  (double, double) _calculateServiceAndGrossValue(List<BudgetModel> budgets) {
    double totalGrossValue = 0;
    double totalService = 0;
    budgets.asMap().forEach((_, budget) {
      budget.itemsBudget!.asMap().forEach((_, item) {
        if (item.product == null && item.service != null) {
          totalService += item.subValue;
        }
      });

      totalGrossValue += budget.amount ?? 0;
    });

    return (totalGrossValue, totalService);
  }

  List<WorkshopExpenseItemsBudgetModel> _mergeWorkshopExpenseItems(
      List<WorkshopExpenseItemsBudgetModel> workshopExpenseItems) {
    List<WorkshopExpenseItemsBudgetModel> workshopExpenseItem = [];

    for (var workshopExpense in workshopExpenseItems) {
      if (workshopExpenseItem.isEmpty ||
          (!workshopExpenseItem.any((mt) => mt.type == workshopExpense.type) &&
              workshopExpense.accumulatedValue > 0)) {
        workshopExpenseItem.add(
          WorkshopExpenseItemsBudgetModel(
            value: workshopExpense.value,
            type: workshopExpense.type,
            accumulatedValue: workshopExpense.dividedValue * _totalTerm.value,
            dividedValue: workshopExpense.dividedValue,
          ),
        );
      } else {
        for (var itemWorkShop in workshopExpenseItem) {
          if (itemWorkShop.type == workshopExpense.type) {
            itemWorkShop.dividedValue = workshopExpense.dividedValue;
            itemWorkShop.accumulatedValue =
                itemWorkShop.dividedValue * _totalTerm.value;
            break;
          }
        }
      }
    }

    return workshopExpenseItem
      ..sort((a, b) => a.type.toLowerCase().compareTo(b.type.toLowerCase()));
  }

  List<MaterialItemsBudgetModel> _mergeMaterialItems(
      List<MaterialItemsBudgetModel> allMaterialsItems) {
    List<MaterialItemsBudgetModel> materialItem = [];

    allMaterialsItems.asMap().forEach((index, material) {
      if (materialItem.isEmpty ||
          !materialItem.any((mt) =>
              mt.material.name.toLowerCase() ==
              material.material.name.toLowerCase()) ||
          materialItem.any((mat) =>
              mat.material.name.toLowerCase() == 'material indefinido')) {
        materialItem.add(
          MaterialItemsBudgetModel(
            value: material.value,
            quantity: material.quantity,
            material: MaterialModel(
              id: material.material.id,
              name: material.material.name,
            ),
          ),
        );
      } else {
        for (var item in materialItem) {
          if (item.material.name.toLowerCase() ==
              material.material.name.toLowerCase()) {
            item.quantity += material.quantity;
            item.value += material.value;
            break;
          }
        }
      }
    });

    return materialItem
      ..sort((a, b) => a.material.name
          .toLowerCase()
          .compareTo(b.material.name.toLowerCase()));
  }

  (List<WorkshopExpenseItemsBudgetModel>, List<MaterialItemsBudgetModel>)
      _getItemsExpenseWorkshopMaterial(List<BudgetModel> budgets) {
    List<WorkshopExpenseItemsBudgetModel> allWorkshopExpenseItems = [];
    List<MaterialItemsBudgetModel> allMaterialItems = [];

    totalTerm.value = 0;
    _profitMargin.value = 0;
    _totalFreight.value = 0;
    for (var budget in budgets) {
      budget.itemsBudget?.forEach((item) {
        allWorkshopExpenseItems.addAll(item.workshopExpenseItemsBudget);
        allMaterialItems.addAll(item.materialItemsBudget);
        totalTerm.value += item.term;
        _profitMargin.value += item.profitMarginValue;
      });

      _totalFreight.value += budget.freight ?? 0;
    }

    return (
      _mergeWorkshopExpenseItems(allWorkshopExpenseItems),
      _mergeMaterialItems(allMaterialItems)
    );
  }

  double _sumWorkshopExpense(
      List<WorkshopExpenseItemsBudgetModel> workshopExpense) {
    return workshopExpense.fold<double>(
        0, (total, workshop) => total + workshop.accumulatedValue);
  }

  double _sumMaterial(List<MaterialItemsBudgetModel> itemMaterial) {
    return itemMaterial.fold<double>(
        0, (total, material) => total + material.value);
  }

  bool validateFields(ListSignal<ItemsBudgetModel> data) {
    for (var item in data) {
      if (item.product != null && item.materialItemsBudget.isEmpty) {
        showInfo(
            'Existe um ou mais produtos sem precificar. Para concluir precifique todos os produtos');
        return false;
      }
    }
    return true;
  }

  Future<bool> save(BudgetModel budgetModel) async {
    bool? isError;

    final results = await _budgetRepository.save(budgetModel);

    switch (results) {
      case Right(value: BudgetModel budget):
        model.value = budget;
        _data.add(budget);
        _dataFiltered.clear();
        _dataFiltered.value = _data.value;
        _sumBudgets(_data);
        isError = false;
      case Left():
        isError = true;
        showError('Houve um erro ao gerar o orçamento');
    }

    return isError;
  }

  Future<void> delete(int budgetId, int orderId) async {
    final results = await _budgetRepository.deleteBudget(budgetId, orderId);

    switch (results) {
      case Right():
        deleteItem(budgetId);
      case Left():
        showError('Houve um erro ao gerar o orçamento');
    }
  }

  void deleteItem(int budgetId) {
    totalBudgets.value -=
        _data.value.where((data) => data.id == budgetId).first.amount!;
    _data.removeWhere((data) => data.id == budgetId);
    _dataFiltered.removeWhere((data) => data.id == budgetId);
  }

  Future<void> findBudgets() async {
    _data.clear();
    final results = await _budgetRepository.findAll();
    switch (results) {
      case Right(value: final List<Map<String, dynamic>> budgets):
        _data.addAll(TransformBudgetJson.fromJsonAfterDataSearch(budgets));

        dataFiltered.value = _data;
        _sumBudgets(_data.value);

      case Left():
        showError('Houve um erro ao gerar o orçamento');
    }
  }

  void _sumBudgets(List<BudgetModel> budgets) {
    totalBudgets.value = 0;
    for (var data in budgets) {
      totalBudgets.value += data.amount!;
    }
  }

  void filterData(String status) {
    _dataFiltered.value = _data
        .where(
            (data) => data.status!.toLowerCase().contains(status.toLowerCase()))
        .toList();

    _sumBudgets(_dataFiltered);
  }

  List<MaterialItemsBudgetModel> getMaterials(BudgetModel budget) {
    List<MaterialItemsBudgetModel> materialItemBudget = [];
    budget.itemsBudget!.asMap().forEach((key, itemBudget) {
      itemBudget.materialItemsBudget;
      materialItemBudget.addAll(itemBudget.materialItemsBudget);
    });

    return _mergeMaterialItems(materialItemBudget);
  }

  List<WorkshopExpenseItemsBudgetModel> getWorkshopExpense(BudgetModel budget) {
    List<WorkshopExpenseItemsBudgetModel> workShopExpenseItemBudget = [];
    _totalTerm.value = 0;
    _profitMargin.value = 0;

    budget.itemsBudget!.asMap().forEach((key, itemBudget) {
      workShopExpenseItemBudget.addAll(itemBudget.workshopExpenseItemsBudget);

      _profitMargin.value += itemBudget.profitMarginValue;
      _totalTerm.value += itemBudget.term;
    });

    return _mergeWorkshopExpenseItems(workShopExpenseItemBudget);
  }

  Future<bool> changeStatusAndStockMaterial(
      String status, int budgetId, String? approvalDate,
      {required List<MaterialItemsBudgetModel> materialItems,
      bool? isDecrementation}) async {
    bool isError = false;
    final materialController = Injector.get<MaterialController>();

    final results = await _budgetRepository.changeStatusAndMaterial(
      status,
      budgetId,
      approvalDate,
      materials: materialItems,
      isDecrementation: isDecrementation,
    );

    switch (results) {
      case Right():
        for (int i = 0; i < _data.length; i++) {
          if (_data[i].id == budgetId) {
            data[i].status = status;
            data[i].approvalDate = approvalDate;
            break;
          }
        }

        if (isDecrementation != null && materialItems.isNotEmpty) {
          for (var item in materialItems) {
            if (isDecrementation) {
              materialController.decreaseQuantity(
                  item.material.quantity, item.material.id);
            } else {
              materialController.increaseQuantity(
                  item.material.quantity, item.material.id);
            }
          }
        }

      case Left():
        showError('Houve um erro ao atualizar o status');
        isError = true;
    }

    return isError;
  }

  Future<bool> thereIsPaymentMade(
      // Há pagamento feito

      int paymentId,
      bool checkStatus) async {
    final paymentHistoryController = Injector.get<PaymentHistoryController>();

    if (!checkStatus) return false;

    await paymentHistoryController.findPaymentHistory(paymentId);
    if (paymentHistoryController.data.isNotEmpty) {
      showInfo(
          'Não é possível reverter o pedido para o status ‘Em aberto’ devido a um pagamento já realizado.',
          timeSeconds: 5);
      return true;
    }

    return false;
  }

  void addAllDiscounts(List<ItemsBudgetModel> itemsBudget) {
    totalDiscount.value = 0;
    for (var item in itemsBudget) {
      totalDiscount.value += item.subDiscount;
    }
  }

  void changeClientListBudget(ClientModel client) {
    for (var dt in dataFiltered) {
      if (dt.client!.id == client.id) {
        dt.client = client;
      }
    }
  }

  void changeMaterialListBudget(MaterialModel material) {
    for (var budget in dataFiltered) {
      for (var item in budget.itemsBudget!) {
        for (var materialItem in item.materialItemsBudget) {
          if (material.id == materialItem.material.id) {
            materialItem.material = material;
          }
        }
      }
    }
  }

  void changeProductListBudget(ProductModel product) {
    for (var dt in dataFiltered) {
      for (var item in dt.itemsBudget!) {
        if (product.id == item.product?.id) {
          item.product = product;
        }
      }
    }
  }

  void changeServiceListBudget(ServiceModel service) {
    for (var dt in dataFiltered) {
      for (var item in dt.itemsBudget!) {
        if (service.id == item.service?.id) {
          item.service = service;
        }
      }
    }
  }

  void deleteBudgetByClientId(int clientId) {
    dataFiltered.removeWhere((data) => data.client!.id == clientId);
  }

  void changeNameMaterialTheListBudget(int materialId) {
    for (var budget in dataFiltered) {
      for (var item in budget.itemsBudget!) {
        for (var materialItem in item.materialItemsBudget) {
          if (materialId == materialItem.material.id) {
            materialItem.material.name = 'Material indefinido ';
          }
        }
      }
    }
  }

  void changeNameProductTheListBudget(int productId) {
    for (var dt in dataFiltered) {
      for (var item in dt.itemsBudget!) {
        if (productId == item.product?.id) {
          item.product!.name = 'P/S indefinido';
        }
      }
    }
  }

  void changeDescriptionServiceTheListBudget(int serviceId) {
    for (var dt in dataFiltered) {
      for (var item in dt.itemsBudget!) {
        if (serviceId == item.service?.id) {
          item.service!.description = 'P/S indefinido';
        }
      }
    }
  }
}
