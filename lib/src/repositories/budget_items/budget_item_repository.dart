import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/models/items_budget_model.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class BudgetItemRepository {
  Future<void> saveItem(
      Transaction txn, ItemsBudgetModel itemsBudget, int budgetId);
  Future<Either<RespositoryException, List<Map<String, dynamic>>>>
      findProductByOrderId(int budgetId);
}
