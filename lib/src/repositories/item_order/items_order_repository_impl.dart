import 'package:js_budget/src/models/item_order_model.dart';
import 'package:sqflite/sqflite.dart';

import './items_order_repository.dart';

class ItemsOrderRepositoryImpl implements ItemsOrderRepository {
  @override
  Future<void> save(
      Transaction txn, ItemOrderModel itemOrder, int orderId) async {
    if (itemOrder.product != null) {
      for (var product in itemOrder.product!) {
        await txn.insert(
            'items_order', {'order_id': orderId, 'product_id': product.id});
      }
    }

    if (itemOrder.service != null) {
      for (var service in itemOrder.service!) {
        await txn.insert(
            'items_order', {'order_id': orderId, 'service_id': service.id});
      }
    }
  }
}
