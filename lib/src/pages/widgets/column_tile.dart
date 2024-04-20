// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:js_budget/src/themes/light_theme.dart';

class ColumnTile extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Widget? leading;
  final Widget? trailing;
  final Color? color;
  final Color? textColor;
  const ColumnTile({
    Key? key,
    required this.title,
    required this.children,
    this.leading,
    this.trailing,
    this.color,
    this.textColor,
  }) : super(key: key);

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
          color: color,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (leading != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: leading!,
                    ),
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: textStyleSmallDefault.fontFamily,
                      fontSize: textStyleSmallDefault.fontSize,
                      fontWeight: textStyleSmallFontWeight.fontWeight,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              trailing ?? Container()
            ],
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
