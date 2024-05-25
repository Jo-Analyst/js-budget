import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/helpers/message.dart';
import 'package:js_budget/src/models/material_items_budget_model.dart';
import 'package:js_budget/src/models/material_model.dart';
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

  Future<bool> changeStatus(String status, int budgetId) async {
    bool isError = false;
    final results = await _budgetRepository.changeStatus(status, budgetId);

    switch (results) {
      case Right():
        for (int i = 0; i < _data.length; i++) {
          if (_data[i].id == budgetId) {
            data[i].status = status;
            break;
          }
        }
      case Left():
        showError('Houve um erro ao atualizar o status');
        isError = true;
    }

    return isError;
  }
}
