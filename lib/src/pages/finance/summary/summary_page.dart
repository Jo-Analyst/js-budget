import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:js_budget/src/models/expense_model.dart';
import 'package:js_budget/src/pages/finance/summary/widgets/summary_total_widget.dart';
import 'package:js_budget/src/pages/widgets/list_view_tile.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final (valueExpense, expenses) = ModalRoute.of(context)!.settings.arguments
        as (double, List<ExpenseModel>);
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
              'Resumo - Mês de ${expenses.first.date.toString().substring(6)}'),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ListView(
                children: expenses
                    .map((expense) => Card(
                          child: Column(
                            children: [
                              Text(
                                expense.date,
                                style: textStyleSmallDefault,
                              ),
                              const Divider(),
                              ListTile(
                                leading: const Icon(Icons.money),
                                title: Text(
                                  expense.type,
                                  style: textStyleSmallDefault,
                                ),
                                subtitle: Text(
                                  UtilsService.moneyToCurrency(expense.value),
                                  style: TextStyle(
                                      fontFamily: 'Anta',
                                      fontSize: textStyleSmallDefault.fontSize),
                                ),
                                trailing: Text(
                                  expense.methodPayment,
                                  style: textStyleSmallDefault,
                                ),
                              )
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Theme.of(context).primaryColor.withOpacity(.3),
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Total Despesa',
                  style: textStyleSmallDefault,
                ),
                Text(
                  UtilsService.moneyToCurrency(valueExpense),
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Anta'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
