import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/models/item_order_model.dart';
import 'package:js_budget/src/models/order_model.dart';
import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/models/service_model.dart';

class TransformOrderJson {
  static OrderModel fromJson(Map<String, dynamic> order) {
    return OrderModel(
      id: order['id'] as int,
      client: ClientModel(
        id: order['client']['id'],
        name: order['client']['name'],
      ),
      date: order['date'],
      items: order["items"],
    );
  }

  static List<OrderModel> fromJsonAfterDataSearch(
      List<Map<String, dynamic>> orders) {
    List<OrderModel> tempOrders = [];

    List<dynamic> itemsOrder = [];

    int? index;
    for (var order in orders) {
      int id = order['id'];

      if (tempOrders.isEmpty || tempOrders.any((element) => element.id != id)) {
        itemsOrder.clear();

        tempOrders.add(
          OrderModel(
            date: order['date'],
            client:
                ClientModel(id: order['client_id'], name: order['name_client']),
            items: [],
          ),
        );
        index = index != null ? index + 1 : 0;
      }

      final items = ItemOrderModel(
        id: order['item_order_id'],
        product: order['product_id'] != null
            ? ProductModel.fromJson({
                'id': order['product_id'],
                'name': order['name_product'],
                'description': order['name_product'] ?? '',
                'unit': order['unit']
              })
            : null,
        service: order['service_id'] != null
            ? ServiceModel.fromJson({
                'id': order['service_id'],
                'description': order['description']
              })
            : null,
      );

      tempOrders[index!].items.add(items);
    }

    return tempOrders;
  }
}
