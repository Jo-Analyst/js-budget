import 'package:js_budget/src/models/items_budget_model.dart';
import 'package:js_budget/src/repositories/fixed_expense_item_budget/fixed_expense_item_budget_repository_impl.dart';
import 'package:js_budget/src/repositories/material_item_budget/material_item_budget_repository_impl.dart';
import 'package:sqflite/sqflite.dart';
import './budget_item_repository.dart';

class BudgetItemRepositoryImpl implements BudgetItemRepository {
  final _materialItemBudget = MaterialItemBudgetRepositoryImpl();
  final _expenseItemBudget = FixedExpenseItemBudgetRepositoryImpl();

  @override
  Future<void> saveItem(
      Transaction txn, ItemsBudgetModel itemsBudget, int budgetId) async {
    int lastId = await txn.insert('items_budget', {
      "sub_value": itemsBudget.subValue,
      "unitary_value": itemsBudget.unitaryValue,
      "term": itemsBudget.term,
      "time_incentive": itemsBudget.timeIncentive,
      "percentage_profit_margin": itemsBudget.percentageProfitMargin,
      "profit_margin_value": itemsBudget.profitMarginValue,
      "product_id": itemsBudget.product?.id,
      "service_id": itemsBudget.service?.id,
      "budget_id": budgetId,
    });

    itemsBudget.materialItemsBudget.asMap().forEach((key, materialItem) {
      _materialItemBudget.saveMaterialItemBudget(txn, materialItem, lastId);
    });

    itemsBudget.fixedExpenseItemsBudget.asMap().forEach((key, expenseItem) {
      _expenseItemBudget.saveExpenseItemBudget(txn, expenseItem, lastId);
    });
  }
}
