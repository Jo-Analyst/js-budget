import 'package:js_budget/src/models/fixed_expense_items_budget_model.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class FixedExpenseItemBudgetRepository {
  Future<void> saveExpenseItemBudget(Transaction txn,
      FixedExpenseItemsBudgetModel fixedExpenseItemsBudget, int budgetItemId);
  Future<void> deleteFixedExpenseItem(Transaction txn, int budgetId);
}
