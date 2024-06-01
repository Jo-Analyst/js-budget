import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/models/service_model.dart';
import 'package:sqflite/sqflite.dart';

import 'items_order_repository.dart';

class ItemsOrderRepositoryImpl implements ItemsOrderRepository {
  @override
  Future<int> save(Transaction txn, ProductModel? product,
      ServiceModel? service, int orderId) async {
    return txn.insert('items_orders', {
      'order_id': orderId,
      'quantity_product': product?.quantity,
      'quantity_service': service?.quantity,
      'product_id': product?.id,
      'service_id': service?.id,
    });
  }

  @override
  Future<void> delete(Transaction txn, int orderId) async {
    await txn
        .delete('items_orders', where: 'order_id = ?', whereArgs: [orderId]);
  }
}
