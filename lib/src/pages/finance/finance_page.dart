import 'package:flutter/material.dart';
import 'package:js_budget/src/pages/home/widgets/finacial_last.widget.dart';
import 'package:js_budget/src/pages/widgets/more_details_widget.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class FinancePage extends StatelessWidget {
  const FinancePage({super.key});

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_circle_left_outlined,
                      size: 30,
                    ),
                  ),
                  const Text.rich(
                    TextSpan(children: [
                      TextSpan(text: 'Janeiro de '),
                      TextSpan(
                        text: '2024',
                        style: TextStyle(fontFamily: 'Anta'),
                      ),
                    ], style: textStyleLargeDefault),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_circle_right_outlined,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),

            // Finanças pessoais
            Container(
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
                      const FinacialLastWidget(
                        title: 'Despesas pessoais',
                        value: 1500,
                        textColor: Colors.red,
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/summary');
                          },
                          child: const MoreDetailsWidget(),
                        ),
                      ),
                    ],
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
