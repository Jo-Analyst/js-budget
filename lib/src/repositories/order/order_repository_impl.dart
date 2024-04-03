import 'package:js_budget/src/config/db/database.dart';
import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/order_model.dart';
import 'package:js_budget/src/repositories/item_order/items_order_repository_impl.dart';
import 'package:js_budget/src/repositories/order/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final ItemsOrderRepositoryImpl _itemsOrderRepositoryImpl =
      ItemsOrderRepositoryImpl();

  @override
  Future<Either<RespositoryException, OrderModel>> register(
      OrderModel order) async {
    try {
      final db = await DataBase.openDatabase();
      int lastId = 0;
      await db.transaction((txn) async {
        lastId = await txn.insert(
            'orders', {'date': order.date, 'client_id': order.client.id});

        for (var item in order.items) {
          _itemsOrderRepositoryImpl.save(txn, item, lastId);
        }
      });

      return Right(order);
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<Either<RespositoryException, Unit>> delete(int id) {
    throw UnimplementedError();
  }

  @override
  Future<Either<RespositoryException, List<Map<String, dynamic>>>> findAll() {
    throw UnimplementedError();
  }

  @override
  Future<Either<RespositoryException, Unit>> update(OrderModel order) {
    throw UnimplementedError();
  }
}
