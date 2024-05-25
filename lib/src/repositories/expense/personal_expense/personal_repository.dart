import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/expense_model.dart';

abstract interface class PersonalExpenseRepository {
  Future<Either<RespositoryException, ExpenseModel>> register(
      ExpenseModel expenseModel);
  Future<Either<RespositoryException, Unit>> update(ExpenseModel expenseModel);
  Future<Either<RespositoryException, Unit>> delete(int id);
  Future<Either<RespositoryException, List<Map<String, dynamic>>>> findAll();
  // Future<Either<RespositoryException, List<Map<String, dynamic>>>>
      // findAllByDate(String date);
}
