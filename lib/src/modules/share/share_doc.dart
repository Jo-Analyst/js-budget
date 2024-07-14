import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/items_budget_model.dart';
import 'package:js_budget/src/modules/budget/budget_controller.dart';
import 'package:js_budget/src/modules/profile/profile_controller.dart';
import 'package:js_budget/src/modules/share/widget/custom_data_table.dart';
import 'package:js_budget/src/modules/share/widget/image_generate.dart';
import 'package:js_budget/src/modules/share/widget/option_share.dart';
import 'package:js_budget/src/modules/share/widget/pdf_generate.dart';
import 'package:js_budget/src/modules/share/widget/widget_to_image.dart';
import 'package:js_budget/src/pages/home/widgets/show_modal_widget.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class ShareDoc extends StatefulWidget {
  const ShareDoc({super.key});

  @override
  State<ShareDoc> createState() => _ShareDocState();
}

class _ShareDocState extends State<ShareDoc> {
  late GlobalKey globalKey;
  final profile = Injector.get<ProfileController>().model.value;
  final budget = Injector.get<BudgetController>().model.value;
  bool isPdf = false;

  (
    double totalProduct,
    double totalService
  ) _calculateTotalValueProductAndService(List<ItemsBudgetModel> itemsBudget) {
    double totalProduct = 0, totalService = 0;

    for (var item in itemsBudget) {
      double unitaryValue = double.parse(item.unitaryValue.toStringAsFixed(2));
      double total = unitaryValue * item.quantity;

      if (item.product != null) {
        totalProduct += total;
      } else {
        totalService += total;
      }
    }

    return (totalProduct, totalService);
  }

  Future<void> toShare(bool isPdf) async {
    if (isPdf) {
      await PdfGeneration.generatePdf();
    } else {
      await ImageGeneration.generateImage(globalKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    final (year, month, day, hours, minutes) =
        UtilsService.extractDate(budget.createdAt!);
    final (double totalProduct, double totalService) =
        _calculateTotalValueProductAndService(budget.itemsBudget!);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Orçamento',
          style: textStyleSmallDefault,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final result = await Modal.showModal(context, const OptionShare(),
                  scrollControlDisabledMaxHeightRatio: .2);

              toShare(result);
            },
            icon: const Icon(
              Icons.share,
              size: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: WidgetToImage(builder: (key) {
          globalKey = key;
          return Padding(
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
                          '${profile!.address.streetAddress}, ${profile!.address.numberAddress}, ${profile!.address.district}',
                          style: textStyleSmallDefault,
                        ),
                        Text(
                          '${profile!.address.city} - ${profile!.address.state}',
                          style: textStyleSmallDefault,
                        ),
                        Visibility(
                          visible: profile!.contact.email.isNotEmpty,
                          child: Text(
                            profile!.contact.email,
                            style: textStyleSmallDefault,
                          ),
                        ),
                        Text(
                          profile!.contact.cellPhone,
                          style: textStyleSmallDefault,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Column(
                  children: [
                    Text(
                      'ORDEM DE SERVIÇO - ${budget.orderId.toString().padLeft(5, '0')}',
                      style: textStyleLargeDefaultFontWeight,
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
                      horizontal:
                          BorderSide(style: BorderStyle.solid, width: 1),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
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
                CustomDataTable(
                  cellHeader: const [
                    'Descrição',
                    'Quant.',
                    'VL Un.',
                    'VL Total'
                  ],
                  cellRow: budget.itemsBudget ?? [],
                ),

                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(style: BorderStyle.solid, width: 1),
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
                            style: TextStyle(
                              fontSize: textStyleSmallDefault.fontSize,
                              fontFamily: 'Anta',
                            ),
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
                            style: TextStyle(
                              fontSize: textStyleSmallDefault.fontSize,
                              fontFamily: 'Anta',
                            ),
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
                            style: TextStyle(
                              fontSize: textStyleSmallDefault.fontSize,
                              fontFamily: 'Anta',
                            ),
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
                            style: TextStyle(
                              fontSize: textStyleSmallDefault.fontSize,
                              fontFamily: 'Anta',
                            ),
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
                            style: TextStyle(
                              fontSize: textStyleSmallDefault.fontSize,
                              fontFamily: 'Anta',
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
