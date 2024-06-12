import 'package:js_budget/src/config/db/database.dart';
import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/expense_model.dart';

import 'package:js_budget/src/repositories/expense/workshop_expense/workshop_repository.dart';
import 'package:js_budget/src/repositories/expense/transform_expense_json.dart';
import 'package:sqflite/sqflite.dart';

class WorkshopExpenseRepositoryImpl implements WorkshopExpenseRepository {
  @override
  Future<Either<RespositoryException, List<Map<String, dynamic>>>>
      findAll() async {
    try {
      final db = await DataBase.openDatabase();
      final expenses =
          await db.query('workshop_expenses', where: 'material_id IS NULL');

      return Right(expenses);
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  Future<void> save(Transaction txn, ExpenseModel expense) async {
    final data = TransformExpenseJson.toJson(expense);
    data.remove('id');
    await txn.insert('workshop_expenses', data);
  }

  @override
  Future<Either<RespositoryException, ExpenseModel>> register(
      ExpenseModel expense) async {
    try {
      int lastId = 0;
      final db = await DataBase.openDatabase();
      final data = TransformExpenseJson.toJson(expense);
      data.remove('id');
      data.remove('material_id');
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
      data.remove('material_id');
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
  Future<void> updateByMaterialIdAndDate(
      Transaction txn, ExpenseModel expense) async {
    final data = TransformExpenseJson.toJson(expense);
    await txn.update('workshop_expenses', data,
        where: 'material_id = ? AND date = ?',
        whereArgs: [expense.materialId, expense.date]);
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
  Future<Either<RespositoryException, List<Map<String, dynamic>>>>
      findByDescription(String description) async {
    try {
      final db = await DataBase.openDatabase();
      final expenses = await db.query('workshop_expenses',
          where: 'description = ?', whereArgs: [description]);

      return Right(expenses);
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<Either<RespositoryException, ExpenseModel?>> findMaxByDescription(
      String description) async {
    try {
      final db = await DataBase.openDatabase();
      final expenses = await db.rawQuery(
          "SELECT * FROM workshop_expenses WHERE description = '$description' ORDER BY id DESC LIMIT 1");

      return Right(
        expenses.isNotEmpty
            ? ExpenseModel(
                description: expenses[0]['description'] as String,
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
