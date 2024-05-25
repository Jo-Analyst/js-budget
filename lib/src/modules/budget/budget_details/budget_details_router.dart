import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/budget/budget_details/budget_details_page.dart';

class BudgetDetailsRouter extends FlutterGetItPageRouter {
  const BudgetDetailsRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [];

  @override
  String get routeName => '/budge-details';

  @override
  WidgetBuilder get view => (_) => const BudgetDetailsPage();
}
