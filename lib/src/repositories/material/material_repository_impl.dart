import 'package:js_budget/src/config/db/database.dart';
import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/expense_model.dart';
import 'package:js_budget/src/models/material_model.dart';
import 'package:js_budget/src/repositories/expense/workshop_expense/workshop_repository_impl.dart';
import 'package:js_budget/src/repositories/material/transform_material_json.dart';
import 'package:js_budget/src/repositories/material/material_repository.dart';
import 'package:sqflite/sqflite.dart';

class MaterialRepositoryImpl implements MaterialRepository {
  @override
  Future<Either<RespositoryException, Unit>> delete(int id) async {
    try {
      final db = await DataBase.openDatabase();
      await db.transaction((txn) async {
        await txn.delete('materials', where: 'id = ?', whereArgs: [id]);
      });

      return Right(unit);
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<Either<RespositoryException, List<Map<String, dynamic>>>>
      findAll() async {
    try {
      final db = await DataBase.openDatabase();
      final materials = await db.query('materials');

      return Right(materials);
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<Either<RespositoryException, MaterialModel>> register(
      MaterialModel material) async {
    try {
      int lastId = 0;
      final db = await DataBase.openDatabase();
      final data = TransformMaterialJson.toJson(material);
      data.remove('id');
      await db.transaction((txn) async {
        lastId = await txn.insert('materials', data);
        material.id = lastId;
        await _saveDataMaterialInExpense(txn, material);
      });
      data['id'] = lastId;

      return Right(TransformMaterialJson.fromJson(data));
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<Either<RespositoryException, Unit>> update(MaterialModel material,
      bool thereWillBeChangesOnlyInStock, int remainingQuantity) async {
    try {
      final data = TransformMaterialJson.toJson(material);
      final db = await DataBase.openDatabase();
      await db.transaction((txn) async {
        await txn.update('materials', data,
            where: 'id = ?', whereArgs: [material.id]);

        if (thereWillBeChangesOnlyInStock) {
          await _saveDataMaterialInExpense(txn, material,
              remainingQuantity: remainingQuantity);
        }
      });

      return Right(unit);
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  Future<void> _saveDataMaterialInExpense(
      Transaction txn, MaterialModel material,
      {int? remainingQuantity}) async {
    await WorkshopExpenseRepositoryImpl().save(
      txn,
      ExpenseModel(
        description: material.name,
        value: remainingQuantity == null
            ? material.quantity * material.price
            : remainingQuantity * material.price,
        date: material.dateOfLastPurchase.toString(),
        methodPayment: '',
        materialId: material.id,
      ),
    );
  }
}
