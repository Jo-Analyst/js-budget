import 'package:flutter/material.dart';
import 'package:js_budget/src/utils/flexible_text.dart';

class BudgetFilteringStatusWidget extends StatelessWidget {
  final String title;
  final Color? backgroundColor;
  final Color? textColor;
  final FontWeight? fontWeight;

  const BudgetFilteringStatusWidget({
    Key? key,
    required this.title,
    this.backgroundColor,
    this.textColor,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 5,
      ),
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: backgroundColor,
      ),
      child: FlexibleText(
        text: title,
        maxFontSize: 18,
        colorText: textColor,
        fontWeight: fontWeight,
      ),
    );
  }
}
