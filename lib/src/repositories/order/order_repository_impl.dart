import 'package:js_budget/src/config/db/database.dart';
import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/models/item_order_model.dart';
import 'package:js_budget/src/models/order_model.dart';
import 'package:js_budget/src/repositories/budget/budget_repository_impl.dart';
import 'package:js_budget/src/repositories/item_order/items_order_repository_impl.dart';
import 'package:js_budget/src/repositories/order/order_repository.dart';
import 'package:js_budget/src/repositories/order/transform_order_json.dart';
import 'package:sqflite/sqflite.dart';

class OrderRepositoryImpl implements OrderRepository {
  final _itemsOrderRepositoryImpl = ItemsOrderRepositoryImpl();

  @override
  Future<Either<RespositoryException, OrderModel>> register(
      OrderModel order) async {
    final List<ItemOrderModel> items = [];
    try {
      final db = await DataBase.openDatabase();
      int lastOrderId = 0;
      await db.transaction((txn) async {
        lastOrderId = await txn.insert(
            'orders', {'date': order.date, 'client_id': order.client.id});

        for (var item in order.items) {
          int lastIdItemOrder = await _itemsOrderRepositoryImpl.save(
              txn, item.product, item.service, lastOrderId);
          items.add(
            ItemOrderModel(
              quantityProduct: item.product?.quantity,
              quantityService: item.service?.quantity,
              id: lastIdItemOrder,
              product: item.product,
              service: item.service,
            ),
          );
        }
      });

      return Right(TransformOrderJson.fromJson({
        'id': lastOrderId,
        'date': order.date,
        'client': {'id': order.client.id, 'name': order.client.name},
        'items': items
      }));
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<Either<RespositoryException, int>> delete(int id) async {
    try {
      int budgetId = await BudgetRepositoryImpl().findByOrderId(id);
      final db = await DataBase.openDatabase();
      await db.transaction((txn) async {
        await BudgetRepositoryImpl().delete(txn, budgetId);
        await txn.delete('orders', where: 'id = ?', whereArgs: [id]);
        await _itemsOrderRepositoryImpl.delete(txn, id);
      });

      return Right(budgetId);
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<Either<RespositoryException, List<Map<String, dynamic>>>>
      findAll() async {
    try {
      final db = await DataBase.openDatabase();
      final data = await db.rawQuery(
          'SELECT orders.id AS order_id, orders.date, orders.status, orders.client_id, clients.name AS client_name, items_orders.id AS item_order_id, items_orders.quantity_product, items_orders.quantity_service, items_orders.product_id, products.name as name_product, products.description, products.unit, items_orders.service_id, services.description, services.price FROM orders INNER JOIN clients ON clients.id = orders.client_id INNER JOIN items_orders ON items_orders.order_id = orders.id LEFT JOIN products ON products.id = items_orders.product_id LEFT JOIN services on services.id = items_orders.service_id');

      return Right(data);
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<void> changeStatusOrder(Transaction txn, int orderId) async {
    txn.update('orders', {'status': 'Orçamento criado'},
        where: 'id = ?', whereArgs: [orderId]);
  }
}
