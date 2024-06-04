import 'package:js_budget/src/config/db/database.dart';
import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/payment_history_model.dart';
import 'package:js_budget/src/models/payment_model.dart';
import 'package:js_budget/src/repositories/history_payment/payment_history_repository_impl.dart';
import 'package:sqflite/sqflite.dart';

import 'payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  @override
  Future<int> savePayment(Transaction txn, PaymentModel payment) async {
    final lastId = await txn.insert('payments', {
      'specie': payment.specie,
      'amount_paid': payment.amountPaid,
      'amount_to_pay': payment.amountToPay,
      'number_of_installments': payment.numberOfInstallments,
      'budget_id': payment.budgetId,
    });

    return lastId;
  }

  @override
  Future<void> deletePayment(Transaction txn, int budgetId) async {
    int paymentId = await _findByBudgetId(txn, budgetId);
    await txn.delete('payments', where: 'budget_id = ?', whereArgs: [budgetId]);
    await PaymentHistoryRepositoryImpl()
        .deletePaymentHistoryByPaymentId(txn, paymentId);
  }

  Future<int> _findByBudgetId(Transaction txn, int budgetId) async {
    final payments = await txn
        .rawQuery('SELECT id FROM payments WHERE budget_id = $budgetId');
    return payments.isNotEmpty ? payments.first['id'] as int : 0;
  }

  @override
  Future<Either<RespositoryException, Unit>> save(
      PaymentModel payment, PaymentHistoryModel paymentHistoryModel) async {
    try {
      final db = await DataBase.openDatabase();
      await db.transaction(
        (txn) async {
          int paymentId = payment.id;
          if (paymentId > 0) {
            await txn.rawUpdate(
                'UPDATE payments SET amount_paid = amount_paid + ?  WHERE id = ?',
                [paymentHistoryModel.amountPaid, paymentId]);
          } else {
            paymentId = await txn.insert('payments', {
              'specie': paymentHistoryModel.specie,
              'amount_paid': paymentHistoryModel.amountPaid,
              'amount_to_pay': payment.amountToPay,
              'number_of_installments': payment.numberOfInstallments,
              'budget_id': payment.budgetId,
            });
          }

          paymentHistoryModel.paymentId = paymentId;
          paymentHistoryModel.id = await PaymentHistoryRepositoryImpl()
              .save(txn, paymentHistoryModel);
        },
      );

      return Right(unit);
    } catch (_) {
      return Left(RespositoryException());
    }
  }

  @override
  Future<void> updateAmountPaidByDecrement(
      Transaction txn, double amountPaid, int paymentId) async {
    await txn.rawUpdate(
        'UPDATE payments SET amount_paid = amount_paid - ?  WHERE id = ?',
        [amountPaid, paymentId]);
  }
}
