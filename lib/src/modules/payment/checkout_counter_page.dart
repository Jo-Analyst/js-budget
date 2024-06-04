import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:js_budget/src/models/payment_history_model.dart';
import 'package:js_budget/src/modules/budget/budget_controller.dart';
import 'package:js_budget/src/modules/payment/payment_controller.dart';
import 'package:js_budget/src/modules/payment/payment_history/payment_history_controller.dart';
import 'package:js_budget/src/modules/payment/widget/personalized_payment_button.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class CheckoutCounterPage extends StatefulWidget {
  const CheckoutCounterPage({super.key});

  @override
  State<CheckoutCounterPage> createState() => _CheckoutCounterPageState();
}

class _CheckoutCounterPageState extends State<CheckoutCounterPage> {
  final budget = Injector.get<BudgetController>().model.value;
  final paymentController = Injector.get<PaymentController>();
  final paymentHistoryController = Injector.get<PaymentHistoryController>();
  final amountReceivedEC = MoneyMaskedTextController(leftSymbol: 'R\$ ');
  double result = 0, amountReceived = 0, amountToPay = 0;
  Map<String, dynamic> selectedPaymentMethod = {};
  List<Map<String, dynamic>> paymentOptionList = [
    {
      'icon': Icons.monetization_on_outlined,
      'label': 'Dinheiro',
      'isSelected': false
    },
    {'icon': Icons.pix, 'label': 'Pix', 'isSelected': false},
    {'icon': Icons.credit_card, 'label': 'Crédito', 'isSelected': false},
    {'icon': Icons.credit_card, 'label': 'Débito', 'isSelected': false},
  ];

  void selectPaymentsButton(Map<String, dynamic> paymentOption) {
    for (var list in paymentOptionList) {
      list['isSelected'] = list['label'].toString().toLowerCase() ==
          paymentOption['label'].toString().toLowerCase();
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    amountToPay = budget.payment!.amountToPay - budget.payment!.amountPaid;
    amountReceivedEC.updateValue(amountToPay);
    amountReceived = amountReceivedEC.numberValue;
    selectedPaymentMethod = {
      'label': budget.payment!.specie,
      'isSelected': false
    };
    selectPaymentsButton(selectedPaymentMethod);
  }

  @override
  void dispose() {
    super.dispose();
    amountReceivedEC.dispose();
  }

  double calculateOutstandingBalance(double amountReceived) {
    return amountReceived >= amountToPay
        ? amountReceived - amountToPay
        : amountToPay - amountReceived;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento'),
        actions: [
          IconButton(
            onPressed: () async {
              var nav = Navigator.of(context);
              bool isvalid = paymentController.validade(
                  selectedPaymentMethod, amountReceivedEC.numberValue);

              if (isvalid) {
                paymentController.addNewPayment(
                  budget.payment!,
                  PaymentHistoryModel(
                    specie: selectedPaymentMethod['label'],
                    amountPaid: amountReceivedEC.numberValue,
                    datePayment: DateTime.now().toIso8601String(),
                    paymentId: budget.payment!.id,
                  ),
                );

                nav.pop();
              }
            },
            icon: const Icon(
              Icons.check,
              size: 30,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Pedido: ',
                              style: textStyleSmallFontWeight,
                            ),
                            TextSpan(
                              text: budget.orderId.toString().padLeft(5, '0'),
                              style: textStyleSmallDefault,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        budget.client!.name,
                        style: textStyleSmallFontWeight,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                ),
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Quantia a pagar: ',
                        style: textStyleSmallFontWeight,
                      ),
                      TextSpan(
                        text: UtilsService.moneyToCurrency(amountToPay),
                        style: TextStyle(
                          fontFamily: 'Anta',
                          fontSize: textStyleSmallDefault.fontSize,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontFamily: 'Anta', fontSize: 30),
                  controller: amountReceivedEC,
                  decoration: InputDecoration(
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            if (amountReceivedEC.numberValue > 0) {
                              amountReceivedEC.updateValue(0);
                              calculateOutstandingBalance(
                                  budget.payment!.amountPaid);
                              amountReceived = 0;
                            } else {
                              amountReceivedEC.updateValue(amountToPay);
                              amountReceived = amountReceivedEC.numberValue;
                            }
                          });
                        },
                        icon: Icon(
                          amountReceivedEC.numberValue > 0
                              ? Icons.close
                              : Icons.restore,
                          size: 28,
                        ),
                      )),
                  onChanged: (value) {
                    setState(() {
                      amountReceived = amountReceivedEC.numberValue;
                      calculateOutstandingBalance(amountReceived);
                    });
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, bottom: 15),
                padding: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor.withOpacity(.5),
                ),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: amountReceived < amountToPay
                              ? 'Á receber: '
                              : 'Troco: ',
                          style: textStyleSmallFontWeight),
                      TextSpan(
                        text: UtilsService.moneyToCurrency(
                          calculateOutstandingBalance(amountReceived),
                        ),
                        style: TextStyle(
                          fontFamily: 'Anta',
                          fontSize: textStyleSmallDefault.fontSize,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: paymentOptionList.length,
                  itemBuilder: (context, index) {
                    final paymentOption = paymentOptionList[index];
                    return PersonalizedPaymentButton(
                      icon: paymentOption['icon'],
                      label: paymentOption['label'],
                      backgroundColor: paymentOption['isSelected'] == true
                          ? Colors.purple
                          : null,
                      color: paymentOption['isSelected'] == true
                          ? Colors.white
                          : null,
                      onTap: () {
                        selectPaymentsButton(paymentOption);
                        selectedPaymentMethod =
                            paymentOption['isSelected'] ? paymentOption : {};
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
