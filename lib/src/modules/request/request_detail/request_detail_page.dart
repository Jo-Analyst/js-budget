import 'package:flutter/material.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class RequestDetailPage extends StatelessWidget {
  const RequestDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedido'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Fazer orçamento',
                  style: textStyleSmallDefault,
                )),
          )
        ],
      ),
      body: Container(),
    );
  }
}
