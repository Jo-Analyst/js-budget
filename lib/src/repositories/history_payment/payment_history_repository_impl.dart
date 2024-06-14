import 'package:js_budget/src/config/db/database.dart';
import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/payment_history_model.dart';
import 'package:js_budget/src/repositories/payment/payment_repository_impl.dart';
import 'package:sqflite/sqflite.dart';
import './payment_history_repository.dart';

class PaymentHistoryRepositoryImpl implements PaymentHistoryRepository {
  final _paymentRepository = PaymentRepositoryImpl();
  @override
  Future<void> deletePaymentHistoryByPaymentId(
      Transaction txn, int paymentId) async {
    await txn.delete('payment_history',
        where: 'payment_id = ?', whereArgs: [paymentId]);
  }

  @override
  Future<Either<RespositoryException, List<Map<String, dynamic>>>>
      findByPaymentId(int paymentId) async {
    try {
      final db = await DataBase.openDatabase();
      final payments = await db.rawQuery(
          'SELECT * FROM payment_history WHERE payment_id = ?', [paymentId]);
      return Right(payments);
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<int> save(Transaction txn, PaymentHistoryModel payment) async {
    return await txn.insert('payment_history', {
      'specie': payment.specie,
      'amount_paid': payment.amountPaid,
      'date_payment': payment.datePayment,
      'payment_id': payment.paymentId,
    });
  }

  @override
  Future<Either<RespositoryException, Unit>> delete(
      int id, double amountPaid, int paymentId) async {
    try {
      final db = await DataBase.openDatabase();
      await db.transaction(
        (txn) async {
          await txn.delete('payment_history', where: 'id = ?', whereArgs: [id]);
          await _paymentRepository.updateAmountPaidByDecrement(
              txn, amountPaid, paymentId);
        },
      );
      return Right(unit);
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<Either<RespositoryException, double>> findPaymentByDate(
      String date) async {
    try {
      final db = await DataBase.openDatabase();
      final paymentHistory = await db.rawQuery(
          "SELECT SUM(amount_paid) AS  amount_paid FROM payment_history WHERE date_payment LIKE '%$date%'");
      double amountPaid = paymentHistory[0]['amount_paid'] as double? ?? 0;
      return Right(amountPaid);
    } catch (_) {
      return Left(RespositoryException());
    }
  }
}
