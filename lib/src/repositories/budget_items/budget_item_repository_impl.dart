import 'package:js_budget/src/models/items_budget_model.dart';
import 'package:sqflite/sqflite.dart';
import './budget_item_repository.dart';

class BudgetItemRepositoryImpl implements BudgetItemRepository {
  @override
  Future<void> saveItem(
      Transaction txn, ItemsBudgetModel itemsBudget, int budgetId) async {
    int lastId = await txn.insert('items_budget', {});
  }
}
