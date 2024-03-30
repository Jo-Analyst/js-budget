import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/product_model.dart';

abstract interface class ProductRepository {
  Future<Either<RespositoryException, ProductModel>> register(
      ProductModel product);
  Future<Either<RespositoryException, Unit>> update(ProductModel product);
  Future<Either<RespositoryException, Unit>> delete(int id);
  Future<Either<RespositoryException, List<Map<String, dynamic>>>> findAll();
}
