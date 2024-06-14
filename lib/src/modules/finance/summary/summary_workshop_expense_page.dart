import 'package:flutter/material.dart';
import 'package:js_budget/src/models/expense_model.dart';
import 'package:js_budget/src/modules/finance/summary/widgets/financial_summary_widget.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class SummaryWorkshopExpensePage extends StatelessWidget {
  const SummaryWorkshopExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    final (sumAmountPaid, netValue, valueWorshopExpense, workshopExpenses) =
        ModalRoute.of(context)!.settings.arguments as (
      double,
      double,
      double,
      List<ExpenseModel>
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Resumo - Mês de ${workshopExpenses.first.date.toString().substring(6)}'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15, top: 10),
            child: Text(
              'Despesas',
              style: textStyleSmallFontWeight,
            ),
          ),

          // Despesas
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: workshopExpenses
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
                                expense.description,
                                style: textStyleSmallDefault,
                              ),
                              subtitle: Text(
                                expense.date,
                                style: textStyleSmallDefault,
                              ),
                              trailing: Text(
                                UtilsService.moneyToCurrency(expense.value),
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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Column(
                children: [
                  FinancialSummaryWidget(
                    title: 'Receita',
                    value: sumAmountPaid,
                    color: const Color.fromARGB(255, 20, 87, 143),
                  ),
                  const Divider(),
                  FinancialSummaryWidget(
                    title: 'Despesa',
                    value: valueWorshopExpense,
                    color: Colors.orangeAccent,
                  ),
                  const Divider(),
                  FinancialSummaryWidget(
                    title: 'Valor líquido',
                    value: netValue,
                    color: netValue < 0
                        ? Colors.red
                        : netValue == 0
                            ? Colors.purple
                            : Colors.green,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
