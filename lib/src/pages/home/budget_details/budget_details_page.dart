import 'package:flutter/material.dart';
import 'package:js_budget/src/pages/home/budget_details/widgets/detail_widget.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class BudgetDetailsPage extends StatelessWidget {
  const BudgetDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    List<Map<String, dynamic>> services = [
      {
        'description': 'Mesa',
        'quantity': 1,
        'unit': 'un',
        'price': 800.00,
        'price-total': 800.00,
      },
      {
        'description': 'Cadeira',
        'quantity': 12,
        'unit': 'un',
        'price': 40.00,
        'price-total': 480.00,
      },
    ];

    List<Map<String, dynamic>> payments = [
      {
        'specie-payment': 'PIX',
        'amount-to-pay': 1000.0,
        'form-of-payment': 'À vista',
      }
    ];

    List<Map<String, dynamic>> materials = [
      {
        'description': 'Madeira PVC',
        'quantity': 1,
        'unit': 'un',
        'price': 300.00,
        'price-total': 300.00,
      },
      {
        'description': 'Pregos',
        'quantity': 1,
        'unit': 'un',
        'price': 18.00,
        'price-total': 180.00,
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          data['id'].toString().padLeft(5, '0'),
          style: const TextStyle(fontFamily: 'Anta'),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
            tooltip: 'Excluir',
            iconSize: 25,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share_outlined),
            tooltip: 'Compartilhar',
            iconSize: 25,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      UtilsService.moneyToCurrency(
                        data['value'],
                      ),
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Anta',
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['name'],
                          style: textTextSmallDefault,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              data['status'],
                              style: TextStyle(
                                fontSize: textTextSmallDefault.fontSize,
                                fontFamily: textTextSmallDefault.fontFamily,
                                fontWeight: FontWeight.w700,
                                color: const Color.fromARGB(255, 20, 87, 143),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                Icons.edit,
                                size: 18,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              DetailWidget(data: services, title: 'Serviços'),
              DetailWidget(data: materials, title: 'Peças e materiais'),
              DetailWidget(
                data: payments,
                title: 'Pagamento',
                iconPayment: const Icon(Icons.pix),
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.stretch,
              //   children: [
              //     Container(
              //       padding:
              //           const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              //       color: const Color.fromARGB(255, 20, 87, 143),
              //       child: Text(
              //         'Pagamento',
              //         style: TextStyle(
              //           fontWeight: FontWeight.w700,
              //           fontSize: 19,
              //           fontFamily: textTextSmallDefault.fontFamily,
              //           color: Colors.white,
              //         ),
              //       ),
              //     ),
              //     Container(
              //       color: const Color(0xFFF8F2F2),
              //       padding:
              //           const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Row(
              //             children: [
              //               const Icon(Icons.pix),
              //               const SizedBox(width: 10),
              //               Text(
              //                 payment['specie-payment'],
              //                 style: textTextSmallDefault,
              //               )
              //             ],
              //           ),
              //           Text(
              //             UtilsService.moneyToCurrency(
              //                 payment['amount-to-pay']),
              //             style: const TextStyle(
              //               fontSize: 20,
              //               fontWeight: FontWeight.w700,
              //               color: Colors.green,
              //               fontFamily: 'Anta',
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
