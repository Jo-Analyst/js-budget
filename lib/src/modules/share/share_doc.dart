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
  String approvalDate = '';

  (
    double totalProduct,
    double totalService,
    int totalTerm
  ) _calculateTotalValueProductAndService(List<ItemsBudgetModel> itemsBudget) {
    double totalProduct = 0, totalService = 0;
    int totalTerm = 0;

    for (var item in itemsBudget) {
      double unitaryValue = double.parse(item.unitaryValue.toStringAsFixed(2));
      double total = unitaryValue * item.quantity;
      totalTerm += item.term;

      if (item.product != null) {
        totalProduct += total;
      } else {
        totalService += total;
      }
    }

    return (totalProduct, totalService, totalTerm);
  }

  Future<void> toShare(bool isPdf) async {
    if (isPdf) {
      await PdfGeneration.generatePdf();
    } else {
      await ImageGeneration.generateImage(globalKey);
    }
  }

  DateTime? getExpectedDeliveryDate(int totalTerm) {
    DateTime? expectedDeliveryDate;

    if (budget.approvalDate != null) {
      final (year, month, day, _, _) =
          UtilsService.extractDate(budget.approvalDate!);
      expectedDeliveryDate = UtilsService.addWorkingDays(
          DateTime(year, month, day + 1), totalTerm + 1);
    }
    return expectedDeliveryDate;
  }

  @override
  void initState() {
    super.initState();
    if (budget.approvalDate == null) return;

    final (year, month, day, _, _) =
        UtilsService.extractDate(budget.approvalDate!);

    approvalDate = UtilsService.dateFormatText(DateTime(year, month, day));
  }

  @override
  Widget build(BuildContext context) {
    final (year, month, day, hours, minutes) =
        UtilsService.extractDate(budget.createdAt!);

    final (double totalProduct, double totalService, int totalTerm) =
        _calculateTotalValueProductAndService(budget.itemsBudget!);

    DateTime? expectedDeliveryDate = getExpectedDeliveryDate(totalTerm);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Orçamento',
          style: textStyleMediumDefault,
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
          return Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset('assets/images/logo_rectangular_80.png'),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: profile!.fantasyName.toUpperCase(),
                        style: textStyleMediumFontWeight,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text:
                            '${profile!.address.streetAddress}, ${profile!.address.numberAddress}, ${profile!.address.district}',
                        style: textStyleMediumDefault,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text:
                            '${profile!.address.city} - ${profile!.address.state}',
                        style: textStyleMediumDefault,
                      ),
                    ),
                    Visibility(
                      visible: profile!.contact.email.isNotEmpty,
                      child: RichText(
                        text: TextSpan(
                          text: profile!.contact.email,
                          style: textStyleMediumDefault,
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: profile!.contact.cellPhone,
                        style: textStyleMediumDefault,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        text:
                            'ORDEM DE SERVIÇO - ${budget.orderId.toString().padLeft(5, '0')}',
                        style: textStyleLargeDefaultFontWeight,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text:
                            'Data: ${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year, ${hours.toString().padLeft(2, '0')}Hrs${minutes.toString().padLeft(2, '0')}min',
                        style: textStyleMediumDefault,
                      ),
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
                          RichText(
                            text: TextSpan(
                                text: 'Cliente: ${budget.client!.name}',
                                style: textStyleMediumDefault),
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
                              RichText(
                                text: const TextSpan(
                                    text: 'Contatos',
                                    style: textStyleMediumFontWeight),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text:
                                            'Cel: ${budget.client?.contact?.cellPhone ?? ''}',
                                        style: textStyleMediumDefault,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Flexible(
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: RichText(
                                          text: TextSpan(
                                            text:
                                                'Tel: ${budget.client?.contact?.telePhone ?? ''}',
                                            style: textStyleMediumDefault,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text:
                                      'E-mail: ${budget.client?.contact?.email ?? ''}',
                                  style: textStyleMediumDefault,
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Endereço do cliente
                      if (budget.client?.address != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: const TextSpan(
                                text: 'Endereço',
                                style: textStyleMediumFontWeight,
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text:
                                    'Bairro: ${budget.client?.address?.district}',
                                style: textStyleMediumDefault,
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text:
                                    'Localidade: ${budget.client?.address?.city} - ${budget.client?.address?.state}',
                                style: textStyleMediumDefault,
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'CEP: ${budget.client?.address?.cep}',
                                style: textStyleMediumDefault,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Tatbela dos produtos e serviços
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
                          RichText(
                            text: const TextSpan(
                              text: 'Total de Produtos: ',
                              style: textStyleMediumFontWeight,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: UtilsService.moneyToCurrency(totalProduct),
                              style: TextStyle(
                                fontSize: textStyleMediumDefault.fontSize,
                                fontFamily: 'Anta',
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RichText(
                            text: const TextSpan(
                              text: 'Total de Serviços: ',
                              style: textStyleMediumFontWeight,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: UtilsService.moneyToCurrency(totalService),
                              style: TextStyle(
                                fontSize: textStyleMediumDefault.fontSize,
                                fontFamily: 'Anta',
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RichText(
                            text: const TextSpan(
                              text: 'Frete: ',
                              style: textStyleMediumFontWeight,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: UtilsService.moneyToCurrency(
                                  budget.freight ?? 0),
                              style: TextStyle(
                                fontSize: textStyleMediumDefault.fontSize,
                                fontFamily: 'Anta',
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RichText(
                            text: const TextSpan(
                              text: 'Valor Total: ',
                              style: textStyleMediumFontWeight,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: UtilsService.moneyToCurrency(
                                  budget.amount ?? 0),
                              style: TextStyle(
                                fontSize: textStyleMediumDefault.fontSize,
                                fontFamily: 'Anta',
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Row(
                  children: [
                    RichText(
                      text: const TextSpan(
                        text: 'Situação atual: ',
                        style: textStyleMediumFontWeight,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: budget.status! == 'Em aberto'
                            ? 'Aguardando aprovação'
                            : budget.status!,
                        style: textStyleMediumDefault,
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: budget.approvalDate != null,
                  child: Row(
                    children: [
                      RichText(
                        text: const TextSpan(
                          text: 'Data de aprovação: ',
                          style: textStyleMediumFontWeight,
                        ),
                      ),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: RichText(
                            text: TextSpan(
                              text: approvalDate,
                              style: textStyleMediumDefault,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    RichText(
                      text: const TextSpan(
                        text: 'Previsão de entrega: ',
                        style: textStyleMediumFontWeight,
                      ),
                    ),
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: RichText(
                          text: TextSpan(
                            text: budget.status! == 'Em aberto'
                                ? '${totalTerm + 1} dias uteis após aprovação'
                                : UtilsService.dateFormatText(
                                    expectedDeliveryDate!),
                            style: textStyleMediumDefault,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    RichText(
                      text: const TextSpan(
                        text: 'Forma de Pagamento: ',
                        style: textStyleMediumFontWeight,
                      ),
                    ),
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                          text: budget.payment!.specie,
                          style: textStyleMediumDefault,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
