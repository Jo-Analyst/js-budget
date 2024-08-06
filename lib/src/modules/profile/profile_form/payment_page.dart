import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

import 'package:js_budget/src/modules/budget/budget_controller.dart';
import 'package:js_budget/src/modules/payment/payment_history/payment_history_controller.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/flexible_text.dart';
import 'package:js_budget/src/utils/utils_service.dart';
import 'package:signals/signals_flutter.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String search = '';
  final budgetController = Injector.get<BudgetController>();
  final paymentHitoryController = Injector.get<PaymentHistoryController>();

  @override
  Widget build(BuildContext context) {
    var budgets = budgetController.data
        .watch(context)
        .where((budget) =>
            (budget.client!.name
                    .toLowerCase()
                    .contains(search..toLowerCase()) ||
                budget.orderId.toString().padLeft(5, '0').contains(search)) &&
            (budget.status!.toString().toLowerCase() == 'aprovado' ||
                budget.status!.toString().toLowerCase() == 'concluído'))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamentos'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        child: Column(
          children: [
            TextFormField(
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              textInputAction: TextInputAction.search,
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Buscar cliente ou pedido',
                suffixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 10),
            budgets.isEmpty
                ? const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.payments_sharp,
                          size: 80,
                        ),
                        Text(
                          'Não há pagamentos de pedidos orçados que foram aprovados ou concluidos',
                          textAlign: TextAlign.center,
                          style: textStyleMediumDefault,
                        )
                      ],
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: budgets.length,
                      itemBuilder: (_, index) {
                        var budget = budgets[index];
                        return GestureDetector(
                          onTap: () async {
                            var nav = Navigator.of(context);
                            budgetController.model.value = budget;
                            bool existPayments = await paymentHitoryController
                                .existsPayment(budget.payment!.id);

                            nav.pushNamed(existPayments
                                ? '/payment/history-payment'
                                : '/payment/checkout-counter');
                          },
                          child: Card(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 15,
                              ),
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      FlexibleText(
                                        text: 'Pedido:',
                                        fontWeight: textStyleMediumFontWeight
                                            .fontWeight,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      FlexibleText(
                                        text: budget.orderId!
                                            .toString()
                                            .padLeft(5, '0'),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: FlexibleText(
                                          text:
                                              budget.client!.name.toUpperCase(),
                                          fontWeight: textStyleMediumFontWeight
                                              .fontWeight,
                                        ),
                                      ),
                                      Flexible(
                                        child: FlexibleText(
                                          text: budget.payment!.amountPaid <
                                                  budget.payment!.amountToPay
                                              ? 'À receber'
                                              : 'Pago',
                                          fontWeight: textStyleMediumFontWeight
                                              .fontWeight,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Flexible(
                                        child: FlexibleText(
                                          text: 'Quan. paga',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      FlexibleText(
                                        text: UtilsService.moneyToCurrency(
                                            budget.payment!.amountPaid),
                                        fontFamily: 'Anta',
                                        fontWeight: textStyleMediumFontWeight
                                            .fontWeight,
                                        colorText: const Color.fromARGB(
                                            255, 33, 82, 35),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Flexible(
                                        child: FlexibleText(
                                          text: 'Quan. a pagar',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      FlexibleText(
                                        text: UtilsService.moneyToCurrency(
                                            budget.payment!.amountToPay),
                                        fontFamily: 'Anta',
                                        fontWeight: textStyleMediumFontWeight
                                            .fontWeight,
                                        colorText: const Color.fromARGB(
                                            255, 33, 82, 35),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
