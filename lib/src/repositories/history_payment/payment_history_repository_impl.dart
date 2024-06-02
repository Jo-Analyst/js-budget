import 'package:js_budget/src/config/db/database.dart';
import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/payment_history_model.dart';
import 'package:sqflite/sqflite.dart';
import './payment_history_repository.dart';

class PaymentHistoryRepositoryImpl implements PaymentHistoryRepository {
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
      final payments = await db
          .rawQuery('SELECT * FROM payment_history WHERE id = ?', [paymentId]);
      return Right(payments);
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<Either<RespositoryException, Unit>> save(
      PaymentHistoryModel payment) async {
    try {
      final db = await DataBase.openDatabase();
      await db.insert('payment_history', {
        'specie': payment.specie,
        'amount_paid': payment.amountPaid,
        'date_payment': payment.datePayment,
        'payment_id': payment.paymentId,
      });
      return Right(unit);
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<Either<RespositoryException, Unit>> delete(int id) async {
    try {
      final db = await DataBase.openDatabase();
      await db.delete('payment_history', where: 'id = ?', whereArgs: [id]);
      return Right(unit);
    } catch (_) {
      return Left(RespositoryException());
    }
  }
}
