import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/expenses/workshop_expenses/workshop_expense_detail/workshop_expense_details_page.dart';
import 'package:js_budget/src/modules/expenses/workshop_expenses/workshop_expense_form/workshop_expense_form_page.dart';
import 'package:js_budget/src/modules/expenses/workshop_expenses/workshop_expense_page.dart';
import 'package:js_budget/src/modules/expenses/personal_expenses/personal_expense_details/personal_expense_details_page.dart';
import 'package:js_budget/src/modules/expenses/personal_expenses/personal_expense_form/personal_expense_form_page.dart';
import 'package:js_budget/src/modules/expenses/personal_expenses/personal_expense_page.dart';

class ExpenseModule extends FlutterGetItModule {
  @override
  String get moduleRouteName => '/expense';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/workshop': (_) => const WorkshopExpensePage(),
        '/workshop/form': (_) => const WorkshopExpenseFormPage(),
        '/workshop/details': (_) => const WorkshopExpenseDetailsPage(),
        '/personal': (_) => const PersonalExpensePage(),
        '/personal/form': (_) => const PersonalExpenseFormPage(),
        '/personal/details': (_) => const PersonalExpenseDetailsPage(),
      };
}
