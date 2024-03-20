import 'package:flutter/material.dart';
import 'package:js_budget/src/models/personal_expense_model.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class PersonalExpensePage extends StatefulWidget {
  const PersonalExpensePage({super.key});

  @override
  State<PersonalExpensePage> createState() => _PersonalExpensePageState();
}

class _PersonalExpensePageState extends State<PersonalExpensePage> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    final expenses = [
      PersonalExpenseModel(
        type: 'Alimentação',
        value: 450.75,
        date: '09/03/2024',
        methodPayment: 'Cartão de crédito',
        observation:
            'asdsajkdhkasjhdkjashdkjhjkashdjhsajkdhashjashdkjashdjkhasjkd asdsajkdhkasjhdkjashdkjhjkashdjhsajkdhashjashdkjashdjkhasjkd',
      )
    ];
    var filteredClients = expenses
        .where((expense) =>
            expense.type.toLowerCase().contains(search.toLowerCase()))
        .toList();

    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesa pessoal'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/expense/personal/register');
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
                          style: textStyleSmallDefault,
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
                                  .pushNamed('/expense/personal/register');
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                            label: const Text(
                              'Adicionar despesa',
                              style: textStyleSmallDefault,
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
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        '/expense/personal/details',
                                        arguments: expense);
                                  },
                                  leading: const Icon(
                                      Icons.monetization_on_outlined),
                                  title: Text(
                                    expense.type,
                                    style: textStyleSmallDefault,
                                  ),
                                  subtitle: Text(
                                    expense.date,
                                    style: TextStyle(
                                      fontSize: textStyleSmallDefault.fontSize,
                                    ),
                                  ),
                                  trailing: Text(
                                    UtilsService.moneyToCurrency(expense.value),
                                    style: TextStyle(
                                      fontFamily: 'Anta',
                                      fontSize: textStyleSmallDefault.fontSize,
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
