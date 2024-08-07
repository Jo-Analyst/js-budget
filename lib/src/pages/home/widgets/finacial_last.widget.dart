// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/flexible_text.dart';

import 'package:js_budget/src/utils/utils_service.dart';

class FinacialLastWidget extends StatelessWidget {
  final String title;
  final double value;
  final Color? textColor;
  final FontWeight? textFontWeight;

  const FinacialLastWidget({
    super.key,
    required this.title,
    required this.value,
    this.textColor,
    this.textFontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FlexibleText(text: title),
          FlexibleText(
            text: UtilsService.moneyToCurrency(value),
            colorText: textColor,
            maxFontSize: 19,
            fontFamily: 'Anta',
            fontWeight: textFontWeight,
          ),
        ],
      ),
    );
  }
}
