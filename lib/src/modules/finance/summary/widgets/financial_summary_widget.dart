// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';

class FinancialSummaryWidget extends StatelessWidget {
  final double value;
  final Color color;
  final String title;

  const FinancialSummaryWidget({
    super.key,
    required this.value,
    required this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: textStyleMediumDefault.fontFamily,
            fontSize: textStyleMediumDefault.fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          UtilsService.moneyToCurrency(value),
          style: TextStyle(
            fontFamily: 'Anta',
            fontSize: 23,
            color: color,
          ),
        ),
      ],
    );
  }
}
