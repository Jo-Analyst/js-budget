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
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Status do orçamento',
              style: textStyleSmallFontWeight,
            ),
          ),
          const Divider(),
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
                          size: 25,
                        ),
                        title: Text(
                          desc,
                          style: isChecked
                              ? TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight:
                                      textStyleSmallFontWeight.fontWeight,
                                  fontSize: textStyleSmallFontWeight.fontSize)
                              : textStyleSmallDefault,
                        ),
                      ),
                    ),
                    const Divider()
                  ],
                );
              },
            ).toList(),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              onPressed: () {},
              child: Text(
                'Alterar Status',
                style: TextStyle(
                    fontSize: textStyleSmallDefault.fontSize,
                    fontFamily: textStyleSmallDefault.fontFamily),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
