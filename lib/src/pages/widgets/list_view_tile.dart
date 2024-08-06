import 'package:flutter/material.dart';

import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/flexible_text.dart';

enum AxisListDirection { horizontal, vertical }

class ListViewTile extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final VoidCallback? onTap;
  final Widget? leading;
  final Widget? trailing;
  final AxisListDirection axis;
  final Color? color;
  final Color? textColor;
  const ListViewTile({
    Key? key,
    required this.title,
    required this.children,
    this.onTap,
    this.leading,
    this.trailing,
    this.axis = AxisListDirection.vertical,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 15,
            ),
            color: color,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      if (leading != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: leading!,
                        ),
                      Flexible(
                        child: FlexibleText(
                          text: title,
                          fontWeight: textStyleMediumFontWeight.fontWeight,
                          colorText: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                trailing ?? Container()
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: axis == AxisListDirection.vertical
              ? Column(
                  children: children,
                )
              : Row(
                  children: children,
                ),
        ),
      ],
    );
  }
}
