import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/budget_model.dart';
import 'package:js_budget/src/models/material_items_budget_model.dart';

abstract interface class BudgetRepository {
  Future<Either<RespositoryException, BudgetModel>> save(BudgetModel budget);
  Future<int> findByOrderId(int orderId);
  Future<Either<RespositoryException, List<Map<String, dynamic>>>> findAll();
  Future<Either<RespositoryException, Unit>> deleteBudget(
      int budgetId, int orderId);
  Future<Either<RespositoryException, Unit>> changeStatusAndMaterial(
      String status, int budgetId, String? approvalDate,
      {required List<MaterialItemsBudgetModel> materials,
      bool? isDecrementation});
}
