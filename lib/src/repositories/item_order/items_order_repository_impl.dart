import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/models/service_model.dart';
import 'package:sqflite/sqflite.dart';

import './items_order_repository.dart';

class ItemsOrderRepositoryImpl implements ItemsOrderRepository {
  @override
  Future<void> saveProduct(
      Transaction txn, List<ProductModel>? products, int orderId) async {
    if (products != null) {
      for (var product in products) {
        await txn.insert(
            'items_orders', {'order_id': orderId, 'product_id': product.id});
      }
    }
  }

  @override
  Future<void> saveService(
      Transaction txn, List<ServiceModel>? services, int orderId) async {
    if (services != null) {
      for (var service in services) {
        await txn.insert(
            'items_orders', {'order_id': orderId, 'service_id': service.id});
      }
    }
  }
}
