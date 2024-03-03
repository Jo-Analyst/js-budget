import 'package:flutter/material.dart';
import 'package:js_budget/src/app/app.dart';
import 'package:js_budget/src/pages/client/client_detail_page.dart';
import 'package:js_budget/src/pages/client/client_registration_page.dart';
import 'package:js_budget/src/pages/client/clients_list_page.dart';
import 'package:js_budget/src/pages/home/budget_details/budget_details_page.dart';
import 'package:js_budget/src/pages/splash/splash_page.dart';
import 'package:js_budget/src/pages/summary/summary_page.dart';
import 'package:js_budget/src/routes/route.dart';
import 'package:js_budget/src/themes/light_theme.dart';

void main() {
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
        RouterPage.registerClients: (_) => const ClientRegistrationPage(),
        RouterPage.clientDetail: (_) => const ClientDetailPage(),
      },
    );
  }
}
