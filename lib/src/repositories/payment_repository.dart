import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/payment_model.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class PaymentRepository {
  Future<void> savePayment(Transaction txn, PaymentModel payment);
  Future<Either<RespositoryException, Unit>> updatePayment(
      PaymentModel payment);
  Future<void> deletePayment(Transaction txn, int budgetId);
}
