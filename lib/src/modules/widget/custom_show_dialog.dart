import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:js_budget/src/themes/light_theme.dart';

Future<int?> showAlertDialog(BuildContext context, String content,
    {String buttonTitle = 'OK'}) {
  final formKey = GlobalKey<FormState>();
  return showDialog<int>(
    context: context,
    builder: (context) {
      int quantity = 1;

      return AlertDialog(
        title: Form(
          key: formKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
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
                  quantity = value.isNotEmpty ? int.parse(value) : 1;
                },
                style: textStyleSmallDefault,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite a quantidade';
                  } else if (int.parse(value) == 0) {
                    return 'Digite uma quantidade maior que zero';
                  }

                  return null;
                },
              )
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.black,
            ),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.of(context).pop(quantity);
              }
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
