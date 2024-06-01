import 'package:js_budget/src/config/db/database.dart';
import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/payment_model.dart';
import 'package:js_budget/src/repositories/history_payment/payment_history_repository_impl.dart';
import 'package:sqflite/sqflite.dart';

import 'payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  @override
  Future<void> savePayment(Transaction txn, PaymentModel payment) async {
    await txn.insert('payments', {
      'specie': payment.specie,
      'amount_paid': payment.amountPaid,
      'amount_to_pay': payment.amountToPay,
      'number_of_installments': payment.numberOfInstallments,
      'budget_id': payment.budgetId,
    });
  }

  @override
  Future<void> deletePayment(Transaction txn, int budgetId) async {
    int paymentId = await _findByBudgetId(txn, budgetId);
    await txn.delete('payments', where: 'budget_id = ?', whereArgs: [budgetId]);
    await PaymentHistoryRepositoryImpl().deletePaymentHistory(txn, paymentId);
  }

  Future<int> _findByBudgetId(Transaction txn, int budgetId) async {
    final payments = await txn
        .rawQuery('SELECT id FROM payments WHERE budget_id = $budgetId');
    return payments.isNotEmpty ? payments.first['id'] as int : 0;
  }

  @override
  Future<Either<RespositoryException, Unit>> updatePayment(
      PaymentModel payment) async {
    try {
      final db = await DataBase.openDatabase();
      await db.update('payments', payment.toJson(),
          where: 'id = ?', whereArgs: [payment.id]);
      return Right(unit);
    } catch (_) {
      return Left(RespositoryException());
    }
  }
}
