import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/client_model.dart';

abstract interface class ClientRepository {
  Future<Either<RespositoryException, ClientModel>> register(
      ClientModel client);
  Future<Either<RespositoryException, Unit>> update(ClientModel client);
  Future<Either<RespositoryException, Unit>> delete(int id);
  Future<Either<RespositoryException, List<Map<String, dynamic>>>> findAll();
}
