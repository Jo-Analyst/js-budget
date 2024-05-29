import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:js_budget/src/modules/payment/widget/personalized_payment_button.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class CheckoutCounter extends StatelessWidget {
  const CheckoutCounter({super.key});

  @override
  Widget build(BuildContext context) {
    final amountReceivedEC = MoneyMaskedTextController(leftSymbol: 'R\$ ');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.check,
              size: 30,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                            text: 1.toString().padLeft(5, '0'),
                            style: textStyleSmallDefault,
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      'Joelmir Carvalho',
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
                      color: Theme.of(context).primaryColor, width: 2),
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
                      text: UtilsService.moneyToCurrency(2000),
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
                textAlign: TextAlign.center,
                style: const TextStyle(fontFamily: 'Anta', fontSize: 30),
                controller: amountReceivedEC,
                decoration: InputDecoration(
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.restore,
                      size: 28,
                    ),
                  ),
                ),
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
                    const TextSpan(
                        text: 'Á receber: ', style: textStyleSmallFontWeight),
                    TextSpan(
                      text: UtilsService.moneyToCurrency(2000),
                      style: TextStyle(
                        fontFamily: 'Anta',
                        fontSize: textStyleSmallDefault.fontSize,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 3,
                crossAxisSpacing: 15,
                mainAxisSpacing: 20,
                children: [
                  PersonalizedPaymentButton(
                    icon: Icons.monetization_on_outlined,
                    label: 'Dinheiro',
                    onTap: () {},
                  ),
                  PersonalizedPaymentButton(
                    icon: Icons.pix,
                    label: 'PIX',
                    onTap: () {},
                  ),
                  PersonalizedPaymentButton(
                    icon: Icons.credit_card,
                    label: 'Crédito',
                    onTap: () {},
                  ),
                  PersonalizedPaymentButton(
                    icon: Icons.credit_card,
                    label: 'Débito',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
