import 'package:js_budget/src/models/material_items_budget_model.dart';
import 'package:sqflite/sqflite.dart';

import './material_item_budget_repository.dart';

class MaterialItemBudgetRepositoryImpl implements MaterialItemBudgetRepository {
  @override
  Future<void> saveMaterialItemBudget(
      Transaction txn, MaterialItemsBudgetModel materialItemsBudgetModel) {
    throw UnimplementedError();
  }
}
