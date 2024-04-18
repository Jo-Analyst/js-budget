import 'package:js_budget/src/config/db/database.dart';
import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/expense_model.dart';

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
  Future<Either<RespositoryException, ExpenseModel>> register(
      ExpenseModel expense) async {
    try {
      int lastId = 0;
      final db = await DataBase.openDatabase();
      final data = TransformFixedExpenseJson.toJson(expense);
      data.remove('id');
      await db.transaction((txn) async {
        lastId = await txn.insert('fixed_expenses', data);
      });
      data['id'] = lastId;

      return Right(TransformFixedExpenseJson.fromJson(data));
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<Either<RespositoryException, Unit>> update(
      ExpenseModel expense) async {
    try {
      final data = TransformFixedExpenseJson.toJson(expense);
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

  @override
  Future<Either<RespositoryException, List<Map<String, dynamic>>>> findByType(
      String type) async {
    try {
      final db = await DataBase.openDatabase();
      final expenses = await db
          .query('fixed_expenses', where: 'type = ?', whereArgs: [type]);

      return Right(expenses);
    } catch (_) {
      return Left(RespositoryException());
    }
  }
}
