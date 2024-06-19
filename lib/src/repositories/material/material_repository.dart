import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/material_items_budget_model.dart';
import 'package:js_budget/src/models/material_model.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class MaterialRepository {
  Future<Either<RespositoryException, MaterialModel>> register(
      MaterialModel material);
  Future<Either<RespositoryException, Unit>> update(MaterialModel material,
      bool addMaterialValuesToStock, String? dateOfLastPurchase);
  Future<Either<RespositoryException, Unit>> delete(int id);
  Future<Either<RespositoryException, List<Map<String, dynamic>>>> findAll();
  Future<void> changeStockQuantity(
      Transaction txn, List<MaterialItemsBudgetModel> materials,
      {required bool isDecrementation});
}
