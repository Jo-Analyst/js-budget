// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/flexible_text.dart';

class PersonalizedPaymentButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function() onTap;
  final Color? backgroundColor;
  final Color? color;

  const PersonalizedPaymentButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.backgroundColor,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: 30,
            ),
            const SizedBox(width: 5),
            Flexible(
              child: FlexibleText(
                text: label,
                colorText: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
