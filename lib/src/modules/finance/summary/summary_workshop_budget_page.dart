import 'package:flutter/material.dart';
import 'package:js_budget/src/models/workshop_expense_items_budget_model.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class SummaryWorkshopBudgetPage extends StatelessWidget {
  const SummaryWorkshopBudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final (workShopExpense, totalTerm) = ModalRoute.of(context)!
        .settings
        .arguments as (List<WorkshopExpenseItemsBudgetModel>, int);

    return Scaffold(
      appBar: AppBar(
        title: const FittedBox(
            fit: BoxFit.scaleDown, child: Text('Balanço Geral')),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15, top: 10),
            child: Text(
              'Matérias primas',
              style: textStyleSmallFontWeight,
            ),
          ),
          Expanded(
              child: Container(
            color: Theme.of(context).primaryColor,
          )),

          const Padding(
            padding: EdgeInsets.only(left: 15, top: 10),
            child: Text(
              'Custos Indiretos',
              style: textStyleSmallFontWeight,
            ),
          ),

          // Custos Indiretos
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: workShopExpense
                      .map(
                        (expense) => Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(
                                Icons.monetization_on_outlined,
                                size: 30,
                              ),
                              title: Text(
                                expense.type,
                                style: textStyleSmallDefault,
                              ),
                              subtitle: Text(
                                '${totalTerm}x ${UtilsService.moneyToCurrency(expense.dividedValue)}',
                                style: textStyleSmallDefault,
                              ),
                              trailing: Text(
                                UtilsService.moneyToCurrency(
                                    (totalTerm * expense.dividedValue)),
                                style: TextStyle(
                                  fontFamily: 'Anta',
                                  fontSize: textStyleSmallDefault.fontSize,
                                ),
                              ),
                            ),
                            const Divider()
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),

          // Resumo das finanças
          Container(
            color: const Color.fromRGBO(248, 242, 242, 1),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Column(
                children: [
                  // FinancialSummaryWidget(
                  //   title: 'Receita',
                  //   value: sumAmountPaid,
                  //   color: const Color.fromARGB(255, 20, 87, 143),
                  // ),
                  // const Divider(),
                  // FinancialSummaryWidget(
                  //   title: 'Despesa',
                  //   value: valueWorshopExpense,
                  //   color: Colors.orangeAccent,
                  // ),
                  // const Divider(),
                  // FinancialSummaryWidget(
                  //   title: 'Valor líquido',
                  //   value: netValue,
                  //   color: netValue < 0
                  //       ? Colors.red
                  //       : netValue == 0
                  //           ? Colors.purple
                  //           : Colors.green,
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
