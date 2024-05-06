import 'package:js_budget/src/config/db/database.dart';
import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/budget_model.dart';
import 'package:js_budget/src/repositories/budget_items/budget_item_repository_impl.dart';

import './budget_repository.dart';

class BudgetRepositoryImpl implements BudgetRepository {
  final _budgetItem = BudgetItemRepositoryImpl();

  @override
  Future<Either<RespositoryException, Unit>> save(BudgetModel budget) async {
    try {
      final db = await DataBase.openDatabase();
      await db.transaction(
        (txn) async {
          int lastId = await txn.insert('budgets', {
            "value_total": budget.valueTotal,
            'created_at': DateTime.now().toIso8601String(),
            'order_id': budget.orderId,
            'client_id': budget.clientId
          });

          for (var item in budget.itemsBudget!) {
            await _budgetItem.saveItem(txn, item, lastId);
          }
        },
      );
      return Right(unit);
    } catch (_) {
      return Left(RespositoryException());
    }
  }
}
