import 'package:flutter/material.dart';
import 'package:js_budget/src/pages/home/widgets/finacial_last.widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Topo
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: 150,
            color: theme.primaryColor,
            child: Row(
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

          // título
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(vertical: 6),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(color: theme.primaryColor),
              ),
            ),
            child: Text(
              'Finanças do mês atual',
              style: TextStyle(
                fontSize: theme.textTheme.titleSmall!.fontSize,
                fontWeight: FontWeight.w700,
              ),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Finanças pessoais',
                        style: TextStyle(
                          fontSize: theme.textTheme.titleSmall!.fontSize,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Divider(),
                    const FinacialLastWidget(
                      title: 'Despesas pessoais',
                      value: 1500,
                      textColor: Colors.red,
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
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Finanças da oficina',
                        style: TextStyle(
                          fontSize: theme.textTheme.titleSmall!.fontSize,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Divider(),
                    const FinacialLastWidget(
                      title: 'Receita',
                      value: 3000,
                      textColor: Colors.green,
                    ),
                    const Divider(),
                    const FinacialLastWidget(
                      title: 'Despesa',
                      value: 2000,
                      textColor: Colors.red,
                    ),
                    const Divider(),
                    const FinacialLastWidget(
                      title: 'V. Líquido',
                      value: 1000,
                      textColor: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: "asd",
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
