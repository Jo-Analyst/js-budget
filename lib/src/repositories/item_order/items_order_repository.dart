import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/models/service_model.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class ItemsOrderRepository {
  Future<int> save(
      Transaction txn, ProductModel product, ServiceModel service, int orderId);
}
