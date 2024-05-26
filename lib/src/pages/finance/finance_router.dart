import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/pages/finance/summary/summary_personal_expense_page.dart';

class FinanceRouter extends FlutterGetItPageRouter {
  const FinanceRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [];

  @override
  String get routeName => '/finance/summary';

  @override
  WidgetBuilder get view => (_) => const SummaryPersonalExpensePage();
}
