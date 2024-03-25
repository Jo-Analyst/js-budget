import 'package:js_budget/src/config/db/database.dart';
import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/fixed_expense_model.dart';

import 'package:js_budget/src/repositories/expense/fixed_expense/fixed_repository.dart';
import 'package:js_budget/src/repositories/expense/fixed_expense/transform_fixed_expense_json.dart';

class FixedExpenseRepositoryImpl implements FixedExpenseRepository {
  @override
  Future<Either<RespositoryException, List<Map<String, dynamic>>>>
      findAll() async {
    try {
      final db = await DataBase.openDatabase();
      final expenses = await db.query('fixed_expenses');

      return Right(expenses);
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<Either<RespositoryException, FixedExpenseModel>> register(
      FixedExpenseModel expense) async {
    try {
      int lastId = 0;
      final db = await DataBase.openDatabase();
      final data = TransformJson.toJson(expense);
      data.remove('id');
      await db.transaction((txn) async {
        lastId = await txn.insert('fixed_expenses', data);
      });
      data['id'] = lastId;

      return Right(TransformJson.fromJson(data));
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<Either<RespositoryException, Unit>> update(
      FixedExpenseModel expense) async {
    try {
      final data = TransformJson.toJson(expense);
      final db = await DataBase.openDatabase();
      await db.transaction((txn) async {
        await txn.update('fixed_expenses', data,
            where: 'id = ?', whereArgs: [expense.id]);
      });

      return Right(unit);
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<Either<RespositoryException, Unit>> delete(int id) async {
    try {
      final db = await DataBase.openDatabase();
      await db.transaction((txn) async {
        await txn.delete('fixed_expenses', where: 'id = ?', whereArgs: [id]);
      });

      return Right(unit);
    } catch (_) {
      return Left(RespositoryException());
    }
  }
}
