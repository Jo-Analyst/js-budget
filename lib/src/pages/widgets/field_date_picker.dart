import 'package:flutter/material.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class FieldDatePicker extends StatelessWidget {
  final DateTime? initialDate;
  final TextEditingController? controller;
  final String? labelText;
  final Function(DateTime date) onSelected;
  const FieldDatePicker({
    super.key,
    this.initialDate,
    this.controller,
    this.labelText,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            readOnly: true,
            controller: controller,
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: const TextStyle(fontFamily: 'Poppins'),
            ),
            style: textStyleSmallDefault,
          ),
        ),
        IconButton(
          onPressed: () {
            showDatePicker(
              firstDate: DateTime(2020),
              context: context,
              lastDate: DateTime.now(),
              initialDate: initialDate,
            ).then((date) {
              if (date != null) {
                onSelected(date);
              }
            });
          },
          icon: Icon(
            Icons.calendar_month,
            size: 35,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
