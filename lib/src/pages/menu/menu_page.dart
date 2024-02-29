import 'package:flutter/material.dart';
import 'package:js_budget/src/pages/menu/widgets/custom_expansion_tile.dart';

import 'package:js_budget/src/themes/light_theme.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: const Column(
        children: [
          CustomExpansionTileWidget(
            title: 'Cadastro',
            icon: Icon(Icons.description_outlined),
            children: [
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Clientes', style: textStyleSmallDefault),
              ),
              ListTile(
                leading: Icon(Icons.build),
                title: Text('Materiais', style: textStyleSmallDefault),
              ),
            ],
          ),
          CustomExpansionTileWidget(
            title: 'Despesas',
            icon: Icon(Icons.money_off_sharp),
          ),
          ListTile(
            leading: Icon(Icons.payments),
            title: Text('Pagamentos', style: textStyleSmallDefault),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}
