import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/models/service_model.dart';
import 'package:sqflite/sqflite.dart';

import './items_order_repository.dart';

class ItemsOrderRepositoryImpl implements ItemsOrderRepository {
  @override
  Future<int> save(Transaction txn, ProductModel? product,
      ServiceModel? service, int orderId) async {
    return txn.insert('items_orders', {
      'order_id': orderId,
      'product_id': product?.id,
      'service_id': service?.id,
    });
  }
}
