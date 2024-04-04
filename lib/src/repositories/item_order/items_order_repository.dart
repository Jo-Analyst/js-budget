import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/models/service_model.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class ItemsOrderRepository {
  Future<int> saveProduct(Transaction txn, ProductModel products, int orderId);
  Future<int> saveService(Transaction txn, ServiceModel services, int orderId);
}
