import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class BudgetSuccessPage extends StatelessWidget {
  const BudgetSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Orçamento criado com sucesso',
              style: textStyleSmallFontWeight,
            ),
          ),
          SizedBox(
            height: 6,
          ),
          CircleAvatar(
            backgroundColor: Color.fromARGB(255, 20, 87, 143),
            maxRadius: 100,
            child: Icon(
              Icons.thumb_up,
              size: 100,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
