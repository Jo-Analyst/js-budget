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

  Future<bool> save() async {
    bool? isError;
    final results = await _budgetRepository.save(model.value);

    switch (results) {
      case Right(value: BudgetModel budget):
        _data.add(budget);
        totalBudgets.value += budget.valueTotal!;
        isError = false;
      case Left():
        isError = true;
        showError('Houve um erro ao gerar o orçamento');
    }

    return isError;
  }

  Future<void> findBudgets() async {
    _data.clear();
    final results = await _budgetRepository.findAll();
    switch (results) {
      case Right(value: final List<Map<String, dynamic>> budgets):
        _data.addAll(TransformBudgetJson.fromJsonAfterDataSearch(budgets));
        _sumBudgets();

      case Left():
        showError('Houve um erro ao gerar o orçamento');
    }
  }

  void _sumBudgets() {
    for (var data in _data) {
      totalBudgets.value += data.valueTotal!;
    }
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
}
