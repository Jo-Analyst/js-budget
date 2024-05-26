import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/expense_model.dart';
import 'package:js_budget/src/modules/expenses/personal_expenses/personal_expense_controller.dart';
import 'package:js_budget/src/modules/widget/slide_date.dart';
import 'package:js_budget/src/pages/home/widgets/finacial_last.widget.dart';
import 'package:js_budget/src/pages/widgets/more_details_widget.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/list_month.dart';
import 'package:signals/signals_flutter.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({super.key});

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  final personalExpenseController = Injector.get<PersonalExpenseController>();
  List<ExpenseModel> expenses = [];

  @override
  void initState() {
    super.initState();
    loadExpense();
  }

  Future<void> loadExpense() async {
    if (personalExpenseController.data.isEmpty) {
      await personalExpenseController.findExpense();
    }

    expenses = getExpenseByDate(
        '${date[DateTime.now().month - 1]} de ${DateTime.now().year}');
  }

  List<ExpenseModel> getExpenseByDate(String date) {
    return personalExpenseController.findExpenseByDate(date);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.auto_graph),
            SizedBox(
              width: 5,
            ),
            Text('Finanças'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(color: theme.primaryColor),
                ),
              ),
              child: SlideDate(
                onGetDate: (date) {
                  expenses = getExpenseByDate(date);
                },
              ),
            ),

            // Finanças pessoais
            Watch((_) {
              double valueExpense =
                  personalExpenseController.valueExpense.value;
              return GestureDetector(
                onTap: valueExpense > 0
                    ? () {
                        Navigator.of(context).pushNamed(
                          '/finance/summary',
                          arguments: (valueExpense, expenses),
                        );
                      }
                    : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  width: double.infinity,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              'Finanças pessoais',
                              style: textStyleSmallFontWeight,
                            ),
                          ),
                          const Divider(),
                          FinacialLastWidget(
                            title: 'Despesas pessoais',
                            value: valueExpense,
                            textColor: Colors.red,
                          ),
                          const Divider(),
                          const Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: MoreDetailsWidget(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),

            // Finanças da oficina
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              width: double.infinity,
              child: const Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Finanças da oficina',
                          style: textStyleSmallFontWeight,
                        ),
                      ),
                      Divider(),
                      FinacialLastWidget(
                        title: 'Receita',
                        value: 3000,
                        textColor: Colors.green,
                      ),
                      Divider(),
                      FinacialLastWidget(
                        title: 'Despesa',
                        value: 2000,
                        textColor: Colors.red,
                      ),
                      Divider(),
                      FinacialLastWidget(
                        title: 'V. Líquido',
                        value: 1000,
                        textColor: Colors.deepPurple,
                      ),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: MoreDetailsWidget(),
                      ),
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
