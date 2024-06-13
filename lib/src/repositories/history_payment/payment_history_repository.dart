import 'package:js_budget/src/exception/respository_exception.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/fp/unit.dart';
import 'package:js_budget/src/models/payment_history_model.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class PaymentHistoryRepository {
  Future<void> deletePaymentHistoryByPaymentId(Transaction txn, int paymentId);
  Future<Either<RespositoryException, List<Map<String, dynamic>>>>
      findByPaymentId(int paymentId);
  Future<int> save(Transaction txn, PaymentHistoryModel payment);
  Future<Either<RespositoryException, Unit>> delete(
      int id, double amountPaid, int paymentId);
  Future<Either<RespositoryException, double>>
      findPaymentByDate(String date);
}
