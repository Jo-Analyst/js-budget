import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:js_budget/src/themes/light_theme.dart';

Future<String?> showAlertDialog(BuildContext context, String content,
    {String buttonTitle = 'OK'}) {
  return showDialog<String>(
    context: context,
    builder: (context) {
      String quantity = '0';
      return AlertDialog(
        title: Column(
          children: [
            Text(
              content,
              style: textStyleSmallDefault,
            ),
            TextFormField(
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  labelText: 'Quantidade em estoque',
                  labelStyle: TextStyle(fontFamily: 'Poppins')),
              onChanged: (value) {
                quantity = value;
              },
              style: textStyleSmallDefault,
            )
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop(quantity);
            },
            child: Text(
              buttonTitle,
              style: textStyleSmallDefault,
            ),
          ),
        ],
      );
    },
  );
}
