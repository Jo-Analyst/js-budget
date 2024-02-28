import 'package:flutter/material.dart';
import 'package:js_budget/src/pages/menu/widgets/Custom_Expansion_tile_widget.dart';

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
          ),
          CustomExpansionTileWidget(
            title: 'Despesas',
            icon: Icon(Icons.money_off_sharp),
          ),
        ],
      ),
    );
  }
}
