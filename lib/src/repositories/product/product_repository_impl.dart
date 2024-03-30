import 'package:js_budget/src/config/db/database.dart';
import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/repositories/product/transform_product_json.dart';
import 'package:js_budget/src/repositories/product/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<Either<RespositoryException, Unit>> delete(int id) async {
    try {
      final db = await DataBase.openDatabase();
      await db.transaction((txn) async {
        await txn.delete('products', where: 'id = ?', whereArgs: [id]);
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
      final products = await db.query('products');

      return Right(products);
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<Either<RespositoryException, ProductModel>> register(
      ProductModel product) async {
    try {
      int lastId = 0;
      final db = await DataBase.openDatabase();
      final data = TransformJson.toJson(product);
      data.remove('id');
      await db.transaction((txn) async {
        lastId = await txn.insert('products', data);
      });
      data['id'] = lastId;

      return Right(TransformJson.fromJson(data));
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<Either<RespositoryException, Unit>> update(
      ProductModel product) async {
    try {
      final data = TransformJson.toJson(product);
      final db = await DataBase.openDatabase();
      await db.transaction((txn) async {
        await txn
            .update('products', data, where: 'id = ?', whereArgs: [product.id]);
      });

      return Right(unit);
    } catch (_) {
      return Left(RespositoryException());
    }
  }
}
