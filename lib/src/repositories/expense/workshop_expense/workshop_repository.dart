import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/expense_model.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class WorkshopExpenseRepository {
  Future<Either<RespositoryException, ExpenseModel>> register(
      ExpenseModel expenseModel);
  Future<Either<RespositoryException, Unit>> update(ExpenseModel expenseModel);
  Future<void> updateByMaterialIdAndDate(Transaction txn, ExpenseModel expense, String dateOfLastPurchase);
  Future<Either<RespositoryException, Unit>> delete(int id);
  Future<Either<RespositoryException, List<Map<String, dynamic>>>> findAll();
  Future<Either<RespositoryException, List<Map<String, dynamic>>>>
      findByDescription(String description);
  Future<Either<RespositoryException, ExpenseModel?>> findMaxByDescription(
      String type);
}
