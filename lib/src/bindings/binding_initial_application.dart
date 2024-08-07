import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/backup/backup_controller.dart';
import 'package:js_budget/src/modules/budget/budget_controller.dart';
import 'package:js_budget/src/modules/budget/pricing/pricing_controller.dart';
import 'package:js_budget/src/modules/expenses/personal_expenses/personal_expense_controller.dart';
import 'package:js_budget/src/modules/expenses/workshop_expenses/workshop_expense_controller.dart';
import 'package:js_budget/src/modules/finance/finance_controller.dart';
import 'package:js_budget/src/modules/material/material_controller.dart';
import 'package:js_budget/src/modules/order/order_controller.dart';
import 'package:js_budget/src/modules/payment/payment_history/payment_history_controller.dart';
import 'package:js_budget/src/modules/profile/profile_controller.dart';
import 'package:js_budget/src/repositories/budget/budget_repository.dart';
import 'package:js_budget/src/repositories/budget/budget_repository_impl.dart';
import 'package:js_budget/src/repositories/expense/personal_expense/personal_repository.dart';
import 'package:js_budget/src/repositories/expense/personal_expense/personal_repository_impl.dart';
import 'package:js_budget/src/repositories/expense/workshop_expense/workshop_repository.dart';
import 'package:js_budget/src/repositories/expense/workshop_expense/workshop_repository_impl.dart';
import 'package:js_budget/src/repositories/find_cep/find_cep_repository.dart';
import 'package:js_budget/src/repositories/find_cep/find_cep_repository_impl.dart';
import 'package:js_budget/src/repositories/history_payment/payment_history_repository.dart';
import 'package:js_budget/src/repositories/history_payment/payment_history_repository_impl.dart';
import 'package:js_budget/src/repositories/material/material_repository.dart';
import 'package:js_budget/src/repositories/material/material_repository_impl.dart';
import 'package:js_budget/src/repositories/order/order_repository.dart';
import 'package:js_budget/src/repositories/order/order_repository_impl.dart';
import 'package:js_budget/src/repositories/profile/profile_repository.dart';
import 'package:js_budget/src/repositories/profile/profile_repository_impl.dart';
import 'package:js_budget/src/utils/find_cep_controller.dart';

class BindingInitialApplication extends ApplicationBindings {
  @override
  List<Bind<Object>> bindings() => [
        Bind.lazySingleton((i) => BackupController()),
        Bind.lazySingleton((i) => PricingController()),
        Bind.lazySingleton<ProfileRepository>((i) => ProfileRepositoryImpl()),
        Bind.lazySingleton((i) => ProfileController(profileRepository: i())),
        Bind.lazySingleton<FindCepRepository>((i) => FindCepRepositoryImpl()),
        Bind.lazySingleton((i) => FindCepController(findCepRepository: i())),
        Bind.lazySingleton<OrderRepository>((i) => OrderRepositoryImpl()),
        Bind.lazySingleton((i) => OrderController(orderRepository: i())),
        Bind.lazySingleton<WorkshopExpenseRepository>(
            (i) => WorkshopExpenseRepositoryImpl()),
        Bind.lazySingleton(
            (i) => WorkshopExpenseController(expenseRepository: i())),
        Bind.lazySingleton<BudgetRepository>((i) => BudgetRepositoryImpl()),
        Bind.lazySingleton((i) => BudgetController(budgetRepository: i())),
        Bind.lazySingleton<PersonalExpenseRepository>(
            (i) => PersonalExpenseRepositoryImpl()),
        Bind.lazySingleton(
            (i) => PersonalExpenseController(expenseRepository: i())),
        Bind.lazySingleton<PaymentHistoryRepository>(
            (i) => PaymentHistoryRepositoryImpl()),
        Bind.lazySingleton(
            (i) => PaymentHistoryController(paymentHistoryRepository: i())),
        Bind.lazySingleton((i) => FinanceController()),
        Bind.lazySingleton<MaterialRepository>((i) => MaterialRepositoryImpl()),
        Bind.lazySingleton((i) => MaterialController(materialRepository: i())),
      ];
}
