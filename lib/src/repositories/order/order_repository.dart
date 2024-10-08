import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/order_model.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class OrderRepository {
  Future<Either<RespositoryException, OrderModel>> save(OrderModel order);
  Future<Either<RespositoryException, Unit>> delete(int id);
  Future<Either<RespositoryException, List<Map<String, dynamic>>>> findAll();
  Future<void> changeStatusOrder(Transaction txn, int orderId);
}
