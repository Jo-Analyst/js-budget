import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/helpers/message.dart';
import 'package:js_budget/src/models/payment_history_model.dart';
import 'package:js_budget/src/repositories/history_payment/payment_history_repository.dart';
import 'package:js_budget/src/repositories/history_payment/tranform_payment_history_json.dart';
import 'package:signals/signals.dart';

class PaymentHistoryController with Messages {
  final PaymentHistoryRepository _paymentHistoryRepository;
  PaymentHistoryController({
    required PaymentHistoryRepository paymentHistoryRepository,
  }) : _paymentHistoryRepository = paymentHistoryRepository;

  final _data = ListSignal<PaymentHistoryModel>([]);
  ListSignal<PaymentHistoryModel> get data => _data;

  Future<bool> existsPayment(int paymentId) async {
    bool existsPayment = false;
    final results = await _paymentHistoryRepository.findByPaymentId(paymentId);

    switch (results) {
      case Right(value: final payments):
        existsPayment = payments.isNotEmpty;
      case Left():
        showError('Houve um erro ao buscar o pagamento');
    }
    return existsPayment;
  }

  Future<void> findPaymentHistory(int paymentId) async {
    _data.clear();
    final results = await _paymentHistoryRepository.findByPaymentId(paymentId);

    switch (results) {
      case Right(value: final payments):
        _data.addAll(TranformPaymentHistoryJson.fromJson(payments));
      case Left():
        showError('Houve um erro ao buscar o pagamento');
    }
  }

  Future<void> deletePayment(int id) async {
    final results = await _paymentHistoryRepository.delete(id);

    switch (results) {
      case Right():
        _data.removeWhere((data) => data.id == id);
      case Left():
        showError('Houve um erro ao buscar o pagamento');
    }
  }

  void addNewPaymentHistory(PaymentHistoryModel paymentHistoryModel) {
    _data.add(paymentHistoryModel);
  }
}
