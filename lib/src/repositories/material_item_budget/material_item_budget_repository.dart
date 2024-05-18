import 'package:js_budget/src/models/material_items_budget_model.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class MaterialItemBudgetRepository {
  Future<void> saveMaterialItemBudget(Transaction txn,
      MaterialItemsBudgetModel materialItemsBudgetModel, int budgetItemId);
  Future<void> deleteMaterialItem(Transaction txn, int budgetId);
}
