import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/order/order_detail/order_detail_page.dart';
import 'package:js_budget/src/modules/order/order_form/order_form_page.dart';
import 'package:js_budget/src/modules/order/order_page.dart';

class OrderModule extends FlutterGetItModule {
  @override
  String get moduleRouteName => '/order';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/': (_) => const OrderPage(),
        '/details': (_) => const OrderDetailPage(),
        '/form': (_) => const OrderFormPage(),
      };
}
