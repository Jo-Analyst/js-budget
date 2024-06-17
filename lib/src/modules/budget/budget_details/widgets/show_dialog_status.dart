import 'package:flutter/material.dart';
import 'package:js_budget/src/themes/light_theme.dart';

List<Map<String, dynamic>> situations = [
  {'status': 'Em aberto', 'isChecked': false},
  {'status': 'Aprovado', 'isChecked': false},
  {'status': 'Concluído', 'isChecked': false},
  {'status': 'Cancelado', 'isChecked': false},
];

Future<String?> showDialogStatus(BuildContext context) {
  return showDialog<String>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Column(
            children: [
              Column(
                children: situations.map((st) {
                  return Column(
                    children: [
                      ListTile(
                        splashColor: Colors.transparent,
                        // onTap: () => selectStatus(st),
                        // leading: Icon(
                        //   isChecked ? Icons.check : null,
                        //   color: Colors.deepPurple,
                        //   size: 25,
                        // ),
                        title: Text(
                          st['status'],
                          style:
                              //  isChecked
                              //     ? TextStyle(
                              //         color: Colors.deepPurple,
                              //         fontWeight:
                              //             textStyleSmallFontWeight.fontWeight,
                              //         fontSize: textStyleSmallFontWeight.fontSize)
                              // :
                              textStyleSmallDefault,
                        ),
                      ),
                      const Divider()
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      textStyle: textStyleSmallDefault),
                  onPressed: () {},
                  child: const Text(
                    'Próximo',
                  ),
                ),
              ),
            ],
          ),
        );
      });
}
