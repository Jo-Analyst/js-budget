import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:js_budget/src/themes/light_theme.dart';

Future<int?> showAlertDialog(BuildContext context, String content,
    {String buttonTitle = 'OK'}) {
  return showDialog<int>(
    context: context,
    builder: (context) {
      int quantity = 0;

      return AlertDialog(
        title: Column(
          children: [
            Text(
              content,
              style: textStyleSmallDefault,
            ),
            TextFormField(
              autofocus: true,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  labelText: 'Quantidade',
                  labelStyle: TextStyle(fontFamily: 'Poppins')),
              onChanged: (value) {
                quantity = value.isNotEmpty ? int.parse(value) : 0;
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
