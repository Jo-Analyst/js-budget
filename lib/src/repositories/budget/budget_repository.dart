import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/budget_model.dart';

abstract interface class BudgetRepository {
  Future<Either<RespositoryException, Unit>> save(BudgetModel order);
}
