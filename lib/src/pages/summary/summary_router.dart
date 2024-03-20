import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/pages/summary/summary_page.dart';

class FinanceRouter extends FlutterGetItPageRouter {
  const FinanceRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [];

  @override
  String get routeName => '/summary';

  @override
  WidgetBuilder get view => (_) => const SummaryPage();
}
