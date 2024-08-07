import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:js_budget/src/models/workshop_expense_items_budget_model.dart';
import 'package:js_budget/src/models/material_items_budget_model.dart';
import 'package:js_budget/src/modules/budget/budget_controller.dart';
import 'package:js_budget/src/modules/budget/pricing/pricing_controller.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/flexible_text.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class PreviewPageForConfirmation extends StatefulWidget {
  const PreviewPageForConfirmation({super.key});

  @override
  State<PreviewPageForConfirmation> createState() =>
      _PreviewPageForConfirmationState();
}

class _PreviewPageForConfirmationState
    extends State<PreviewPageForConfirmation> {
  final pricingController = Injector.get<PricingController>();
  final budgetController = Injector.get<BudgetController>();
  double amountToBeCharged = 0.0;

  List<MaterialItemsBudgetModel> materialItems = [];

  List<WorkshopExpenseItemsBudgetModel> expenseItems = [];
  final discountEC = MoneyMaskedTextController(leftSymbol: 'R\$ ');

  @override
  void initState() {
    super.initState();
    materialItems = pricingController.materialItemsBudget;
    expenseItems = pricingController.workshopExpenseItemsBudget;
    amountToBeCharged = pricingController.totalToBeCharged;
    discountEC.updateValue(budgetController.subDiscount.value);
    discountValue();
  }

  void discountValue() {
    setState(() {
      amountToBeCharged =
          pricingController.totalToBeCharged - discountEC.numberValue;
    });
  }

  @override
  void dispose() {
    super.dispose();
    discountEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                                      FlexibleText(
                                        text: 'Custos dos materiais',
                                        fontWeight: textStyleMediumFontWeight
                                            .fontWeight,
                                      ),
                                      Column(
                                        children: materialItems
                                            .map(
                                              (item) => Row(
                                                children: [
                                                  CircleAvatar(
                                                    child: FlexibleText(
                                                      text: '${item.quantity}x',
                                                      fontFamily: 'Anta',
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Flexible(
                                                    child: FlexibleText(
                                                      text: item.material.name,
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: FlexibleText(
                                                      text: UtilsService
                                                          .moneyToCurrency(
                                                              item.value),
                                                      fontFamily: 'Anta',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Flexible(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: FlexibleText(
                                                text: 'Total',
                                                fontWeight:
                                                    textStyleMediumFontWeight
                                                        .fontWeight,
                                              ),
                                            ),
                                            Flexible(
                                              child: FlexibleText(
                                                text: UtilsService
                                                    .moneyToCurrency(
                                                        pricingController
                                                            .totalMaterialValue),
                                                fontWeight:
                                                    textStyleMediumFontWeight
                                                        .fontWeight,
                                                fontFamily: 'Anta',
                                                colorText: const Color.fromARGB(
                                                    255, 56, 142, 59),
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
                                      FlexibleText(
                                        text: 'Custos das despesas',
                                        fontWeight: textStyleMediumFontWeight
                                            .fontWeight,
                                      ),
                                      Column(
                                        children: expenseItems
                                            .map(
                                              (item) => ListTile(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                subtitle: FlexibleText(
                                                  text:
                                                      '${pricingController.term}x ${UtilsService.moneyToCurrency(item.dividedValue)}',
                                                  fontFamily: 'Anta',
                                                ),
                                                title: FlexibleText(
                                                  text: item.type,
                                                ),
                                                trailing: FlexibleText(
                                                  text: UtilsService
                                                      .moneyToCurrency(item
                                                          .accumulatedValue),
                                                  fontFamily: 'Anta',
                                                  maxFontSize: 18,
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Flexible(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: FlexibleText(
                                                text: 'Total',
                                                fontWeight:
                                                    textStyleMediumFontWeight
                                                        .fontWeight,
                                              ),
                                            ),
                                            Flexible(
                                              child: FlexibleText(
                                                text: UtilsService
                                                    .moneyToCurrency(
                                                        pricingController
                                                            .totalExpenseValue),
                                                fontWeight:
                                                    textStyleMediumFontWeight
                                                        .fontWeight,
                                                fontFamily: 'Anta',
                                                colorText: const Color.fromARGB(
                                                    255, 56, 142, 59),
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
                              horizontal: 15,
                              vertical: 10,
                            ),
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
                                      const Flexible(
                                        child: FlexibleText(
                                          text: 'Desconto',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                .45,
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            suffixIcon: Icon(Icons.local_offer),
                                          ),
                                          textAlign: TextAlign.right,
                                          controller: discountEC,
                                          onTapOutside: (_) =>
                                              FocusScope.of(context).unfocus(),
                                          style: TextStyle(
                                            fontFamily: 'Anta',
                                            fontSize:
                                                textStyleMediumDefault.fontSize,
                                          ),
                                          onChanged: (_) => discountValue(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ListTile(
                                  contentPadding: const EdgeInsets.only(
                                    right: 15,
                                    left: 12,
                                  ),
                                  title: FlexibleText(
                                    text: 'Margem de lucro',
                                    fontWeight:
                                        textStyleMediumFontWeight.fontWeight,
                                  ),
                                  trailing: FlexibleText(
                                    text: UtilsService.moneyToCurrency(
                                        pricingController.calcProfitMargin),
                                    fontFamily: 'Anta',
                                    fontWeight:
                                        textStyleMediumFontWeight.fontWeight,
                                    colorText:
                                        const Color.fromARGB(255, 17, 79, 130),
                                  ),
                                ),
                                ListTile(
                                  contentPadding: const EdgeInsets.only(
                                      right: 15, left: 12),
                                  title: FlexibleText(
                                    text: 'Valor a cobrar',
                                    fontWeight:
                                        textStyleMediumFontWeight.fontWeight,
                                  ),
                                  trailing: FlexibleText(
                                    text: UtilsService.moneyToCurrency(
                                        amountToBeCharged),
                                    fontFamily: 'Anta',
                                    fontWeight:
                                        textStyleMediumFontWeight.fontWeight,
                                    colorText:
                                        const Color.fromARGB(255, 56, 142, 59),
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
                                      budgetController.subDiscount.value =
                                          discountEC.numberValue;
                                      pricingController.totalToBeCharged =
                                          amountToBeCharged;
                                      Navigator.of(context).pop(true);
                                    },
                                    child: const FlexibleText(
                                      text: 'Confirmar cobrança',
                                      colorText: Colors.black,
                                    ),
                                  ),
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
