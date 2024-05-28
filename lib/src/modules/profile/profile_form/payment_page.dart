import 'package:flutter/material.dart';
import 'package:js_budget/src/models/budget_model.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/models/payment_model.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String search = '';
  List<BudgetModel> budgets = [
    BudgetModel(
      status: 'Aprovado',
      orderId: 1,
      client: ClientModel(name: 'Lorenzo'),
      valueTotal: 3000.00,
      payment: PaymentModel(
        specie: 'PIX',
        amountToPay: 3000,
      ),
    ),
    BudgetModel(
      status: 'Aprovado',
      orderId: 2,
      client: ClientModel(name: 'Carla'),
      valueTotal: 4000.00,
      payment: PaymentModel(
        specie: 'PIX',
        amountToPay: 3000,
      ),
    ),
    BudgetModel(
      status: 'Concluído',
      orderId: 3,
      client: ClientModel(name: 'Alberto'),
      valueTotal: 3000.00,
      payment: PaymentModel(
        specie: 'PIX',
        amountToPay: 3000,
      ),
    ),
    BudgetModel(
      status: 'Aprovado',
      orderId: 1,
      client: ClientModel(name: 'Lorenzo'),
      valueTotal: 3000.00,
      payment: PaymentModel(
        specie: 'PIX',
        amountToPay: 3000,
      ),
    ),
    BudgetModel(
      status: 'Aprovado',
      orderId: 2,
      client: ClientModel(name: 'Carla'),
      valueTotal: 4000.00,
      payment: PaymentModel(
        specie: 'PIX',
        amountToPay: 3000,
      ),
    ),
    BudgetModel(
      status: 'Concluído',
      orderId: 3,
      client: ClientModel(name: 'Alberto'),
      valueTotal: 3000.00,
      payment: PaymentModel(
        specie: 'PIX',
        amountToPay: 3000,
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    var budgets = this
        .budgets
        .where((budget) => (budget.client!.name
                .toLowerCase()
                .contains(search..toLowerCase()) ||
            budget.orderId.toString().padLeft(5, '0').contains(search)))
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
            Expanded(
              child: ListView.builder(
                itemCount: budgets.length,
                itemBuilder: (_, index) {
                  var budget = budgets[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Pedido: ',
                                  style: textStyleSmallFontWeight,
                                ),
                                TextSpan(
                                  text: budget.orderId!
                                      .toString()
                                      .padLeft(5, '0'),
                                  style: textStyleSmallDefault,
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  budget.client!.name,
                                  style: textStyleSmallDefault,
                                ),
                                Text(
                                  budget.status!,
                                  style: textStyleSmallDefault,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Quan. paga',
                                  style: textStyleSmallFontWeight,
                                ),
                                Text(
                                  UtilsService.moneyToCurrency(
                                      budget.payment!.amountPaid),
                                  style: TextStyle(
                                    fontFamily: 'Anta',
                                    fontSize: textStyleSmallDefault.fontSize,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Quan. a pagar',
                                  style: textStyleSmallFontWeight,
                                ),
                                Text(
                                  UtilsService.moneyToCurrency(
                                      budget.payment!.amountToPay),
                                  style: TextStyle(
                                    fontFamily: 'Anta',
                                    fontSize: textStyleSmallDefault.fontSize,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
