import 'package:flutter/material.dart';
import 'package:js_budget/src/pages/home/widgets/filtering_options_widget.dart';
import 'package:js_budget/src/pages/widgets/more_details_widget.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> budgets = [
    {
      "id": 1,
      "name": "Joelmir Carvalho",
      "status": "Em aberto",
      "value": 2500.0,
      "date": "25/02/2024",
    },
    {
      "id": 2,
      "name": "Valdirene Ferreira",
      "status": "Em aberto",
      "value": 2500.0,
      "date": "25/02/2024",
    },
    {
      "id": 3,
      "name": "Noelly Silva",
      "status": "Em aberto",
      "value": 2500.0,
      "date": "25/02/2024",
    },
    {
      "id": 4,
      "name": "Benneditto Santos",
      "status": "Em aberto",
      "value": 2500.0,
      "date": "25/02/2024",
    },
  ];

  List<Map<String, dynamic>> filteringOptions = [
    {'type': 'Tudo', 'isSelected': true},
    {'type': 'Em aberto', 'isSelected': false},
    {'type': 'Aprovado', 'isSelected': false},
    {'type': 'Concluído', 'isSelected': false},
  ];

  void filterList(Map<String, dynamic> filter) {
    for (var options in filteringOptions) {
      options['isSelected'] = false;
    }
    setState(() {
      filter['isSelected'] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(103, 242, 218, 187),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Image.asset(
                'assets/images/logo_icon.png',
                width: 80,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: const [
                      TextSpan(
                        text: 'Olá, ',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(text: 'João Antônio!'),
                    ],
                    style: TextStyle(
                      fontSize: theme.textTheme.titleSmall!.fontSize,
                    ),
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: const [
                      TextSpan(
                        text: 'Razão Social: ',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(text: 'JS Planejar'),
                    ],
                    style: TextStyle(
                      fontSize: theme.textTheme.titleSmall!.fontSize,
                    ),
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: const [
                      TextSpan(
                        text: 'CNPJ: ',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(text: '00.000.000/0000-00'),
                    ],
                    style: TextStyle(
                      fontSize: theme.textTheme.titleSmall!.fontSize,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: budgets.isEmpty
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.insert_chart_rounded,
                    size: 80,
                  ),
                  Text(
                    'Nenhum orçamento aberto',
                    style: textTitleLarge,
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: 5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: filteringOptions
                          .map(
                            (filter) => GestureDetector(
                              onTap: () {
                                filterList(filter);
                              },
                              child: FilteringOptionsWidget(
                                title: filter['type'],
                                backgroundColor: filter['isSelected']
                                    ? Colors.deepPurple
                                    : theme.primaryColor,
                                fontWeight: filter['isSelected']
                                    ? FontWeight.w500
                                    : FontWeight.w600,
                                textColor:
                                    filter['isSelected'] ? Colors.white : null,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: budgets.length,
                      itemBuilder: (context, index) {
                        final budget = budgets[index];
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Orçamento: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700),
                                        ),
                                        TextSpan(
                                          text: budget['id']
                                              .toString()
                                              .padLeft(5, '0'),
                                          style: const TextStyle(
                                              fontFamily: 'Anta'),
                                        ),
                                      ],
                                      style: TextStyle(
                                        fontSize: theme
                                            .textTheme.titleSmall!.fontSize,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${budget['name']}',
                                      style: TextStyle(
                                        fontSize: theme
                                            .textTheme.titleSmall!.fontSize,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      budget['status'],
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 20, 87, 143),
                                        fontSize: theme
                                            .textTheme.titleSmall!.fontSize,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: UtilsService.moneyToCurrency(
                                            budget['value']),
                                      ),
                                      TextSpan(
                                        text: ' - ${budget['date']}',
                                      ),
                                    ],
                                    style: TextStyle(
                                      fontSize:
                                          theme.textTheme.titleSmall!.fontSize,
                                      fontFamily: 'Anta',
                                      color: const Color.fromARGB(
                                          255, 20, 87, 143),
                                    ),
                                  ),
                                ),
                                const Divider(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed('/budge-details', arguments: budget);
                                  },
                                  child: const MoreDetailsWidget(),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            UtilsService.moneyToCurrency(10000),
                            style: const TextStyle(
                              fontFamily: "Anta",
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // showModal(context, const NewTransaction());
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
