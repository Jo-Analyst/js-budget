import 'package:flutter/material.dart';
import 'package:js_budget/src/models/expense_model.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/flexible_text.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class SummaryPersonalExpensePage extends StatelessWidget {
  const SummaryPersonalExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    final (valueExpense, expenses) = ModalRoute.of(context)!.settings.arguments
        as (double, List<ExpenseModel>);
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: FlexibleText(
            text:
                'Gastos pessoais - Mês de ${expenses.first.date.toString().substring(6)}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ListView(
                children: expenses
                    .map((expense) => Card(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: FlexibleText(
                                    text: expense.date,
                                    fontWeight:
                                        textStyleMediumFontWeight.fontWeight,
                                  ),
                                ),
                                const Divider(),
                                ListTile(
                                  leading: const Icon(Icons.money),
                                  title: FlexibleText(
                                    text: expense.description,
                                  ),
                                  subtitle: FlexibleText(
                                    text: UtilsService.moneyToCurrency(
                                        expense.value),
                                    fontFamily: 'Anta',
                                  ),
                                  trailing: FlexibleText(
                                    text: expense.methodPayment,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: theme.primaryColor.withOpacity(.3),
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const FlexibleText(text: 'Total Despesa'),
                FlexibleText(
                  text: UtilsService.moneyToCurrency(valueExpense),
                  colorText: Colors.red,
                  maxFontSize: 22,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Anta',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
