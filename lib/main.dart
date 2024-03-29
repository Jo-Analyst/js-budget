import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:js_budget/src/app/app.dart';
import 'package:js_budget/src/bindings/binding_initial_application.dart';
import 'package:js_budget/src/modules/client/client_module.dart';
import 'package:js_budget/src/modules/expenses/expense_module.dart';
import 'package:js_budget/src/modules/material/material_module.dart';
import 'package:js_budget/src/modules/products/product_module.dart';
import 'package:js_budget/src/modules/request/request_modules.dart';
import 'package:js_budget/src/pages/summary/summary_router.dart';
import 'package:js_budget/src/pages/home/budget_details/budget_details_router.dart';
import 'package:js_budget/src/modules/profile/profile_module.dart';
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
        const BudgetDetailsRouter(),
        const FinanceRouter(),
      ],
      modules: [
        ClientModule(),
        ProductModule(),
        MaterialModule(),
        ExpenseModule(),
        ProfileModule(),
        RequestModules(),
      ],
      builder: (context, routes, flutterGetItNavObserver) {
        return MaterialApp(
          title: 'JS Planejar',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          routes: routes,
        );
      },
    );
  }
}
