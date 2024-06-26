import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/helpers/message.dart';
import 'package:js_budget/src/models/material_items_budget_model.dart';
import 'package:js_budget/src/models/material_model.dart';
import 'package:js_budget/src/models/workshop_expense_items_budget_model.dart';
import 'package:js_budget/src/modules/material/material_controller.dart';
import 'package:js_budget/src/modules/payment/payment_history/payment_history_controller.dart';
import 'package:js_budget/src/repositories/budget/transform_budget_json.dart';
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

  final _totalWorshopExpense = signal<double>(0.0);
  Signal<double> get totalWorshopExpense => _totalWorshopExpense;

  final _totalMaterial = signal<double>(0.0);
  Signal<double> get totalMaterial => _totalMaterial;

  final _totalTerm = signal<int>(0);
  Signal<int> get totalTerm => _totalTerm;

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
    int term = 0;

    for (var dt in data) {
      if (dt.createdAt!.toLowerCase().contains(date.toLowerCase())) {
        for (var item in dt.itemsBudget!) {
          for (var workshop in item.workshopExpenseItemsBudget) {
            if (workshopExpense.isEmpty ||
                (!workshopExpense
                        .any((expense) => expense.type == workshop.type) &&
                    workshop.accumulatedValue > 0)) {
              workshopExpense.add(
                WorkshopExpenseItemsBudgetModel(
                  type: workshop.type,
                  accumulatedValue: workshop.accumulatedValue,
                  dividedValue: workshop.dividedValue,
                ),
              );
            } else {
              for (var existingWorkshop in workshopExpense) {
                if (existingWorkshop.type == workshop.type) {
                  existingWorkshop.accumulatedValue +=
                      workshop.accumulatedValue;
                  break; // Encerra o loop após encontrar o tipo correspondente
                }
              }
            }
          }

          for (var itemMaterial in item.materialItemsBudget) {
            if (materialItem.isEmpty ||
                !materialItem.any(
                    (mt) => mt.material.name == itemMaterial.material.name)) {
              materialItem.add(
                MaterialItemsBudgetModel(
                  material: itemMaterial.material,
                  quantity: itemMaterial.quantity,
                  value: itemMaterial.value,
                ),
              );
            } else {
              for (var existingMaterial in materialItem) {
                if (existingMaterial.material.name ==
                    itemMaterial.material.name) {
                  existingMaterial.value +=
                      itemMaterial.value * itemMaterial.quantity;
                  print(existingMaterial.value);
                  break; // Encerra o loop após encontrar o tipo correspondente
                }
              }
            }
          }

          term += item.term;
        }
      }
    }
    _totalTerm.value = term;

    _totalWorshopExpense.value = _sumWorkshopExpense(workshopExpense);
    _totalMaterial.value = _sumMaterial(materialItem);
    return (workshopExpense, materialItem);
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
        _data.value.where((data) => data.id == budgetId).first.valueTotal!;
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
      totalBudgets.value += data.valueTotal!;
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
      itemBudget.materialItemsBudget.asMap().forEach((index, materialItem) {
        if (materialItemBudget.isEmpty ||
            !materialItemBudget
                .any((mt) => mt.material.name == materialItem.material.name)) {
          materialItemBudget.add(
            MaterialItemsBudgetModel(
              value: materialItem.value,
              quantity: materialItem.quantity,
              material: MaterialModel(
                id: materialItem.material.id,
                name: materialItem.material.name,
              ),
            ),
          );
        } else {
          for (var itemMaterial in materialItemBudget) {
            if (itemMaterial.material.name == materialItem.material.name) {
              itemMaterial.quantity += materialItem.quantity;
              itemMaterial.value += materialItem.value;
            }
          }
        }
      });
    });

    return materialItemBudget;
  }

  (List<WorkshopExpenseItemsBudgetModel>, int) getWorkshopExpense(
      BudgetModel budget) {
    List<WorkshopExpenseItemsBudgetModel> workShopExpenseItemBudget = [];
    int term = 0;
    budget.itemsBudget!.asMap().forEach((key, itemBudget) {
      itemBudget.workshopExpenseItemsBudget
          .asMap()
          .forEach((index, workshopExpenseItem) {
        if (workShopExpenseItemBudget.isEmpty ||
            (!workShopExpenseItemBudget
                    .any((mt) => mt.type == workshopExpenseItem.type) &&
                workshopExpenseItem.accumulatedValue > 0)) {
          workShopExpenseItemBudget.add(
            WorkshopExpenseItemsBudgetModel(
              value: workshopExpenseItem.value,
              type: workshopExpenseItem.type,
              accumulatedValue: workshopExpenseItem.accumulatedValue,
              dividedValue: workshopExpenseItem.dividedValue,
            ),
          );
        } else {
          for (var itemWorkShop in workShopExpenseItemBudget) {
            if (itemWorkShop.type == workshopExpenseItem.type) {
              itemWorkShop.dividedValue = workshopExpenseItem.dividedValue;
              itemWorkShop.accumulatedValue +=
                  workshopExpenseItem.accumulatedValue;
            }
          }
        }
      });

      term += itemBudget.term;
    });

    return (workShopExpenseItemBudget, term);
  }

  Future<bool> changeStatusAndStockMaterial(String status, int budgetId,
      {required List<MaterialItemsBudgetModel> materialItems,
      bool? isDecrementation}) async {
    bool isError = false;
    final materialController = Injector.get<MaterialController>();

    final results = await _budgetRepository.changeStatusAndMaterial(
      status,
      budgetId,
      materials: materialItems,
      isDecrementation: isDecrementation,
    );

    switch (results) {
      case Right():
        for (int i = 0; i < _data.length; i++) {
          if (_data[i].id == budgetId) {
            data[i].status = status;
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
}
