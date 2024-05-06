import 'package:js_budget/src/models/fixed_expense_items_budget_model.dart';
import 'package:sqflite/sqflite.dart';
import './fixed_expense_item_budget_repository.dart';

class FixedExpenseItemBudgetRepositoryImpl
    implements FixedExpenseItemBudgetRepository {
  @override
  Future<void> saveExpenseItemBudget(
      Transaction txn, FixedExpenseItemsBudgetModel fixedExpenseItemsBudget) {
    throw UnimplementedError();
  }
}
