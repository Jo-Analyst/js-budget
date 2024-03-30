import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/service_model.dart';

abstract interface class ServiceRepository {
  Future<Either<RespositoryException, ServiceModel>> register(
      ServiceModel service);
  Future<Either<RespositoryException, Unit>> update(ServiceModel service);
  Future<Either<RespositoryException, Unit>> delete(int id);
  Future<Either<RespositoryException, List<Map<String, dynamic>>>> findAll();
}
