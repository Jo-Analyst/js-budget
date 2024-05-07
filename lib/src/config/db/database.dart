import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DataBase {
  static Future<sql.Database> openDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, "js_budget.db"),
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE IF NOT EXISTS costs (id INTEGER PRIMARY KEY, description TEXT NOT NULL, value REAL)",
        );

        db.execute(
          "CREATE TABLE IF NOT EXISTS clients (id INTEGER PRIMARY KEY, name TEXT NOT NULL, document TEXT, is_a_legal_entity BLOB)",
        );

        db.execute(
          "CREATE TABLE IF NOT EXISTS profile (id INTEGER PRIMARY KEY, fantasy_name TEXT NOT NULL, corporate_reason TEXT NOT NULL , document TEXT NOT NULL, salary_expectation REAL)",
        );

        db.execute(
          "CREATE TABLE IF NOT EXISTS contacts (id INTEGER PRIMARY KEY, cell_phone TEXT NULL, tele_phone TEXT NOT NULL, email TEXT NULL, client_id INTEGER, profile_id INTEGER, FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE SET NULL, FOREIGN KEY (profile_id) REFERENCES profiles(id) ON DELETE SET NULL)",
        );

        db.execute(
          "CREATE TABLE IF NOT EXISTS address (id INTEGER PRIMARY KEY, cep TEXT, district TEXT, street_address TEXT, number_address TEXT, city TEXT, state TEXT, client_id INTEGER, profile_id INTEGER, FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE SET NULL, FOREIGN KEY (profile_id) REFERENCES profiles(id) ON DELETE SET NULL)",
        );

        db.execute(
          'CREATE TABLE IF NOT EXISTS materials (id INTEGER PRIMARY KEY, name TEXT, type TEXT, quantity INTEGER, unit TEXT, price REAL, date_of_last_purchase TEXT, observation TEXT, supplier TEXT)',
        );

        db.execute(
          "CREATE TABLE IF NOT EXISTS fixed_expenses (id INTEGER PRIMARY KEY, type TEXT NOT NULL, value REAL NOT NULL, method_payment TEXT, date TEXT NOT NULL, observation TEXT NULL)",
        );

        db.execute(
          "CREATE TABLE IF NOT EXISTS budgets (id INTEGER PRIMARY KEY, value_total REAL NOT NULL, status TEXT DEFAULT 'Em aberto', created_at TEXT, order_id INTEGER NOT NULL, client_id INTEGER NOT NULL, FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE SET NULL, FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE SET NULL)",
        );

        db.execute(
            'CREATE TABLE IF NOT EXISTS items_budget (id INTEGER PRIMARY KEY, sub_value REAL, unitary_value REAL, term INTEGER, time_incentive TEXT, percentage_profit_margin REAL, value_profit_margin REAL, product_id INTEGER, service_id INTEGER, budget_id INTEGER, FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE SET NULL, FOREIGN KEY (service_id) REFERENCES services(id) ON DELETE SET NULL, FOREIGN KEY (budget_id) REFERENCES budgets(id) ON DELETE SET NULL)');

        db.execute(
          'CREATE TABLE IF NOT EXISTS material_items_budget (id INTEGER PRIMARY KEY, quantity INTEGER, value REAL NOT NULL, material_id INTEGER NOT NULL, item_budget_id INTEGER NOT NULL, FOREIGN KEY (item_budget_id) REFERENCES items_budget(id) ON DELETE SET NULL, FOREIGN KEY (material_id) REFERENCES materials(id) ON DELETE SET NULL)',
        );

        db.execute(
            'CREATE TABLE IF NOT EXISTS fixed_expense_items_budget (id INTEGER PRIMARY KEY, value REAL NOT NULL, dividedValue REAL NOT NULL, accumulatedValue REAL NOT NULL, type TEXT, item_budget_id INTEGER NOT NULL, FOREIGN KEY (item_budget_id) REFERENCES items_budget(id) ON DELETE SET NULL)');

        db.execute(
          "CREATE TABLE IF NOT EXISTS personal_expenses (id INTEGER PRIMARY KEY, type TEXT NOT NULL, value REAL NOT NULL, method_payment TEXT, date TEXT NOT NULL, observation TEXT NULL)",
        );

        db.execute(
          'CREATE TABLE IF NOT EXISTS products (id INTEGER PRIMARY KEY, name TEXT, description TEXT, unit TEXT)',
        );

        db.execute(
          'CREATE TABLE IF NOT EXISTS services (id INTEGER PRIMARY KEY, description TEXT, price REAL)',
        );

        db.execute(
          "CREATE TABLE IF NOT EXISTS orders (id INTEGER PRIMARY KEY, date TEXT NOT NULL, client_id INTEGER, FOREIGN KEY (client_id) REFERENCES clients(id))",
        );

        db.execute(
          "CREATE TABLE IF NOT EXISTS items_orders (id INTEGER PRIMARY KEY, quantity_product INTEGER, quantity_service INTEGER, order_id INTEGER, product_id INTEGER, service_id INTEGER, FOREIGN KEY (order_id) REFERENCES orders(id), FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE SET NULL, FOREIGN KEY (service_id) REFERENCES services(id) ON DELETE SET NULL)",
        );

        db.execute(
            "CREATE TABLE IF NOT EXISTS payments (id INTEGER PRIMARY KEY, specie TEXT, amount_paid REAL, date_payment TEXT, order_id INTEGER, FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE)");
      },
      version: 1,
    );
  }
}
