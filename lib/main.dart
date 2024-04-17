import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:js_budget/src/app/app.dart';
import 'package:js_budget/src/bindings/binding_initial_application.dart';
import 'package:js_budget/src/config/db/database.dart';
import 'package:js_budget/src/modules/budget/budget_module.dart';
import 'package:js_budget/src/modules/client/client_module.dart';
import 'package:js_budget/src/modules/expenses/expense_module.dart';
import 'package:js_budget/src/modules/material/material_module.dart';
import 'package:js_budget/src/modules/product/product_module.dart';
import 'package:js_budget/src/modules/order/order_module.dart';
import 'package:js_budget/src/modules/service/service_module.dart';
import 'package:js_budget/src/pages/splash/splash_page.dart';
import 'package:js_budget/src/pages/summary/summary_router.dart';
import 'package:js_budget/src/pages/home/budget_details/budget_details_router.dart';
import 'package:js_budget/src/modules/profile/profile_module.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:overlay_support/overlay_support.dart';

void main() async {
  await initializeDateFormatting('pt_BR', null);
  runApp(const OverlaySupport.global(child: MyApp()));
  final db = await DataBase.openDatabase();
  db.execute(
      'CREATE TABLE IF NOT EXISTS fixed_expense_items_budget (id INTEGER PRIMARY KEY, value REAL NOT NULL, budget_id INTEGER NOT NULL, fixed_expense_id INTEGER NOT NULL, FOREIGN KEY (budget_id) REFERENCES budgets(id) ON DELETE SET NULL, FOREIGN KEY (fixed_expense_id) REFERENCES fixed_expenses(id) ON DELETE SET NULL)');

  db.execute(
    'CREATE TABLE IF NOT EXISTS material_items_budget (id INTEGER PRIMARY KEY, value REAL NOT NULL, budget_id INTEGER NOT NULL, material_id INTEGER NOT NULL, FOREIGN KEY (budget_id) REFERENCES budgets(id) ON DELETE SET NULL, FOREIGN KEY (material_id) REFERENCES materials(id) ON DELETE SET NULL)',
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
        ClientModule(),
        ProductModule(),
        ServiceModule(),
        MaterialModule(),
        ExpenseModule(),
        ProfileModule(),
        OrderModule(),
        BudgetModule()
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
