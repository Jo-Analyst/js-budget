import 'package:flutter/material.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/models/item_order_model.dart';
import 'package:js_budget/src/models/order_model.dart';
import 'package:js_budget/src/modules/order/order_form/order_form_page.dart';

mixin OrderFormController on State<OrderFormPage> {
  final dateEC = TextEditingController();
  final observationEC = TextEditingController();

  void initializeForm(OrderModel orderModel) {
    dateEC.text = orderModel.date;
    observationEC.text = orderModel.observation ?? '';
  }

  void disposeForm() {
    dateEC.dispose();
    observationEC.dispose();
  }

  OrderModel saveForm(int id, ClientModel client, List<ItemOrderModel> items) {
    return OrderModel(
      observation: observationEC.text.trim(),
      client: client, date: DateTime.now().toIso8601String(), items: items,
      // items: [ItemOrderModel(product: products, service: services)],
    );
  }
}
