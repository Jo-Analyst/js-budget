import 'package:js_budget/src/config/db/database.dart';
import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/expense_model.dart';

import 'package:js_budget/src/repositories/expense/workshop_expense/workshop_repository.dart';
import 'package:js_budget/src/repositories/expense/transform_expense_json.dart';

class WorkshopExpenseRepositoryImpl implements WorkshopExpenseRepository {
  @override
  Future<Either<RespositoryException, List<Map<String, dynamic>>>>
      findAll() async {
    try {
      final db = await DataBase.openDatabase();
      final expenses = await db.query('workshop_expenses');

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
      final data = TransformExpenseJson.toJson(expense);
      data.remove('id');
      await db.transaction((txn) async {
        lastId = await txn.insert('workshop_expenses', data);
      });
      data['id'] = lastId;

      return Right(TransformExpenseJson.fromJson(data));
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<Either<RespositoryException, Unit>> update(
      ExpenseModel expense) async {
    try {
      final data = TransformExpenseJson.toJson(expense);
      final db = await DataBase.openDatabase();
      await db.transaction((txn) async {
        await txn.update('workshop_expenses', data,
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
        await txn.delete('workshop_expenses', where: 'id = ?', whereArgs: [id]);
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
          .query('workshop_expenses', where: 'type = ?', whereArgs: [type]);

      return Right(expenses);
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<Either<RespositoryException, ExpenseModel?>> findMaxByType(
      String type) async {
    try {
      final db = await DataBase.openDatabase();
      final expenses = await db.rawQuery(
          "SELECT * FROM workshop_expenses WHERE type = '$type' ORDER BY id DESC LIMIT 1");

      return Right(
        expenses.isNotEmpty
            ? ExpenseModel(
                type: expenses[0]['type'] as String,
                value: expenses[0]['value'] as double,
                date: expenses[0]['date'] as String,
                methodPayment: expenses[0]['method_payment'] as String,
                observation: expenses[0]['observation'] as String,
              )
            : null,
      );
    } catch (_) {
      return Left(RespositoryException());
    }
  }
}
