import 'package:js_budget/src/models/items_budget_model.dart';
import 'package:sqflite/sqflite.dart';
import './budget_item_repository.dart';

class BudgetItemRepositoryImpl implements BudgetItemRepository {
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
  }
}
