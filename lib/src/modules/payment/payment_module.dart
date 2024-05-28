import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/profile/profile_form/payment_page.dart';

class PaymentModule extends FlutterGetItModule {
  @override
  String get moduleRouteName => '/payment';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/': (_) => const PaymentPage(),
      };
}
