import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/order/order_controller.dart';
import 'package:js_budget/src/modules/order/order_detail/order_detail_page.dart';
import 'package:js_budget/src/modules/order/order_form/order_form_page.dart';
import 'package:js_budget/src/modules/order/order_page.dart';
import 'package:js_budget/src/repositories/order/order_repository.dart';
import 'package:js_budget/src/repositories/order/order_repository_impl.dart';

class OrderModules extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<OrderRepository>((i) => OrderRepositoryImpl()),
        Bind.lazySingleton((i) => OrderController(orderRepository: i()))
      ];

  @override
  String get moduleRouteName => '/order';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/': (_) => const OrderPage(),
        '/details': (_) => const OrderDetailPage(),
        '/form': (_) => const OrderFormPage(),
      };
}
