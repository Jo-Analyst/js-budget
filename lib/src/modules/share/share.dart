import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/budget/budget_controller.dart';
import 'package:js_budget/src/modules/profile/profile_controller.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class Share extends StatelessWidget {
  const Share({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Injector.get<ProfileController>().model.value;
    final budget = Injector.get<BudgetController>().model.value;
    double totalService = 0, totalProduct = 0;
    final (year, month, day, hours, minutes) =
        UtilsService.extractDate(budget.createdAt!);

    bool isPdf = ModalRoute.of(context)!.settings.arguments! as bool;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Orçamento',
          style: textStyleSmallDefault,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
              size: 30,
            ),
          ),
        ],
      ),
      // body: isPdf ? const SharePdf() : const ShareImage(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo_rectangular_80.png'),
                  const SizedBox(width: 25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile!.corporateReason.toUpperCase(),
                        style: textStyleSmallFontWeight,
                      ),
                      Text(
                        '${profile.address.streetAddress}, ${profile.address.numberAddress}, ${profile.address.district}',
                        style: textStyleSmallDefault,
                      ),
                      Text(
                        '${profile.address.city} - ${profile.address.state}',
                        style: textStyleSmallDefault,
                      ),
                      Visibility(
                        visible: profile.contact.email.isNotEmpty,
                        child: Text(
                          profile.contact.email,
                          style: textStyleSmallDefault,
                        ),
                      ),
                      Text(
                        profile.contact.cellPhone,
                        style: textStyleSmallDefault,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  const Text(
                    'Ordem de Serviço 00001',
                    style: textStyleSmallFontWeight,
                  ),
                  Text(
                    'Data: ${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year, ${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}Hrs',
                    style: textStyleSmallDefault,
                  ),
                ],
              ),
              // Dados do cliente
              Container(
                margin: const EdgeInsets.symmetric(vertical: 25),
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: const BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(style: BorderStyle.solid, width: 1),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Cliente: ${budget.client!.name}',
                          style: textStyleSmallDefault,
                        ),
                      ],
                    ),

                    // contatos do cliente
                    if (budget.client?.contact != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Contatos:',
                              style: textStyleSmallFontWeight,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Cel: ${budget.client?.contact?.cellPhone ?? ''}',
                                    style: textStyleSmallDefault,
                                  ),
                                  Text(
                                    'Tel: ${budget.client?.contact?.telePhone ?? ''}',
                                    style: textStyleSmallDefault,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'E-mail: ${budget.client?.contact?.email ?? ''}',
                              style: textStyleSmallDefault,
                            ),
                          ],
                        ),
                      ),

                    // Endereço do cliente
                    if (budget.client?.address != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Endereço: ',
                            style: textStyleSmallFontWeight,
                          ),
                          Text(
                            'Endereço: ${budget.client?.address?.streetAddress}, ${budget.client?.address?.numberAddress}',
                            style: textStyleSmallDefault,
                          ),
                          Text(
                            'Bairro: ${budget.client?.address?.district}',
                            style: textStyleSmallDefault,
                          ),
                          Text(
                            'Localidade: ${budget.client?.address?.city} - ${budget.client?.address?.state}',
                            style: textStyleSmallDefault,
                          ),
                          Text(
                            'CEP: ${budget.client?.address?.cep}',
                            style: textStyleSmallDefault,
                          ),
                        ],
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              const Table(
                cellHeader: ['Descrição', 'Quant.', 'VL Un.', 'VL Total'],
              ),

              // TableHelper.fromTextArray(
              //   headerStyle: textStyleSmallDefault,
              //   cellStyle: textStyleSmallDefault,
              //   border: const TableBorder(
              //     horizontalInside: BorderSide(style: BorderStyle.dashed),
              //   ),
              //   cellAlignment: Alignment.center,
              //   data: <List<String>>[
              //     <String>[
              //       'Descrição',
              //       'Quantidade',
              //       'VL Unitário',
              //       'VL Total',
              //     ],
              //     ...budget.itemsBudget!.map(
              //       (item) {
              //         double unitaryValue =
              //             double.parse(item.unitaryValue.toStringAsFixed(2));
              //         double total = unitaryValue * item.quantity;

              //         if (item.product != null) {
              //           totalProduct += total;
              //         } else {
              //           totalService += total;
              //         }

              //         return [
              //           item.product?.name ?? item.service!.description,
              //           item.quantity.toString(),
              //           UtilsService.moneyToCurrency(unitaryValue),
              //           UtilsService.moneyToCurrency(total)
              //         ];
              //       },
              //     )
              //   ],
              // ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(style: BorderStyle.solid, width: .4),
                  ),
                ),
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Total de Produtos: ',
                          style: textStyleSmallFontWeight,
                        ),
                        Text(
                          UtilsService.moneyToCurrency(totalProduct),
                          style: textStyleSmallDefault,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Total de Serviços: ',
                          style: textStyleSmallFontWeight,
                        ),
                        Text(
                          UtilsService.moneyToCurrency(totalService),
                          style: textStyleSmallDefault,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Frete: ',
                          style: textStyleSmallFontWeight,
                        ),
                        Text(
                          UtilsService.moneyToCurrency(budget.freight ?? 0),
                          style: textStyleSmallDefault,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Desconto: ',
                          style: textStyleSmallFontWeight,
                        ),
                        Text(
                          UtilsService.moneyToCurrency(0),
                          style: textStyleSmallDefault,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text('Valor Total: ',
                            style: textStyleSmallFontWeight),
                        Text(
                          UtilsService.moneyToCurrency(budget.valueTotal!),
                          style: textStyleSmallFontWeight,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Table extends StatelessWidget {
  final List<String> cellHeader;
  const Table({
    super.key,
    required this.cellHeader,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: cellHeader
              .map(
                (header) => Expanded(
                  child: Align(
                    child: Text(
                      header,
                      style: textStyleSmallFontWeight,
                    ),
                  ),
                ),
              )
              .toList(),
          // children: [
          //   Expanded(
          //     child: Align(
          //       child: Text(
          //         'Descrição',
          //         style: textStyleSmallDefault,
          //       ),
          //     ),
          //   ),
          //   Expanded(
          //     child: Align(
          //       child: Text(
          //         'Quant.',
          //         style: textStyleSmallDefault,
          //       ),
          //     ),
          //   ),
          //   Expanded(
          //     child: Align(
          //       child: Text(
          //         'VL Un.',
          //         style: textStyleSmallDefault,
          //       ),
          //     ),
          //   ),
          //   Expanded(
          //     child: Align(
          //       child: Text(
          //         'VL Total',
          //         style: textStyleSmallDefault,
          //       ),
          //     ),
          //   ),
          // ],
        )
      ],
    );
  }
}
