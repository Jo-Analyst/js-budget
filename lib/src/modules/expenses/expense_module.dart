import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/expenses/fixed_expenses/fixed_expense_detail/fixed_expense_details_page.dart';
import 'package:js_budget/src/modules/expenses/fixed_expenses/fixed_expense_form/fixed_expense_form_page.dart';
import 'package:js_budget/src/modules/expenses/fixed_expenses/fixed_expense_page.dart';
import 'package:js_budget/src/modules/expenses/personal_expenses/personal_expense_controller.dart';
import 'package:js_budget/src/modules/expenses/personal_expenses/personal_expense_details/personal_expense_details_page.dart';
import 'package:js_budget/src/modules/expenses/personal_expenses/personal_expense_form/personal_expense_form_page.dart';
import 'package:js_budget/src/modules/expenses/personal_expenses/personal_expense_page.dart';
import 'package:js_budget/src/repositories/personal_expense/personal_repository.dart';
import 'package:js_budget/src/repositories/personal_expense/personal_repository_impl.dart';

class ExpenseModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<PersonalExpenseRepository>(
            (i) => PersonalExpenseRepositoryImpl()),
        Bind.lazySingleton(
            (i) => PersonalExpenseController(personalExpenseRepository: i()))
      ];
  @override
  String get moduleRouteName => '/expense';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/fixed': (_) => const FixedExpensePage(),
        '/fixed/register': (_) => const FixedExpenseFormPage(),
        '/fixed/details': (_) => const FixedExpenseDetailsPage(),
        '/personal': (_) => const PersonalExpensePage(),
        '/personal/register': (_) => const PersonalExpenseFormPage(),
        '/personal/details': (_) => const PersonalExpenseDetailsPage(),
      };
}
