// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/helpers/message.dart';
import 'package:js_budget/src/models/payment_model.dart';
import 'package:js_budget/src/modules/budget/budget_controller.dart';
import 'package:js_budget/src/repositories/payment_repository.dart';

class PaymentController with Messages {
  final PaymentRepository _paymentRepository;
  PaymentController({
    required PaymentRepository paymentRepository,
  }) : _paymentRepository = paymentRepository;

  bool validade(Map<String, dynamic> paymentMethod, double amountReceived) {
    bool isValid = false;

    if (paymentMethod.isEmpty) {
      showInfo('Informe o meio de pagamento', position: Position.top);
    } else if (amountReceived == 0) {
      showInfo('Digite o valor recebido', position: Position.top);
    } else {
      isValid = true;
    }

    return isValid;
  }

  Future<void> addNewPayment(PaymentModel payment) async {
    final budgetController = Injector.get<BudgetController>();
    final results = await _paymentRepository.updatePayment(payment);

    switch (results) {
      case Right():
        for (var budget in budgetController.data.value) {
          if (budget.payment!.budgetId == payment.budgetId) {
            budget.payment = payment;
          }
        }
      case Left():
        showError('Houve um erro ao gerar o pagamento');
    }
  }
}
