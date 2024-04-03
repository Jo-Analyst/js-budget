import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/models/item_order_model.dart';
import 'package:js_budget/src/models/material_model.dart';
import 'package:js_budget/src/models/order_model.dart';

class TransformJson {
  static Map<String, dynamic> toJson(MaterialModel material) {
    return {
      'id': material.id,
      'name': material.name,
      'type': material.type,
      'quantity': material.quantity,
      'unit': material.unit,
      'price': material.price,
      'date_of_last_purchase': material.dateOfLastPurchase,
      'observation': material.observation,
      'supplier': material.supplier,
    };
  }

  static OrderModel fromJson(Map<String, dynamic> order) {
    return OrderModel(
        id: order['id'] as int,
        client: ClientModel(id: order['client_id'], name: ''),
        date: order['date'],
        items: [
          ItemOrderModel(),
        ]
        // items: [{'products': [{''}]}],
        );
  }
}
