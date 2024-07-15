import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/expenses/personal_expenses/personal_expense_controller.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';
import 'package:signals/signals_flutter.dart';

class PersonalExpensePage extends StatefulWidget {
  const PersonalExpensePage({super.key});

  @override
  State<PersonalExpensePage> createState() => _PersonalExpensePageState();
}

class _PersonalExpensePageState extends State<PersonalExpensePage> {
  final controller = Injector.get<PersonalExpenseController>();
  String search = '';

  @override
  void initState() {
    super.initState();
    controller.findExpense();
  }

  @override
  Widget build(BuildContext context) {
    var filteredClients = controller.data
        .watch(context)
        .where((expense) =>
            expense.description.toLowerCase().contains(search.toLowerCase()))
        .toList();

    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesa pessoal'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/expense/personal/form');
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
            child: filteredClients.isEmpty
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
                              Navigator.of(context)
                                  .pushNamed('/expense/personal/form');
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                            label: const Text(
                              'Adicionar despesa',
                              style: textStyleMediumDefault,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView(
                    children: filteredClients
                        .map((expense) => Column(
                              children: [
                                ListTile(
                                  splashColor: Colors.transparent,
                                  onTap: () async {
                                    await Navigator.of(context).pushNamed(
                                        '/expense/personal/details',
                                        arguments: expense);

                                    controller.model.value = null;
                                  },
                                  leading: const Icon(
                                      Icons.monetization_on_outlined),
                                  title: Text(
                                    expense.description,
                                    style: textStyleMediumDefault,
                                  ),
                                  subtitle: Text(
                                    expense.date,
                                    style: TextStyle(
                                      fontSize: textStyleMediumDefault.fontSize,
                                    ),
                                  ),
                                  trailing: Text(
                                    UtilsService.moneyToCurrency(expense.value),
                                    style: TextStyle(
                                      fontFamily: 'Anta',
                                      fontSize: textStyleMediumDefault.fontSize,
                                    ),
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
