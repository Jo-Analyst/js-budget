import 'package:js_budget/src/models/item_order_model.dart';
import 'package:sqflite/sqflite.dart';

import './items_order_repository.dart';

class ItemsOrderRepositoryImpl implements ItemsOrderRepository {
  @override
  Future<void> save(
      Transaction txn, ItemOrderModel itemOrder, int orderId) async {
    if (itemOrder.products != null) {
      for (var product in itemOrder.products!) {
        await txn.insert(
            'items_orders', {'order_id': orderId, 'product_id': product.id});
      }
    }

    if (itemOrder.services != null) {
      for (var service in itemOrder.services!) {
        await txn.insert(
            'items_orders', {'order_id': orderId, 'service_id': service.id});
      }
    }
  }
}
