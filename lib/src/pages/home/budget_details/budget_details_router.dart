import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/pages/home/budget_details/budget_detail_controller.dart';
import 'package:js_budget/src/pages/home/budget_details/budget_details_page.dart';
import 'package:js_budget/src/repositories/budget_items/budget_item_repository.dart';
import 'package:js_budget/src/repositories/budget_items/budget_item_repository_impl.dart';

class BudgetDetailsRouter extends FlutterGetItPageRouter {
  const BudgetDetailsRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<BudgetItemRepository>(
            (i) => BudgetItemRepositoryImpl()),
            Bind.lazySingleton((i) => BudgetDetailController(budgetItemRepository: i()))
      ];

  @override
  String get routeName => '/budge-details';

  @override
  WidgetBuilder get view => (_) => const BudgetDetailsPage();
}
