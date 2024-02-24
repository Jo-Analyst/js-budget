import 'package:flutter/material.dart';
import 'package:js_budget/src/pages/home/widgets/finacial_last.widget.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.insert_chart_rounded,
              size: 80,
            ),
            Text(
              'Nenhum orçamento aberto',
              style: textTitleSmall,
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
