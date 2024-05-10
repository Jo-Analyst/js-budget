import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/models/budget_model.dart';

abstract interface class BudgetRepository {
  Future<Either<RespositoryException, BudgetModel>> save(BudgetModel budget);
  Future<Either<RespositoryException, List<Map<String, dynamic>>>> findAll();
}
