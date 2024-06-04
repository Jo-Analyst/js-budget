import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/payment_history_model.dart';
import 'package:js_budget/src/models/payment_model.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class PaymentRepository {
  Future<void> savePayment(Transaction txn, PaymentModel payment);
  Future<Either<RespositoryException, Unit>> save(
      PaymentModel payment, PaymentHistoryModel paymentHistoryModel);
  Future<void> deletePayment(Transaction txn, int budgetId);
  Future<void> updateAmountPaidByDecrement(
      Transaction txn, double amountPaid, int paymentId);
}
