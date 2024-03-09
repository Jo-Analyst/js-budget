import 'package:flutter/material.dart';
import 'package:js_budget/src/models/fixed_expense_model.dart';
import 'package:js_budget/src/pages/fixed_expenses/fixed_expense_form_page.dart';
import 'package:js_budget/src/pages/widgets/column_tile.dart';
import 'package:js_budget/src/pages/widgets/custom_list_tile_icon.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class FixedExpenseDetailPage extends StatelessWidget {
  const FixedExpenseDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    IconData iconMethodPayment(String methodPayment) {
      switch (methodPayment.toLowerCase()) {
        case 'dinheiro':
          return Icons.money_sharp;
        case 'pix':
          return Icons.pix;
      }

      return Icons.credit_card;
    }

    final expense =
        ModalRoute.of(context)!.settings.arguments as FixedExpenseModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da oficina'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => FixedExpenseFormPage(
                    fixedExpense: expense,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            children: [
              Card(
                child: ColumnTile(
                  color: Colors.transparent,
                  textColor: Colors.black,
                  title: 'Tipo de despesa',
                  children: [
                    CustomListTileIcon(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15),
                      title: expense.type,
                      leading: const Icon(Icons.paid),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Card(
                child: ColumnTile(
                  color: Colors.transparent,
                  textColor: Colors.black,
                  title: '+ detalhes',
                  children: [
                    CustomListTileIcon(
                      title: UtilsService.moneyToCurrency(expense.value),
                      titleFontFamily: 'Anta',
                      leading: const Icon(Icons.attach_money),
                    ),
                    CustomListTileIcon(
                      title: expense.methodPayment,
                      leading: Icon(iconMethodPayment(expense.methodPayment)),
                    ),
                    CustomListTileIcon(
                      title: expense.date,
                      leading: const Icon(Icons.calendar_month),
                    ),
                    if (expense.observation != null)
                      Visibility(
                        visible: expense.observation!.isNotEmpty,
                        child: CustomListTileIcon(
                          title: expense.observation!,
                          leading: const Icon(Icons.note_alt_outlined),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
