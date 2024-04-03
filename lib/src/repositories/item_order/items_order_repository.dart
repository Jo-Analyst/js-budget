import 'package:js_budget/src/models/item_order_model.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class ItemsOrderRepository {
  Future<void> save(Transaction txn, ItemOrderModel itemOrder, int orderId);
}
