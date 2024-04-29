import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/fixed_expense_items_budget_model.dart';
import 'package:js_budget/src/models/material_items_budget_model.dart';
import 'package:js_budget/src/modules/budget/pricing/pricing_controller.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class PreviewPageForConfirmation extends StatelessWidget {
  const PreviewPageForConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.get<PricingController>();

    final List<MaterialItemsBudgetModel> materialItems =
        controller.materialItemsBudget;

    final List<FixedExpenseItemsBudgetModel> expenseItems =
        controller.fixedExpenseItemsBudget;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmação'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.check,
              size: 30,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // Custos dos materiais
            Flexible(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Custos dos materiais',
                                style: textStyleSmallFontWeight,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: materialItems
                                        .map(
                                          (item) => ListTile(
                                            leading: CircleAvatar(
                                              child: Text(
                                                '${item.quantity}x',
                                                style: TextStyle(
                                                  fontFamily: 'Anta',
                                                  fontSize:
                                                      textStyleSmallDefault
                                                          .fontSize,
                                                ),
                                              ),
                                            ),
                                            title: Text(
                                              item.material.name,
                                              style: textStyleSmallDefault,
                                            ),
                                            trailing: Text(
                                              UtilsService.moneyToCurrency(
                                                  item.value),
                                              style: TextStyle(
                                                fontFamily: 'Anta',
                                                fontSize: textStyleSmallDefault
                                                    .fontSize,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                                          textStyleSmallDefault.fontFamily,
                                      fontSize: textStyleSmallDefault.fontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: UtilsService.moneyToCurrency(
                                        controller.totalMaterialValue),
                                    style: const TextStyle(
                                      fontFamily: 'Anta',
                                      color: Color.fromARGB(255, 56, 142, 59),
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
            ),

            // Custos das despesas
            Flexible(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Custos das despesas',
                                style: textStyleSmallFontWeight,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: expenseItems
                                        .map(
                                          (item) => ListTile(
                                            subtitle: Text(
                                              '${controller.term}x ${UtilsService.moneyToCurrency(item.dividedValue)}',
                                              style: TextStyle(
                                                fontFamily: 'Anta',
                                                fontSize: textStyleSmallDefault
                                                    .fontSize,
                                              ),
                                            ),
                                            title: Text(
                                              item.type,
                                              style: textStyleSmallDefault,
                                            ),
                                            trailing: Text(
                                              UtilsService.moneyToCurrency(
                                                  item.accumulatedValue),
                                              style: TextStyle(
                                                fontFamily: 'Anta',
                                                fontSize: textStyleSmallDefault
                                                    .fontSize,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                                          textStyleSmallDefault.fontFamily,
                                      fontSize: textStyleSmallDefault.fontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: UtilsService.moneyToCurrency(
                                        controller.totalExpenseValue),
                                    style: const TextStyle(
                                      fontFamily: 'Anta',
                                      color: Color.fromARGB(255, 56, 142, 59),
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
            ),
            Card(
              child: Column(
                children: [
                  ListTile(
                    title: const Text(
                      'Margem de lucro',
                      style: textStyleSmallFontWeight,
                    ),
                    trailing: Text(
                      UtilsService.moneyToCurrency(controller.profitMargin),
                      style: TextStyle(
                          fontFamily: 'Anta',
                          fontSize: textStyleLargeDefault.fontSize,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromARGB(255, 17, 79, 130)),
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'Valor a cobrar',
                      style: textStyleSmallFontWeight,
                    ),
                    trailing: Text(
                      UtilsService.moneyToCurrency(
                          controller.totalToBeCharged),
                      style: TextStyle(
                        fontFamily: 'Anta',
                        fontSize: textStyleLargeDefault.fontSize,
                        fontWeight: FontWeight.w700,
                        color: const Color.fromARGB(255, 56, 142, 59),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
