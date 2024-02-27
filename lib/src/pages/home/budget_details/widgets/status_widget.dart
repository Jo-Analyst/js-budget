import 'package:flutter/material.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> status = [
      {'desc': 'Em aberto', 'isChecked': true},
      {'desc': 'Aprovado', 'isChecked': false},
      {'desc': 'Concluído', 'isChecked': false},
    ];
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'Status do orçamento',
            style: textStyleSmallFontWeight,
          ),
        ),
        Column(
          children: status.map(
            (st) {
              String desc = st['desc'];
              bool isChecked = st['isChecked'];

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ListTile(
                      leading: Icon(
                        isChecked ? Icons.check : null,
                        color: Colors.deepPurple,
                        size: 30,
                      ),
                      title: Text(
                        desc,
                        style: textStyleSmallDefault,
                      ),
                    ),
                  ),const Divider()
                ],
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
