import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:js_budget/src/app/app.dart';
import 'package:js_budget/src/bindings/binding_initial_application.dart';
import 'package:js_budget/src/config/db/database.dart';
import 'package:js_budget/src/modules/budget/budget_module.dart';
import 'package:js_budget/src/modules/client/client_module.dart';
import 'package:js_budget/src/modules/expenses/workshop_module.dart';
import 'package:js_budget/src/modules/material/material_module.dart';
import 'package:js_budget/src/modules/payment/payment_module.dart';
import 'package:js_budget/src/modules/product/product_module.dart';
import 'package:js_budget/src/modules/order/order_module.dart';
import 'package:js_budget/src/modules/service/service_module.dart';
import 'package:js_budget/src/pages/splash/splash_page.dart';
import 'package:js_budget/src/pages/finance/finance_router.dart';
import 'package:js_budget/src/modules/budget/budget_details/budget_details_router.dart';
import 'package:js_budget/src/modules/profile/profile_module.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:overlay_support/overlay_support.dart';

void main() async {
  await initializeDateFormatting('pt_BR', null);
  runApp(
    const OverlaySupport.global(
      child: MyApp(),
    ),
  );

  final db = await DataBase.openDatabase();
  await db.execute('DROP TABLE workshop_expenses');
  await db.execute(
    'CREATE TABLE IF NOT EXISTS workshop_expenses (id INTEGER PRIMARY KEY, type TEXT NOT NULL, value REAL NOT NULL, method_payment TEXT, date TEXT NOT NULL, observation TEXT NULL, material_id INTEGER, FOREIGN KEY (material_id) REFERENCES materials(id))',
  );
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
        BudgetModule(),
        ClientModule(),
        ExpenseModule(),
        MaterialModule(),
        OrderModule(),
        PaymentModule(),
        ProductModule(),
        ProfileModule(),
        ServiceModule(),
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
