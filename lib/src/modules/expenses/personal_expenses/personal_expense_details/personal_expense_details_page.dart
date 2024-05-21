import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/expense_model.dart';
import 'package:js_budget/src/modules/expenses/personal_expenses/personal_expense_controller.dart';
import 'package:js_budget/src/modules/material/widget/show_confirmation_dialog.dart';
import 'package:js_budget/src/pages/widgets/listView_tile.dart';
import 'package:js_budget/src/pages/widgets/custom_list_tile_icon.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class PersonalExpenseDetailsPage extends StatelessWidget {
  const PersonalExpenseDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = context.get<PersonalExpenseController>();
    var nav = Navigator.of(context);
    IconData iconMethodPayment(String methodPayment) {
      switch (methodPayment.toLowerCase()) {
        case 'dinheiro':
          return Icons.money_sharp;
        case 'pix':
          return Icons.pix;
      }

      return Icons.credit_card;
    }

    final expense = ModalRoute.of(context)!.settings.arguments as ExpenseModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da conta pessoal'),
        actions: [
          IconButton(
            onPressed: () {
              controller.model.value = expense;
              nav.pushNamed('/expense/personal/form');
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () async {
              final confirm = await showConfirmationDialog(
                      context, 'Deseja mesmo excluir esta despesa?') ??
                  false;

              if (confirm) {
                controller.deleteExpense(expense.id);
                nav.pop();
              }
            },
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
                child: ListViewTile(
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
                child: ListViewTile(
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
