import 'package:flutter/material.dart';
import 'package:js_budget/src/themes/light_theme.dart';

import 'package:js_budget/src/utils/utils_service.dart';

class SummaryTotalWidget extends StatelessWidget {
  final double value;
  final Color? textColor;

  const SummaryTotalWidget({
    Key? key,
    required this.value,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 8, top: 0),
        child: ListTile(
          minVerticalPadding: 0,
          contentPadding: const EdgeInsets.only(right: 0),
          title: const Text(
            'T. Despesa',
            style: textStyleSmallDefault,
          ),
          subtitle: Text(
            UtilsService.moneyToCurrency(value),
            style: TextStyle(
                color: textColor,
                fontSize: 22,
                fontWeight: FontWeight.w600,
                fontFamily: 'Anta'),
          ),
          trailing: GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                ),
              ),
              alignment: Alignment.center,
              width: 80,
              child: const Icon(
                Icons.keyboard_arrow_right,
                size: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
