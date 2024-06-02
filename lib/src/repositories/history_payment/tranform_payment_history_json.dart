import 'package:js_budget/src/models/payment_history_model.dart';

class TranformPaymentHistoryJson {
  static List<PaymentHistoryModel> fromJson(
      List<Map<String, dynamic>> payments) {
    final List<PaymentHistoryModel> tempPayments = [];
    for (var payment in payments) {
      tempPayments.add(PaymentHistoryModel.fromJson(payment));
    }

    return tempPayments;
  }
}
