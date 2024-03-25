import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/fixed_expense_model.dart';

abstract interface class FixedExpenseRepository {
  Future<Either<RespositoryException, FixedExpenseModel>> register(
      FixedExpenseModel expenseModel);
  Future<Either<RespositoryException, Unit>> update(
      FixedExpenseModel expenseModel);
  Future<Either<RespositoryException, Unit>> delete(int id);
  Future<Either<RespositoryException, List<Map<String, dynamic>>>> findAll();
}
