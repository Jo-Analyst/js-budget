import 'package:js_budget/src/config/db/database.dart';
import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/payment_model.dart';
import 'package:sqflite/sqflite.dart';

import './payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  @override
  Future<void> savePayment(Transaction txn, PaymentModel payment) async {
    await txn.insert('payments', {
      'specie': payment.specie,
      'amount_paid': payment.amountPaid,
      'amount_to_pay': payment.amountToPay,
      'date_payment': DateTime.now().toIso8601String(),
      'number_of_installments': payment.numberOfInstallments,
      'budget_id': payment.budgetId,
    });
  }

  @override
  Future<void> deletePayment(Transaction txn, int budgetId) async {
    await txn.delete('payments', where: 'budget_id = ?', whereArgs: [budgetId]);
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
