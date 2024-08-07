import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/payment_history_model.dart';
import 'package:js_budget/src/modules/budget/budget_controller.dart';
import 'package:js_budget/src/modules/material/widget/show_confirmation_dialog.dart';
import 'package:js_budget/src/modules/payment/payment_history/payment_history_controller.dart';
import 'package:js_budget/src/modules/widget/custom_icons.dart';
import 'package:js_budget/src/pages/widgets/list_view_tile.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/flexible_text.dart';
import 'package:js_budget/src/utils/utils_service.dart';
import 'package:signals/signals_flutter.dart';

class PaymentHistoryPage extends StatefulWidget {
  const PaymentHistoryPage({super.key});

  @override
  State<PaymentHistoryPage> createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  final budgetController = Injector.get<BudgetController>();
  final paymentHistoryController = Injector.get<PaymentHistoryController>();
  List<PaymentHistoryModel> paymentHistory = [];
  @override
  void initState() {
    super.initState();

    loadPayments();
  }

  Future<void> loadPayments() async {
    await paymentHistoryController
        .findPaymentHistory(budgetController.model.value.payment!.id);
  }

  @override
  Widget build(BuildContext context) {
    var nav = Navigator.of(context);
    paymentHistory = paymentHistoryController.data.watch(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de pagamentos'),
        actions: [
          Visibility(
            visible: paymentHistoryController.amountPaid.value <
                budgetController.model.value.payment!.amountToPay,
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: IconButton(
                tooltip: 'Adicionar novo pagamento',
                icon: const Icon(
                  Icons.add_card_outlined,
                  size: 30,
                ),
                onPressed: () {
                  nav.pushNamed('/payment/checkout-counter');
                },
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      width: 2,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: FlexibleText(
                              text: 'Pedido:',
                              fontWeight: textStyleMediumFontWeight.fontWeight,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Flexible(
                            child: FlexibleText(
                              text: budgetController.model.value.orderId
                                  .toString()
                                  .padLeft(5, '0'),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: FlexibleText(
                        text: budgetController.model.value.client!.name,
                        fontWeight: textStyleMediumFontWeight.fontWeight,
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                margin: const EdgeInsets.only(top: 10),
                child: ListViewTile(
                  title: 'Pagamentos',
                  children: paymentHistory.map((payment) {
                    return Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CustomIcons.paymentsMethod(payment.specie),
                          title: FlexibleText(
                            text: UtilsService.moneyToCurrency(
                                payment.amountPaid),
                            fontFamily: 'Anta',
                          ),
                          subtitle: FlexibleText(
                            text: payment.datePayment,
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete_outline_outlined,
                              color: Colors.red,
                              size: 30,
                            ),
                            onPressed: () async {
                              final confirm = await showConfirmationDialog(
                                      context,
                                      'Deseja mesmo excluir este pagamento',
                                      buttonTitle: 'Excluir') ??
                                  false;

                              if (confirm) {
                                paymentHistoryController.deletePayment(
                                    payment.id,
                                    payment.amountPaid,
                                    payment.paymentId);

                                if (paymentHistoryController.data.length == 1) {
                                  nav.pop();
                                }
                              }
                            },
                          ),
                        ),
                        const Divider()
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
