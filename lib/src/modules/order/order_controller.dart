// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/helpers/message.dart';
import 'package:js_budget/src/models/order_model.dart';
import 'package:js_budget/src/repositories/order/order_repository.dart';
import 'package:signals/signals_flutter.dart';

class OrderController with Messages {
  OrderController({
    required OrderRepository orderRepository,
  }) : _orderRepository = orderRepository;

  final _data = ListSignal<OrderModel>([]);
  ListSignal<OrderModel> get data => _data;

  final OrderRepository _orderRepository;

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
}
