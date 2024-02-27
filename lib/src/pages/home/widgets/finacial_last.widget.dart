// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:js_budget/src/themes/light_theme.dart';

import 'package:js_budget/src/utils/utils_service.dart';

class FinacialLastWidget extends StatelessWidget {
  final String title;
  final double value;
  final Color? textColor;

  const FinacialLastWidget({
    super.key,
    required this.title,
    required this.value,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: textStyleSmallDefault),
          Text(
            UtilsService.moneyToCurrency(value),
            style:
                TextStyle(color: textColor, fontSize: 19, fontFamily: 'Anta'),
          ),
        ],
      ),
    );
  }
}
