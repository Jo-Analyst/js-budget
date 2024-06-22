import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/expense_model.dart';
import 'package:js_budget/src/modules/expenses/personal_expenses/personal_expense_controller.dart';
import 'package:js_budget/src/modules/expenses/workshop_expenses/workshop_expense_controller.dart';
import 'package:js_budget/src/modules/finance/finance_controller.dart';
import 'package:js_budget/src/modules/payment/payment_history/payment_history_controller.dart';
import 'package:js_budget/src/modules/widget/slide_date.dart';
import 'package:js_budget/src/pages/home/widgets/finacial_last.widget.dart';
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
  final paymentHistoryController = Injector.get<PaymentHistoryController>();
  final financeController = Injector.get<FinanceController>();
  List<ExpenseModel> personalExpenses = [], workshopExpenses = [];
  double valueExpense = 0.0, valueWorshopExpense = 0.0, revenue = 0.0;

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

    distributeFinancesIntoTheirRespectiveVariables(
        '${date[DateTime.now().month - 1]} de ${DateTime.now().year}');
  }

  Future<(List<ExpenseModel>, List<ExpenseModel>)> getExpenseByDate(
      String date) async {
    final personalExpenses = personalExpenseController.findExpenseByDate(date);
    final workshopExpenses =
        await workshopExpenseController.findExpenseDate(date);

    return (personalExpenses, workshopExpenses);
  }

  Future<void> distributeFinancesIntoTheirRespectiveVariables(
      String date) async {
    final (personalExpenses, workshopExpenses) = await getExpenseByDate(date);

    paymentHistoryController.sumAmountPaidByDate(date);

    this.personalExpenses = personalExpenses;
    this.workshopExpenses = workshopExpenses;
  }

  double calculateNerValue() {
    return revenue - valueWorshopExpense;
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
          valueExpense = personalExpenseController.valueExpense.value;
          valueWorshopExpense =
              workshopExpenseController.valueWorkshopExpense.value;
          revenue = paymentHistoryController.sumAmountPaid.value;
          double netValue = calculateNerValue();
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
                      distributeFinancesIntoTheirRespectiveVariables(date),
                ),
              ),

              // Finanças pessoais
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    bool isValid = financeController
                        .validateFieldPersonalExpense(valueExpense);

                    if (!isValid) return;

                    Navigator.of(context).pushNamed('/finance/personal/summary',
                        arguments: (valueExpense, personalExpenses));
                  },
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
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
              // Finanças da oficina
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    bool isValid =
                        financeController.validateFieldWorkshopExpense(
                            revenue, valueWorshopExpense);

                    if (!isValid) return;

                    Navigator.of(context)
                        .pushNamed('/finance/workshop/summary', arguments: (
                      revenue,
                      netValue,
                      valueWorshopExpense,
                      workshopExpenses,
                    ));
                  },
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
                          FinacialLastWidget(
                            title: 'Receita',
                            value: revenue,
                            textColor: const Color.fromARGB(255, 20, 87, 143),
                          ),
                          const Divider(),
                          FinacialLastWidget(
                            title: 'Despesa',
                            value: valueWorshopExpense,
                            textColor: Colors.orangeAccent,
                          ),
                          const Divider(),
                          FinacialLastWidget(
                            title: 'Valor Líquido',
                            value: netValue,
                            textColor: netValue < 0
                                ? Colors.red
                                : netValue == 0
                                    ? Colors.purple
                                    : Colors.green,
                          ),
                        ],
                      ),
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
