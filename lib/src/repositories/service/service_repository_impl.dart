import 'package:js_budget/src/config/db/database.dart';
import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/service_model.dart';
import 'package:js_budget/src/repositories/service/transform_service_json.dart';
import 'package:js_budget/src/repositories/service/service_repository.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  @override
  Future<Either<RespositoryException, Unit>> delete(int id) async {
    try {
      final db = await DataBase.openDatabase();
      await db.transaction((txn) async {
        await txn.delete('services', where: 'id = ?', whereArgs: [id]);
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
      final services = await db.query('services');

      return Right(services);
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<Either<RespositoryException, ServiceModel>> register(
      ServiceModel service) async {
    try {
      int lastId = 0;
      final db = await DataBase.openDatabase();
      final data = TransformJson.toJson(service);
      data.remove('id');
      await db.transaction((txn) async {
        lastId = await txn.insert('services', data);
      });
      data['id'] = lastId;

      return Right(TransformJson.fromJson(data));
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<Either<RespositoryException, Unit>> update(
      ServiceModel service) async {
    try {
      final data = TransformJson.toJson(service);
      final db = await DataBase.openDatabase();
      await db.transaction((txn) async {
        await txn
            .update('services', data, where: 'id = ?', whereArgs: [service.id]);
      });

      return Right(unit);
    } catch (_) {
      return Left(RespositoryException());
    }
  }
}
