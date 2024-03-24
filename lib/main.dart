import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:js_budget/src/app/app.dart';
import 'package:js_budget/src/bindings/binding_initial_application.dart';
import 'package:js_budget/src/modules/client/client_module.dart';
import 'package:js_budget/src/modules/expenses/expense_module.dart';
import 'package:js_budget/src/modules/material/material_module.dart';
import 'package:js_budget/src/pages/summary/summary_router.dart';
import 'package:js_budget/src/pages/home/budget_details/budget_details_router.dart';
import 'package:js_budget/src/pages/profile/profile_router.dart';
import 'package:js_budget/src/pages/splash/splash_page.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:overlay_support/overlay_support.dart';

void main() async {
  await initializeDateFormatting('pt_BR', null);
  runApp(const OverlaySupport.global(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterGetIt(
      bindings: BindingInitialApplication(),
      pages: [
        FlutterGetItPageBuilder(
          page: (context) => const SplashPage(),
          path: '/',
        ),
        FlutterGetItPageBuilder(
          page: (context) => const App(),
          path: '/my-app',
        ),
        const ProfileRouter(),
        const BudgetDetailsRouter(),
        const FinanceRouter(),
      ],
      modules: [
        ClientModule(),
        MaterialModule(),
        ExpenseModule(),
      ],
      builder: (context, routes, flutterGetItNavObserver) {
        return MaterialApp(
          title: 'JS Planejar',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          routes: routes,
          //   routes: {
          //     RouterPage.myApp: (_) => const App(),
          //     RouterPage.splash: (_) => const SplashPage(),
          //     RouterPage.budgeDetails: (_) => const BudgetDetailsPage(),
          //     RouterPage.summary: (_) => const SummaryPage(),
          //     RouterPage.clients: (_) => const ClientPage(),
          //     RouterPage.clientForm: (_) => const ClientFormPage(),
          //     RouterPage.clientDetail: (_) => const ClientDetailPage(),
          //     RouterPage.clientContactPhone: (_) => const ContactPhonePage(),
          //     RouterPage.material: (_) => const FurnitureMaterials(),
          //     RouterPage.materialForm: (_) => const MaterialFormPage(),
          //     RouterPage.materialDetail: (_) => const MaterialDetailsPage(),
          //     RouterPage.fixedExpense: (_) => const FixedExpensePage(),
          //     RouterPage.fixedExpenseForm: (_) => const FixedExpenseFormPage(),
          //     RouterPage.fixedExpenseDetail: (_) =>
          //         const FixedExpenseDetailPage(),
          //     RouterPage.personalExpense: (_) => const PersonalExpensePage(),
          //     RouterPage.personalExpenseDetail: (_) =>
          //         const PersonalExpenseDetailPage(),
          //     RouterPage.personalExpenseForm: (_) =>
          //         const PersonalExpenseFormPage(),
          //     RouterPage.profile: (_) => const ProfilePage(),
          //   },
          //
        );
      },
    );
  }
}
