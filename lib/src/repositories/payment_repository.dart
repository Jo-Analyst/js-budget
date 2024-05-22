import 'package:js_budget/src/models/payment_model.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class PaymentRepository {
  Future<void> savePayment(Transaction txn, PaymentModel payment);
  Future<void> deletePayment(Transaction txn, int budgetId);
}
