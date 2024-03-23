import 'package:flutter/material.dart';
import 'package:js_budget/src/themes/light_theme.dart';

Future<bool?> showConfirmationDialog(BuildContext context, String content,
    {String buttonTitle = 'OK', String buttonCancel = 'Cancelar'}) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          content,
          style: textStyleSmallDefault,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              buttonCancel,
              style: TextStyle(
                fontSize: textStyleSmallDefault.fontSize,
                fontFamily: textStyleSmallDefault.fontFamily,
                color: Colors.black,
              ),
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            label: Text(
              buttonTitle,
              style: TextStyle(
                fontSize: textStyleSmallDefault.fontSize,
                fontFamily: textStyleSmallDefault.fontFamily,
                color: Colors.white,
              ),
            ),
            icon: const Icon(
              Icons.thumb_up,
              color: Colors.white,
              size: 25,
            ),
          ),
        ],
      );
    },
  );
}
