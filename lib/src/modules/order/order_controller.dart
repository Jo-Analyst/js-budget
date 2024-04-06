// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/helpers/message.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/models/order_model.dart';
import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/models/service_model.dart';
import 'package:js_budget/src/repositories/order/order_repository.dart';
import 'package:js_budget/src/repositories/order/transform_order_json.dart';
import 'package:signals/signals_flutter.dart';

class OrderController with Messages {
  OrderController({
    required OrderRepository orderRepository,
  }) : _orderRepository = orderRepository;

  final _data = ListSignal<OrderModel>([]);
  ListSignal<OrderModel> get data => _data;

  final OrderRepository _orderRepository;

  bool validateFields(ClientModel? client, List<ProductModel>? products,
      List<ServiceModel>? services) {
    bool isValid = client != null && (products != null || services != null);

    if (client == null) {
      showInfo('Informe o cliente no pedido');
    } else if (products == null && services == null) {
      showInfo('Informe o produto ou serviço no pedido');
    }
    return isValid;
  }

  Future<void> register(OrderModel order) async {
    final results = await _orderRepository.register(order);

    switch (results) {
      case Right(value: OrderModel order):
        data.add(order);
        showSuccess('Pedido registrado com sucesso');
      case Left():
        showError('Houver um erro ao registrar o pedido.');
    }
  }

  Future<void> findOrders() async {
    _data.clear();
    final results = await _orderRepository.findAll();

    switch (results) {
      case Right(value: List<Map<String, dynamic>> orders):
        _data.addAll(TransformOrderJson.fromJsonAfterDataSearch(orders));
      // for (var order in orders) {
      //   print(order);
      // }
      // for (var material in materials) {
      //   _data.add(TransformJson.fromJson(material));
      // }
      case Left():
        showError('Houver erro ao buscar os pedidos');
    }
  }
}
