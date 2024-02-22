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
          "CREATE TABLE IF NOT EXISTS clients (id INTEGER PRIMARY KEY, name TEXT NOT NULL, cpf TEXT, phone TEXT)",
        );

        db.execute(
          "CREATE TABLE IF NOT EXISTS address (id INTEGER PRIMARY KEY, street_address TEXT, number_address TEXT, city TEXT, state TEXT, client_id INTEGER, FOREIGN KEY (client_id) REFERENCES clientes(id) ON DELETE SET NULL)",
        );

        db.execute(
          'CREATE TABLE IF NOT EXISTS budgets (id INTEGER PRIMARY KEY, value_total REAL NOT NULL, created_at, client_id INTEGER NOT NULL, created_at TEXT, FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE SET NULL)',
        );

        db.execute(
          'CREATE TABLE IF NOT EXISTS budgets_items (id INTEGER PRIMARY KEY, value REAL NOT NULL, budget_id INTEGER NOT NULL, FOREIGN KEY (budget_id) REFERENCES budgets(id) ON DELETE SET NULL)',
        );

        db.execute(
          "CREATE TABLE IF NOT EXISTS expenses (id INTEGER PRIMARY KEY, description TEXT NOT NULL, value REAL NOT NULL, date TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }
}
