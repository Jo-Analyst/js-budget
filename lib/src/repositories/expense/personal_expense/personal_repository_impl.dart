import 'dart:async';

import 'package:js_budget/src/config/db/database.dart';
import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/expense_model.dart';
import 'package:js_budget/src/repositories/expense/personal_expense/personal_repository.dart';
import 'package:js_budget/src/repositories/expense/transform_expense_json.dart';

class PersonalExpenseRepositoryImpl implements PersonalExpenseRepository {
  @override
  Future<Either<RespositoryException, List<Map<String, dynamic>>>>
      findAll() async {
    try {
      final db = await DataBase.openDatabase();
      final personalExpenses = await db.query('personal_expenses');

      return Right(personalExpenses);
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<Either<RespositoryException, ExpenseModel>> register(
      ExpenseModel personalExpense) async {
    try {
      int lastId = 0;
      final db = await DataBase.openDatabase();
      final data = TransformExpenseJson.toJson(personalExpense);
      data.remove('id');
      data.remove('material_id');
      await db.transaction((txn) async {
        lastId = await txn.insert('personal_expenses', data);
      });
      data['id'] = lastId;

      return Right(TransformExpenseJson.fromJson(data));
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<Either<RespositoryException, Unit>> update(
      ExpenseModel personalExpense) async {
    try {
      final data = TransformExpenseJson.toJson(personalExpense);
      final db = await DataBase.openDatabase();
      data.remove('material_id');
      await db.transaction((txn) async {
        await txn.update('personal_expenses', data,
            where: 'id = ?', whereArgs: [personalExpense.id]);
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
        await txn.delete('personal_expenses', where: 'id = ?', whereArgs: [id]);
      });

      return Right(unit);
    } catch (_) {
      return Left(RespositoryException());
    }
  }
}
