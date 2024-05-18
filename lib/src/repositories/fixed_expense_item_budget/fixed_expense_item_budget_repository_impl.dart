import 'package:js_budget/src/models/fixed_expense_items_budget_model.dart';
import 'package:sqflite/sqflite.dart';
import './fixed_expense_item_budget_repository.dart';

class FixedExpenseItemBudgetRepositoryImpl
    implements FixedExpenseItemBudgetRepository {
  @override
  Future<void> saveExpenseItemBudget(
      Transaction txn,
      FixedExpenseItemsBudgetModel fixedExpenseItemsBudget,
      int budgetItemId) async {
    if (fixedExpenseItemsBudget.value > 0) {
      await txn.insert('fixed_expense_items_budget', {
        'value': fixedExpenseItemsBudget.value,
        'divided_value': fixedExpenseItemsBudget.dividedValue,
        'accumulated_value': fixedExpenseItemsBudget.accumulatedValue,
        'type': fixedExpenseItemsBudget.type,
        'item_budget_id': budgetItemId,
      });
    }
  }

  @override
  Future<void> deleteFixedExpenseItem(Transaction txn, int budgetId) async {
    await txn.rawDelete(
        'DELETE FROM fixed_expense_items_budget WHERE item_budget_id IN (SELECT id FROM items_budget WHERE budget_id = $budgetId)');
  }
}
