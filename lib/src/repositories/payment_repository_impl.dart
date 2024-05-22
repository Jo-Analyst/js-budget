import 'package:js_budget/src/models/payment_model.dart';
import 'package:sqflite/sqflite.dart';

import './payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  @override
  Future<void> savePayment(Transaction txn, PaymentModel payment) async {
    await txn.insert('payments', payment.toJson());
  }

  @override
  Future<void> deletePayment(Transaction txn, int budgetId) async {
    await txn.delete('payments', where: 'budget_id = ?', whereArgs: [budgetId]);
  }
}
