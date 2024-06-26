import 'package:js_budget/src/models/material_items_budget_model.dart';
import 'package:sqflite/sqflite.dart';

import 'material_item_budget_repository.dart';

class MaterialItemBudgetRepositoryImpl implements MaterialItemBudgetRepository {
  @override
  Future<void> saveMaterialItemBudget(
      Transaction txn,
      MaterialItemsBudgetModel materialItemsBudgetModel,
      int budgetItemId) async {
    await txn.insert('material_items_budget', {
      'value': materialItemsBudgetModel.value,
      'quantity': materialItemsBudgetModel.quantity,
      'material_id': materialItemsBudgetModel.material.id,
      'item_budget_id': budgetItemId,
    });
  }

  @override
  Future<void> deleteMaterialItem(Transaction txn, int budgetId) async {
    await txn.rawDelete(
        'DELETE FROM material_items_budget WHERE item_budget_id IN (SELECT id FROM items_budget WHERE budget_id = $budgetId)');
  }
}
