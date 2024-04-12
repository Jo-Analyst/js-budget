import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/budget/budget_form/budget_form.dart';
import 'package:js_budget/src/modules/budget/budget_form/pricing_form/pricing_form_page.dart';

class BudgetModule extends FlutterGetItModule {
  @override
  String get moduleRouteName => '/budget';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/form': (_) => const BudgetForm(),
        '/pricing': (_) => const PricingFormPage()
      };
}
