import 'package:flutter/material.dart';

import 'package:js_budget/src/themes/light_theme.dart';

class ColumnTile extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Color? color;
  final Color? textColor;
  const ColumnTile({
    super.key,
    required this.title,
    required this.children,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 15,
          ),
          color: color ?? const Color.fromARGB(255, 20, 87, 143),
          child: Text(
            title,
            style: TextStyle(
              fontFamily: textStyleSmallDefault.fontFamily,
              fontSize: textStyleSmallDefault.fontSize,
              fontWeight: textStyleSmallFontWeight.fontWeight,
              color: textColor ?? Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
