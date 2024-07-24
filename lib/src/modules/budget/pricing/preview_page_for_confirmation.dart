import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:js_budget/src/models/workshop_expense_items_budget_model.dart';
import 'package:js_budget/src/models/material_items_budget_model.dart';
import 'package:js_budget/src/modules/budget/pricing/pricing_controller.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class PreviewPageForConfirmation extends StatefulWidget {
  const PreviewPageForConfirmation({super.key});

  @override
  State<PreviewPageForConfirmation> createState() =>
      _PreviewPageForConfirmationState();
}

class _PreviewPageForConfirmationState
    extends State<PreviewPageForConfirmation> {
  final discountEC = MoneyMaskedTextController(leftSymbol: 'R\$ ');

  @override
  void dispose() {
    super.dispose();
    discountEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.get<PricingController>();

    final List<MaterialItemsBudgetModel> materialItems =
        controller.materialItemsBudget;

    final List<WorkshopExpenseItemsBudgetModel> expenseItems =
        controller.workshopExpenseItemsBudget;

    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: 80,
            height: 5,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Column(
                      children: [
                        // Custos dos materiais
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 15,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Custos dos materiais',
                                        style: textStyleMediumFontWeight,
                                      ),
                                      Column(
                                        children: materialItems
                                            .map(
                                              (item) => ListTile(
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        right: 15),
                                                leading: CircleAvatar(
                                                  child: Text(
                                                    '${item.quantity}x',
                                                    style: TextStyle(
                                                      fontFamily: 'Anta',
                                                      fontSize:
                                                          textStyleMediumDefault
                                                              .fontSize,
                                                    ),
                                                  ),
                                                ),
                                                title: Text(
                                                  item.material.name,
                                                  style: textStyleMediumDefault,
                                                ),
                                                trailing: Text(
                                                  UtilsService.moneyToCurrency(
                                                      item.value),
                                                  style: TextStyle(
                                                    fontFamily: 'Anta',
                                                    fontSize:
                                                        textStyleMediumDefault
                                                            .fontSize,
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 40),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Total:   ',
                                              style: TextStyle(
                                                fontFamily:
                                                    textStyleMediumDefault
                                                        .fontFamily,
                                                fontSize: textStyleMediumDefault
                                                    .fontSize,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  UtilsService.moneyToCurrency(
                                                      controller
                                                          .totalMaterialValue),
                                              style: const TextStyle(
                                                fontFamily: 'Anta',
                                                color: Color.fromARGB(
                                                    255, 56, 142, 59),
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        // Custos das despesas
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Custos das despesas',
                                        style: textStyleMediumFontWeight,
                                      ),
                                      Column(
                                        children: expenseItems
                                            .map(
                                              (item) => ListTile(
                                                subtitle: Text(
                                                  '${controller.term}x ${UtilsService.moneyToCurrency(item.dividedValue)}',
                                                  style: TextStyle(
                                                    fontFamily: 'Anta',
                                                    fontSize:
                                                        textStyleMediumDefault
                                                            .fontSize,
                                                  ),
                                                ),
                                                title: Text(
                                                  item.type,
                                                  style: textStyleMediumDefault,
                                                ),
                                                trailing: Text(
                                                  UtilsService.moneyToCurrency(
                                                      item.accumulatedValue),
                                                  style: TextStyle(
                                                    fontFamily: 'Anta',
                                                    fontSize:
                                                        textStyleMediumDefault
                                                            .fontSize,
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 40),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Total:   ',
                                              style: TextStyle(
                                                fontFamily:
                                                    textStyleMediumDefault
                                                        .fontFamily,
                                                fontSize: textStyleMediumDefault
                                                    .fontSize,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  UtilsService.moneyToCurrency(
                                                      controller
                                                          .totalExpenseValue),
                                              style: const TextStyle(
                                                fontFamily: 'Anta',
                                                color: Color.fromARGB(
                                                    255, 56, 142, 59),
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Column(
                              children: [
                                // Desconto
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Desconto',
                                        style: textStyleMediumFontWeight,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                .4,
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              suffixIcon: Icon(Icons.edit)),
                                          textAlign: TextAlign.right,
                                          controller: discountEC,
                                          onTapOutside: (_) =>
                                              FocusScope.of(context).unfocus(),
                                          style: TextStyle(
                                            fontFamily: 'Anta',
                                            fontSize:
                                                textStyleMediumDefault.fontSize,
                                          ),
                                          onChanged: (value) {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ListTile(
                                  contentPadding: const EdgeInsets.only(
                                      right: 15, left: 12),
                                  title: const Text(
                                    'Margem de lucro',
                                    style: textStyleMediumFontWeight,
                                  ),
                                  trailing: Text(
                                    UtilsService.moneyToCurrency(
                                        controller.calcProfitMargin),
                                    style: TextStyle(
                                      fontFamily: 'Anta',
                                      fontSize: textStyleLargeDefault.fontSize,
                                      fontWeight: FontWeight.w700,
                                      color: const Color.fromARGB(
                                          255, 17, 79, 130),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  contentPadding: const EdgeInsets.only(
                                      right: 15, left: 12),
                                  title: const Text(
                                    'Valor a cobrar',
                                    style: textStyleMediumFontWeight,
                                  ),
                                  trailing: Text(
                                    UtilsService.moneyToCurrency(
                                        controller.totalToBeCharged),
                                    style: TextStyle(
                                      fontFamily: 'Anta',
                                      fontSize: textStyleLargeDefault.fontSize,
                                      fontWeight: FontWeight.w700,
                                      color: const Color.fromARGB(
                                          255, 56, 142, 59),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                      },
                                      child: const Text(
                                        'Confirmar cobrança',
                                        style: textStyleMediumDefault,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
