import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/expenses/workshop_expenses/workshop_expense_controller.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/flexible_text.dart';
import 'package:js_budget/src/utils/utils_service.dart';
import 'package:signals/signals_flutter.dart';

class WorkshopExpensePage extends StatefulWidget {
  const WorkshopExpensePage({super.key});

  @override
  State<WorkshopExpensePage> createState() => _PersonalExpensePageState();
}

class _PersonalExpensePageState extends State<WorkshopExpensePage> {
  String search = '';
  final controller = Injector.get<WorkshopExpenseController>();

  @override
  void initState() {
    super.initState();
    if (controller.data.isEmpty) {
      controller.findExpense();
    }
  }

  @override
  Widget build(BuildContext context) {
    var filteredExpense = controller.data
        .watch(context)
        .where((expense) =>
            (expense.description.toLowerCase().contains(search.toLowerCase()) &&
                expense.materialId == null))
        .toList();

    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesa fixa da oficina'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/expense/workshop/form');
            },
            tooltip: "Nova despesa",
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              textInputAction: TextInputAction.search,
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Buscar tipo de despesa',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: filteredExpense.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.person_search_sharp,
                          size: 100,
                          color: theme.colorScheme.primary.withOpacity(.7),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Nenhuma despesa encontrado',
                          textAlign: TextAlign.center,
                          style: textStyleMediumDefault,
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 48,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/expense/workshop/form');
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                            label: const FlexibleText(
                              text: 'Adicionar despesa',
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView(
                    children: filteredExpense
                        .map((expense) => Column(
                              children: [
                                ListTile(
                                  splashColor: Colors.transparent,
                                  onTap: () async {
                                    await Navigator.of(context).pushNamed(
                                        '/expense/workshop/details',
                                        arguments: expense);
                                    controller.model.value = null;
                                  },
                                  leading: const Icon(
                                      Icons.monetization_on_outlined),
                                  title: FlexibleText(
                                    text: expense.description,
                                  ),
                                  subtitle: FlexibleText(
                                    text: expense.date,
                                    fontFamily: 'Anta',
                                  ),
                                  trailing: FlexibleText(
                                    text: UtilsService.moneyToCurrency(
                                        expense.value),
                                    fontFamily: 'Anta',
                                  ),
                                ),
                                const Divider(),
                              ],
                            ))
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
