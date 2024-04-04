import 'package:js_budget/src/config/db/database.dart';
import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/order_model.dart';
import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/models/service_model.dart';
import 'package:js_budget/src/repositories/item_order/items_order_repository_impl.dart';
import 'package:js_budget/src/repositories/order/order_repository.dart';
import 'package:js_budget/src/repositories/order/transform_order_json.dart';

class OrderRepositoryImpl implements OrderRepository {
  final ItemsOrderRepositoryImpl _itemsOrderRepositoryImpl =
      ItemsOrderRepositoryImpl();
  final List<ProductModel> _products = [];
  final List<ServiceModel> _services = [];

  @override
  Future<Either<RespositoryException, OrderModel>> register(
      OrderModel order) async {
    try {
      final db = await DataBase.openDatabase();
      int lastOrderId = 0;
      await db.transaction((txn) async {
        lastOrderId = await txn.insert(
            'orders', {'date': order.date, 'client_id': order.client.id});

        if (order.items.products != null) {
          for (var product in order.items.products!) {
            int lastIdProduct = await _itemsOrderRepositoryImpl.saveProduct(
                txn, product, lastOrderId);

            _products.add(ProductModel(
              id: lastIdProduct,
              name: product.name,
              description: product.description,
              unit: product.unit,
            ));
          }
        }

        if (order.items.services != null) {
          for (var service in order.items.services!) {
            int lastIdService = await _itemsOrderRepositoryImpl.saveService(
                txn, service, lastOrderId);

            _services.add(ServiceModel(
                id: lastIdService, description: service.description));
          }
        }
      });

      return Right(TransformOrderJson.fromJson({
        'id': lastOrderId,
        'date': order.date,
        'client': {'id': order.client.id, 'name': order.client.name},
        'products': _products.isNotEmpty
            ? _products
                .map((product) => {
                      'id': product.id,
                      'name': product.name,
                      'unit': product.unit,
                      'description': product.description
                    })
                .toList()
            : null,
        // 'services': _services.isNotEmpty ? _services : null
      }));
    } catch (e) {
      print(e.toString());
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
          'SELECT orders.id, orders.date, clients.name as name_client, items_orders.product_id, products.name as name_product, items_orders.service_id, services.description FROM orders INNER JOIN clients ON clients.id = orders.client_id INNER JOIN items_orders ON items_orders.order_id = orders.id LEFT JOIN products ON products.id = items_orders.product_id LEFT JOIN services on services.id = items_orders.service_id');

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
