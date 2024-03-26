import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/models/address_model.dart';

abstract interface class FindCepRepository {
  Future<Either<RespositoryException, AddressModel>> findCep(String numberCep);
}
