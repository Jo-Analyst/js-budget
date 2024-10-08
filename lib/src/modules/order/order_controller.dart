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

  final ListSignal<OrderModel> _data = ListSignal<OrderModel>([]);
  ListSignal<OrderModel> get data => _data;
  final model = signal<OrderModel?>(null);

  final OrderRepository _orderRepository;

  bool validateFields(ClientModel? client, List<ProductModel> products,
      List<ServiceModel> services) {
    bool isValid =
        client != null && (products.isNotEmpty || services.isNotEmpty);

    if (client == null) {
      showInfo('Informe o cliente no pedido');
    } else if (products.isEmpty && services.isEmpty) {
      showInfo('Informe o produto ou serviço no pedido');
    }
    return isValid;
  }

  Future<OrderModel?> save(OrderModel orderModel) async {
    final results = await _orderRepository.save(orderModel);
    OrderModel? model;

    switch (results) {
      case Right(value: OrderModel order):
        model = order;

        showSuccess('Pedido registrado com sucesso');
      case Left():
        showError(
          'Houver um erro ao registrar o pedido.',
        );
    }

    return model;
  }

  Future<bool> deleteOrder(int id) async {
    final results = await _orderRepository.delete(id);
    bool itWasExcluded = false;

    switch (results) {
      case Right():
        itWasExcluded = true;
        showSuccess('Pedido excluido com sucesso');
      case Left():
        showError(
          'Houver um erro ao excluir o pedido.',
        );
    }
    return itWasExcluded;
  }

  Future<void> findOrders() async {
    _data.clear();
    final results = await _orderRepository.findAll();

    switch (results) {
      case Right(value: List<Map<String, dynamic>> orders):
        _data.addAll(TransformOrderJson.fromJsonAfterDataSearch(orders));
      case Left():
        showError('Houver erro ao buscar os pedidos');
    }
  }

  bool validate(OrderModel order) {
    int quantityNulls = 0;
    for (var item in order.items) {
      if (item.product == null && item.service == null) {
        quantityNulls += 1;
      }
    }
    bool isValid = quantityNulls < order.items.length;
    if (!isValid) {
      showInfo('Não há produtos ou serviços na lista de pedidos');
    }

    return isValid;
  }
}
