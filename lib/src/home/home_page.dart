import 'package:flutter/material.dart';
import 'package:js_budget/src/home/widgets/finance_widget.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Finanças',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    // horizontal: 15,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(100),
                            child: InkWell(
                              splashColor: theme.splashColor,
                              borderRadius: BorderRadius.circular(100),
                              onTap: () {},
                              child: Ink(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.primaryColor,
                                  border: Border.all(
                                    color: theme.primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Text("Finanças pessoais",
                                    style: lightThemeTitleSmall),
                              ),
                            ),
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(100),
                            child: InkWell(
                              splashColor: theme.splashColor,
                              borderRadius: BorderRadius.circular(100),
                              onTap: () {},
                              child: Ink(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: theme.primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Text("Finanças da oficina",
                                    style: lightThemeTitleSmall),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.keyboard_arrow_left,
                              size: 30,
                            ),
                          ),
                          const Text(
                            'Janeiro de 2024',
                            style: lightThemeTitleSmall,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.keyboard_arrow_right,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Divider(),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FinanceWidget(title: 'Receita', value: 25.00),
                          FinanceWidget(title: 'Despesa', value: 15.00),
                          FinanceWidget(title: 'T. Líquido', value: 10.00),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
