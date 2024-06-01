import 'package:sqflite/sqflite.dart';
import './payment_history_repository.dart';

class PaymentHistoryRepositoryImpl implements PaymentHistoryRepository {
  @override
  Future<void> deletePaymentHistory(Transaction txn, int paymentId) async {
    await txn.delete('payment_history',
        where: 'payment_id = ?', whereArgs: [paymentId]);
  }
}
