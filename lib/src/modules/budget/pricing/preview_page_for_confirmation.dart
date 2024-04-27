import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:js_budget/src/models/fixed_expense_items_budget_model.dart';
import 'package:js_budget/src/models/material_items_budget_model.dart';
import 'package:js_budget/src/models/material_model.dart';
import 'package:js_budget/src/pages/widgets/column_tile.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class PreviewPageForConfirmation extends StatelessWidget {
  const PreviewPageForConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    final List<MaterialItemsBudgetModel> materialItems = [
      MaterialItemsBudgetModel(
        material: MaterialModel(
          name: 'Madeira de Carvalho',
          unit: 'Unidade',
          price: 30.00,
          quantity: 30,
        ),
        value: 30,
        quantity: 1,
      ),
      MaterialItemsBudgetModel(
        material: MaterialModel(
          name: 'Cola',
          unit: 'Unidade',
          price: 10.00,
          quantity: 30,
        ),
        value: 10,
        quantity: 1,
      ),
    ];

    final List<FixedExpenseItemsBudgetModel> expenseItems = [
      FixedExpenseItemsBudgetModel(
        value: 60,
        dividedValue: 2,
        accumulatedValue: 6,
        type: 'Conta de Luz',
      ),
      FixedExpenseItemsBudgetModel(
        value: 60,
        dividedValue: 2,
        accumulatedValue: 6,
        type: 'Conta de água',
      ),
      FixedExpenseItemsBudgetModel(
        value: 300,
        dividedValue: 20,
        accumulatedValue: 60,
        type: 'Aluguel',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmação'),
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
                        child: SingleChildScrollView(
                          child: ColumnTile(
                            title: 'Custos dos materiais',
                            children: [
                              Column(
                                children: materialItems
                                    .map(
                                      (item) => ListTile(
                                        leading: CircleAvatar(
                                          child: Text(
                                            '${item.quantity}x',
                                            style: TextStyle(
                                              fontFamily: 'Anta',
                                              fontSize: textStyleSmallDefault
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
                                            fontSize:
                                                textStyleSmallDefault.fontSize,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.only(right: 25),
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
                                    text: UtilsService.moneyToCurrency(40),
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
                        child: SingleChildScrollView(
                          child: ColumnTile(
                            title: 'Custos das despesas',
                            children: [
                              Column(
                                children: expenseItems
                                    .map(
                                      (item) => ListTile(
                                        subtitle: Text(
                                          '3x ${item.dividedValue}',
                                          style: TextStyle(
                                            fontFamily: 'Anta',
                                            fontSize:
                                                textStyleSmallDefault.fontSize,
                                          ),
                                        ),
                                        title: Text(
                                          item.type,
                                          style: textStyleSmallDefault,
                                        ),
                                        trailing: Text(
                                          UtilsService.moneyToCurrency(
                                              item.value),
                                          style: TextStyle(
                                            fontFamily: 'Anta',
                                            fontSize:
                                                textStyleSmallDefault.fontSize,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.only(right: 25),
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
                                    text: UtilsService.moneyToCurrency(420),
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
          ],
        ),
      ),
    );
  }
}
