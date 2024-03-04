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
            // Menu de Cadastro

            CustomExpansionTileWidget(
              title: 'Cadastro',
              icon: const Icon(Icons.description_outlined),
              children: [
                ListTileIcon(
                  icon: Icons.person,
                  title: 'Clientes',
                  onTap: () {
                    Navigator.of(context).pushNamed('/clients');
                  },
                ),
                ListTileIcon(
                  icon: Icons.build,
                  title: 'Materiais',
                  onTap: () {
                    Navigator.of(context).pushNamed('/material');
                  },
                ),
              ],
            ),

            // Menu de despesa

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

            //  Menu de pedidos

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
                leading: const Icon(Icons.assignment),
                title: Text(
                  'Pedidos',
                  style: TextStyle(
                    fontFamily: textStyleSmallDefault.fontFamily,
                    fontSize: textStyleSmallDefault.fontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            // Outras opções

            const CustomExpansionTileWidget(
              icon: Icon(Icons.more_vert),
              title: 'Outras opções',
              children: [
                ListTileIcon(
                  icon: Icons.account_circle,
                  title: 'Perfil',
                ),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo_icon.png',
                    width: 150,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Aplicativo JS Planejar',
                    textAlign: TextAlign.center,
                    style: textStyleSmallDefault,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
