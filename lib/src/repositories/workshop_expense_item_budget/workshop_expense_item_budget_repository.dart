import 'package:js_budget/src/models/workshop_expense_items_budget_model.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class WorkshopExpenseItemBudgetRepository {
  Future<void> saveExpenseItemBudget(
      Transaction txn,
      WorkshopExpenseItemsBudgetModel workshopExpenseItemsBudget,
      int budgetItemId);
  Future<void> deleteWorkshopExpenseItem(Transaction txn, int budgetId);
}
