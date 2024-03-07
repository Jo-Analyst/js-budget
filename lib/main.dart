import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:js_budget/src/app/app.dart';
import 'package:js_budget/src/pages/client/client_detail_page.dart';
import 'package:js_budget/src/pages/client/client_form_page.dart';
import 'package:js_budget/src/pages/client/clients_list_page.dart';
import 'package:js_budget/src/pages/fixed_expenses/fixed_expense_form_page.dart';
import 'package:js_budget/src/pages/home/budget_details/budget_details_page.dart';
import 'package:js_budget/src/pages/material/furniture_materials_list_page.dart';
import 'package:js_budget/src/pages/material/material_detail/material_details_page.dart';
import 'package:js_budget/src/pages/material/material_form_page.dart';
import 'package:js_budget/src/pages/personal_expenses/personal_expense_form_page.dart';
import 'package:js_budget/src/pages/splash/splash_page.dart';
import 'package:js_budget/src/pages/summary/summary_page.dart';
import 'package:js_budget/src/routes/route.dart';
import 'package:js_budget/src/themes/light_theme.dart';

void main() async {
  await initializeDateFormatting('pt_BR', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JS Planejar',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      routes: {
        RouterPage.myApp: (_) => const App(),
        RouterPage.splash: (_) => const SplashPage(),
        RouterPage.budgeDetails: (_) => const BudgetDetailsPage(),
        RouterPage.summary: (_) => const SummaryPage(),
        RouterPage.clients: (_) => const ClientListPage(),
        RouterPage.clientForm: (_) => const ClientFormPage(),
        RouterPage.clientDetail: (_) => const ClientDetailPage(),
        RouterPage.material: (_) => const FurnitureMaterialsList(),
        RouterPage.materialForm: (_) => const MaterialFormPage(),
        RouterPage.materialDetail: (_) => const MaterialDetailsPage(),
        RouterPage.fixedExpense: (_) => const FixedExpenseFormPage(),
        RouterPage.personalExpense: (_) => const PersonalExpenseFormPage(),
      },
    );
  }
}
