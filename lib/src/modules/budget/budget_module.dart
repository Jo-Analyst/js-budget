import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/budget/budget_page.dart';
import 'package:js_budget/src/modules/budget/item_budget/item_budget_controller.dart';
import 'package:js_budget/src/modules/budget/pricing/preview_page_for_confirmation.dart';
import 'package:js_budget/src/modules/budget/pricing/pricing_form_page.dart';
import 'package:js_budget/src/modules/budget/screen_success/budget_success_page.dart';

class BudgetModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton((i) => ItemBudgetController()),
      ];

  @override
  String get moduleRouteName => '/budget';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/form': (_) => const BudgetPage(),
        '/pricing': (_) => const PricingFormPage(),
        '/pricing/preview': (_) => const PreviewPageForConfirmation(),
        '/screen-success': (_) => const BudgetSuccessPage()
      };
}
