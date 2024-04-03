import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/models/service_model.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class ItemsOrderRepository {
  Future<void> saveProduct(Transaction txn, List<ProductModel>? products, int orderId);
  Future<void> saveService(Transaction txn, List<ServiceModel>? services, int orderId);
}
