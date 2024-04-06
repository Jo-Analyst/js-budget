import 'package:js_budget/src/config/db/database.dart';
import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/item_order_model.dart';
import 'package:js_budget/src/models/order_model.dart';
import 'package:js_budget/src/repositories/item_order/items_order_repository_impl.dart';
import 'package:js_budget/src/repositories/order/order_repository.dart';
import 'package:js_budget/src/repositories/order/transform_order_json.dart';

class OrderRepositoryImpl implements OrderRepository {
  final ItemsOrderRepositoryImpl _itemsOrderRepositoryImpl =
      ItemsOrderRepositoryImpl();
  final List<ItemOrderModel> _items = [];

  @override
  Future<Either<RespositoryException, OrderModel>> register(
      OrderModel order) async {
    try {
      final db = await DataBase.openDatabase();
      int lastOrderId = 0;
      await db.transaction((txn) async {
        lastOrderId = await txn.insert(
            'orders', {'date': order.date, 'client_id': order.client.id});

        for (var item in order.items) {
          int lastIdItemOrder = await _itemsOrderRepositoryImpl.save(
              txn, item.product, item.service, lastOrderId);
          _items.add(
            ItemOrderModel(
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
        'items': _items
      }));
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<Either<RespositoryException, Unit>> delete(int id) {
    throw UnimplementedError();
  }

  @override
  Future<Either<RespositoryException, List<Map<String, dynamic>>>>
      findAll() async {
    try {
      final db = await DataBase.openDatabase();
      final data = await db.rawQuery(
          'SELECT orders.id AS order_id, orders.date, orders.client_id, clients.name AS name_client, items_orders.id AS item_order_id, items_orders.product_id, products.name as name_product, products.description, products.unit, items_orders.service_id, services.description FROM orders INNER JOIN clients ON clients.id = orders.client_id INNER JOIN items_orders ON items_orders.order_id = orders.id LEFT JOIN products ON products.id = items_orders.product_id LEFT JOIN services on services.id = items_orders.service_id');

      return Right(data);
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<Either<RespositoryException, Unit>> update(OrderModel order) {
    throw UnimplementedError();
  }
}
