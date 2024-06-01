import 'package:sqflite/sqflite.dart';

abstract interface class PaymentHistoryRepository {
  Future<void> deletePaymentHistory(Transaction txn,int paymentId);
}
