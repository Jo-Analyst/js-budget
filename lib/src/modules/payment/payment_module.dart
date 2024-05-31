import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/payment/checkout_counter_page.dart';
import 'package:js_budget/src/modules/payment/payment_controller.dart';
import 'package:js_budget/src/modules/profile/profile_form/payment_page.dart';
import 'package:js_budget/src/repositories/payment_repository.dart';
import 'package:js_budget/src/repositories/payment_repository_impl.dart';

class PaymentModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<PaymentRepository>((i) => PaymentRepositoryImpl()),
        Bind.lazySingleton((i) => PaymentController(paymentRepository: i())),
      ];
  @override
  String get moduleRouteName => '/payment';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/': (_) => const PaymentPage(),
        '/checkout-counter': (_) => const CheckoutCounterPage(),
      };
}
