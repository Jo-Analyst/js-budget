import 'package:flutter/material.dart';
import 'package:js_budget/src/pages/menu/widgets/custom_expansion_tile.dart';
import 'package:js_budget/src/pages/menu/widgets/list_tile_icon.dart';

import 'package:js_budget/src/themes/light_theme.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomExpansionTileWidget(
              title: 'Cadastro',
              icon: Icon(Icons.description_outlined),
              children: [
                ListTileIcon(
                  icon: Icons.person,
                  title: 'Clientes',
                ),
                ListTileIcon(
                  icon: Icons.local_shipping,
                  title: 'Fornecedores',
                ),
                ListTileIcon(
                  icon: Icons.build,
                  title: 'Materiais',
                ),
              ],
            ),
            const CustomExpansionTileWidget(
              title: 'Despesas',
              icon: Icon(Icons.money_off_sharp),
              children: [
                ListTileIcon(
                  icon: Icons.money,
                  title: 'Despesa pessoal',
                ),
                ListTileIcon(
                  title: 'Despesa da oficina',
                  icon: Icons.money_off_sharp,
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: .5,
                  ),
                ),
              ),
              child: ListTile(
                leading: const Icon(Icons.payments),
                title: Text(
                  'Pagamentos',
                  style: TextStyle(
                      fontFamily: textStyleSmallDefault.fontFamily,
                      fontSize: textStyleSmallDefault.fontSize,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const CustomExpansionTileWidget(
              icon: Icon(Icons.more_vert),
              title: 'Outras opçoes',
              children: [
                ListTileIcon(
                  icon: Icons.backup_table_rounded,
                  title: 'Backup',
                ),
                ListTileIcon(
                  icon: Icons.info_outline_rounded,
                  title: 'Sobre',
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .5 - 100,
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo_icon.png',
                      width: 150,
                    ),
                    const Text(
                      'Aplicativo criado por Joelmir Rogério Carvalho',
                      textAlign: TextAlign.center,
                      style: textStyleSmallDefault,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
