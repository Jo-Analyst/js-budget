import 'package:js_budget/src/config/db/database.dart';
import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/models/budget_model.dart';
import 'package:js_budget/src/repositories/budget/transform_budget_json.dart';
import 'package:js_budget/src/repositories/budget_items/budget_item_repository_impl.dart';

import './budget_repository.dart';

class BudgetRepositoryImpl implements BudgetRepository {
  final _budgetItem = BudgetItemRepositoryImpl();

  @override
  Future<Either<RespositoryException, BudgetModel>> save(
      BudgetModel budget) async {
    try {
      final Map<String, dynamic> data = {
        "value_total": budget.valueTotal,
        'created_at': DateTime.now().toIso8601String(),
        'order_id': budget.orderId,
        'client_id': budget.clientId
      };
      final db = await DataBase.openDatabase();
      await db.transaction(
        (txn) async {
          int budgetId = await txn.insert('budgets', data);

          for (var item in budget.itemsBudget!) {
            await _budgetItem.saveItem(txn, item, budgetId);
          }
          data['id'] = budgetId;
          data['items_budget'] = budget.itemsBudget!;
        },
      );
      return Right(TransformBudgetJson.fromJson(data));
    } catch (_) {
      return Left(RespositoryException());
    }
  }
}
