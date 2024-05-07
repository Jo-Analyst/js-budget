import 'package:js_budget/src/models/material_items_budget_model.dart';
import 'package:sqflite/sqflite.dart';

import './material_item_budget_repository.dart';

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
}
