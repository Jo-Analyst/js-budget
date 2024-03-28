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
          "CREATE TABLE IF NOT EXISTS profile (id INTEGER PRIMARY KEY, fantasy_name TEXT NOT NULL, corporate_reason TEXT NOT NULL , document TEXT NOT NULL)",
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
          'CREATE TABLE IF NOT EXISTS budgets (id INTEGER PRIMARY KEY, value_total REAL NOT NULL, status TEXT, created_at TEXT, client_id INTEGER NOT NULL, FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE SET NULL)',
        );

        db.execute(
          'CREATE TABLE IF NOT EXISTS budgets_items (id INTEGER PRIMARY KEY, value REAL NOT NULL, budget_id INTEGER NOT NULL, FOREIGN KEY (budget_id) REFERENCES budgets(id) ON DELETE SET NULL)',
        );

        db.execute(
          "CREATE TABLE IF NOT EXISTS fixed_expenses (id INTEGER PRIMARY KEY, type TEXT NOT NULL, value REAL NOT NULL, method_payment TEXT, date TEXT NOT NULL, observation TEXT NULL)",
        );
        db.execute(
          "CREATE TABLE IF NOT EXISTS personal_expenses (id INTEGER PRIMARY KEY, type TEXT NOT NULL, value REAL NOT NULL, method_payment TEXT, date TEXT NOT NULL, observation TEXT NULL)",
        );

        db.execute(
          'CREATE TABLE IF NOT EXISTS products (id INTEGER PRIMARY KEY, name TEXT, description TEXT, unit TEXT)',
        );

        db.execute(
          'CREATE TABLE IF NOT EXISTS services (id INTEGER PRIMARY KEY, description)',
        );

        db.execute(
          "CREATE TABLE IF NOT EXISTS requests (id INTEGER PRIMARY KEY, date TEXT NOT NULL, client_id INTEGER, FOREIGN KEY (client_id) REFERENCES clients(id)",
        );

        db.execute(
          "CREATE TABLE IF NOT EXISTS items_requests (id INTEGER PRIMARY KEY, product_id INTEGER, service_id, FOREIGN KEY (product_id) REFERENCES products(id), , FOREIGN KEY (service_id) REFERENCES services(id))",
        );
      },
      version: 1,
    );
  }
}
