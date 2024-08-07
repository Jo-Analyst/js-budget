// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:js_budget/src/utils/flexible_text.dart';

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
        Flexible(
          child: FlexibleText(
            text: title,
            fontWeight: FontWeight.w600,
          ),
        ),
        Flexible(
          child: FlexibleText(
            text: UtilsService.moneyToCurrency(value),
            fontFamily: 'Anta',
            maxFontSize: 23,
            colorText: color,
          ),
        ),
      ],
    );
  }
}
