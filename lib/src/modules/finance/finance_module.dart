import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/finance/summary/summary_personal_expense_page.dart';
import 'package:js_budget/src/modules/finance/summary/summary_workshop_budget_page.dart';
import 'package:js_budget/src/modules/finance/summary/summary_workshop_expense_page.dart';

class FinanceModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [];

  @override
  String get moduleRouteName => '/finance';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/personal/summary': (_) => const SummaryPersonalExpensePage(),
        '/workshop/summary': (_) => const SummaryWorkshopExpensePage(),
        '/workshop/budget': (_) => const SummaryWorkshopBudgetPage(),
      };
}
