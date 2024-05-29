import 'package:flutter/material.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class PersonalizedPaymentButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function() onTap;

  const PersonalizedPaymentButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      onPressed: onTap,
      icon: Icon(
        icon,
      ),
      label: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          label.toUpperCase(),
          style: textStyleSmallDefault,
        ),
      ),
    );
  }
}
