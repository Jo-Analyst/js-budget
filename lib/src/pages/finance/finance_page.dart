import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/expense_model.dart';
import 'package:js_budget/src/modules/expenses/personal_expenses/personal_expense_controller.dart';
import 'package:js_budget/src/modules/expenses/workshop_expenses/workshop_expense_controller.dart';
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
  final workshopExpenseController = Injector.get<WorkshopExpenseController>();
  List<ExpenseModel> personalExpenses = [], workshopExpenses = [];

  @override
  void initState() {
    super.initState();
    loadExpense();
  }

  Future<void> loadExpense() async {
    if (workshopExpenseController.data.isEmpty) {
      await workshopExpenseController.findExpense();
    }

    if (personalExpenseController.data.isEmpty) {
      await personalExpenseController.findExpense();
    }

    distributeExpensesIntoTheirRespectiveVariables(
        '${date[DateTime.now().month - 1]} de ${DateTime.now().year}');
  }

  Future<(List<ExpenseModel>, List<ExpenseModel>)> getExpenseByDate(
      String date) async {
    final personalExpenses = personalExpenseController.findExpenseByDate(date);
    final workshopExpenses =
        await workshopExpenseController.findExpenseDate(date);

    return (personalExpenses, workshopExpenses);
  }

  Future<void> distributeExpensesIntoTheirRespectiveVariables(
      String date) async {
    final (personalExpenses, workshopExpenses) = await getExpenseByDate(date);

    this.personalExpenses = personalExpenses;
    this.workshopExpenses = workshopExpenses;
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
        child: Watch((_) {
          double valueExpense = personalExpenseController.valueExpense.value;
          double valueWorshopExpense =
              workshopExpenseController.valueWorkshopExpense.value;
          return Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(color: theme.primaryColor),
                  ),
                ),
                child: SlideDate(
                  onGetDate: (date) =>
                      distributeExpensesIntoTheirRespectiveVariables(date),
                ),
              ),

              // Finanças pessoais
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                width: double.infinity,
                child: GestureDetector(
                  onTap: valueExpense > 0
                      ? () {
                          Navigator.of(context).pushNamed('/finance/summary',
                              arguments: (valueExpense, personalExpenses));
                        }
                      : null,
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
              ),

              // Finanças da oficina
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Finanças da oficina',
                            style: textStyleSmallFontWeight,
                          ),
                        ),
                        const Divider(),
                        const FinacialLastWidget(
                          title: 'Receita',
                          value: 3000,
                          textColor: Colors.green,
                        ),
                        const Divider(),
                        FinacialLastWidget(
                          title: 'Despesa',
                          value: valueWorshopExpense,
                          textColor: Colors.red,
                        ),
                        const Divider(),
                        const FinacialLastWidget(
                          title: 'V. Líquido',
                          value: 1000,
                          textColor: Colors.deepPurple,
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
            ],
          );
        }),
      ),
    );
  }
}
