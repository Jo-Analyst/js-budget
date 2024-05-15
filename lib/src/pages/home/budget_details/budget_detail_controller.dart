import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/helpers/message.dart';
import 'package:js_budget/src/models/items_budget_model.dart';
import 'package:js_budget/src/repositories/budget_items/budget_item_repository.dart';
import 'package:js_budget/src/repositories/budget_items/transform_item_budget_json.dart';
import 'package:js_budget/src/models/material_items_budget_model.dart';

class BudgetDetailController with Messages {
  final List<ItemsBudgetModel> _items = [];
  List<ItemsBudgetModel> get items => _items;

  final List<MaterialItemsBudgetModel> _materials = [];
  List<MaterialItemsBudgetModel> get materials => _materials;

  final BudgetItemRepository _budgetItemRepository;
  BudgetDetailController({
    required BudgetItemRepository budgetItemRepository,
  }) : _budgetItemRepository = budgetItemRepository;

  Future<void> findProducts(int budgetId) async {
    _items.clear();
    final results =
        await _budgetItemRepository.findProductAndServiceByBudgetId(budgetId);

    switch (results) {
      case Right(value: final itemsBudget):
        _items.addAll(
            TransformItemBudgetJson.fromJsonAfterSearchingProductAndServiceData(
                itemsBudget));
      case Left():
        showError('Houve um erro ao buscar o produto/serviço');
    }
  }

  Future<void> findMaterials(int budgetId) async {
    _materials.clear();
    final results =
        await _budgetItemRepository.findMaterialsByBudgetId(budgetId);

    switch (results) {
      case Right(value: final itemsBudget):
        _materials.addAll(
            TransformItemBudgetJson.fromJsonAfterSearchingMaterialData(
                itemsBudget));

      case Left():
        showError('Houve um erro ao buscar o material');
    }
  }
}
