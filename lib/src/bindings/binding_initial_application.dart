import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/budget/budget_controller.dart';
import 'package:js_budget/src/modules/budget/pricing/pricing_controller.dart';
import 'package:js_budget/src/modules/expenses/fixed_expenses/fixed_expense_controller.dart';
import 'package:js_budget/src/modules/order/order_controller.dart';
import 'package:js_budget/src/modules/profile/profile_controller.dart';
import 'package:js_budget/src/repositories/budget/budget_repository.dart';
import 'package:js_budget/src/repositories/budget/budget_repository_impl.dart';
import 'package:js_budget/src/repositories/expense/fixed_expense/fixed_repository.dart';
import 'package:js_budget/src/repositories/expense/fixed_expense/fixed_repository_impl.dart';
import 'package:js_budget/src/repositories/find_cep/find_cep_repository.dart';
import 'package:js_budget/src/repositories/find_cep/find_cep_repository_impl.dart';
import 'package:js_budget/src/repositories/order/order_repository.dart';
import 'package:js_budget/src/repositories/order/order_repository_impl.dart';
import 'package:js_budget/src/repositories/profile/profile_repository.dart';
import 'package:js_budget/src/repositories/profile/profile_repository_impl.dart';
import 'package:js_budget/src/utils/find_cep_controller.dart';

class BindingInitialApplication extends ApplicationBindings {
  @override
  List<Bind<Object>> bindings() => [
        Bind.lazySingleton((i) => PricingController()),
        Bind.lazySingleton<ProfileRepository>((i) => ProfileRepositoryImpl()),
        Bind.lazySingleton((i) => ProfileController(profileRepository: i())),
        Bind.lazySingleton<FindCepRepository>((i) => FindCepRepositoryImpl()),
        Bind.lazySingleton((i) => FindCepController(findCepRepository: i())),
        Bind.lazySingleton<OrderRepository>((i) => OrderRepositoryImpl()),
        Bind.lazySingleton((i) => OrderController(orderRepository: i())),
        Bind.lazySingleton<FixedExpenseRepository>(
            (i) => FixedExpenseRepositoryImpl()),
        Bind.lazySingleton(
            (i) => FixedExpenseController(expenseRepository: i())),
        Bind.lazySingleton<BudgetRepository>((i) => BudgetRepositoryImpl()),
        Bind.lazySingleton((i) => BudgetController(budgetRepository: i()))
      ];
}
