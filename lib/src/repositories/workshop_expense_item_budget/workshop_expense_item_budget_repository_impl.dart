import 'package:js_budget/src/models/workshop_expense_items_budget_model.dart';
import 'package:sqflite/sqflite.dart';
import 'workshop_expense_item_budget_repository.dart';

class WorkshopExpenseItemBudgetRepositoryImpl
    implements WorkshopExpenseItemBudgetRepository {
  @override
  Future<void> saveExpenseItemBudget(
      Transaction txn,
      WorkshopExpenseItemsBudgetModel workshopExpenseItemsBudget,
      int budgetItemId) async {
    if (workshopExpenseItemsBudget.value > 0) {
      await txn.insert('workshop_expense_items_budget', {
        'value': workshopExpenseItemsBudget.value,
        'divided_value': workshopExpenseItemsBudget.dividedValue,
        'accumulated_value': workshopExpenseItemsBudget.accumulatedValue,
        'type': workshopExpenseItemsBudget.type,
        'item_budget_id': budgetItemId,
      });
    }
  }

  @override
  Future<void> deleteWorkshopExpenseItem(Transaction txn, int budgetId) async {
    await txn.rawDelete(
        'DELETE FROM workshop_expense_items_budget WHERE item_budget_id IN (SELECT id FROM items_budget WHERE budget_id = $budgetId)');
  }
}
