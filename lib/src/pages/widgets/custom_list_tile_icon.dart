import 'package:flutter/material.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class CustomListTileIcon extends StatelessWidget {
  final String title;
  final String? titleFontFamily;
  final String? subtitle;
  final Widget? leading;
  final EdgeInsetsGeometry? contentPadding;
  const CustomListTileIcon({
    super.key,
    required this.title,
    this.titleFontFamily,
    this.subtitle,
    this.leading,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: contentPadding ?? EdgeInsets.zero,
      leading: leading,
      title: Text(
        title,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: textStyleSmallDefault.fontSize,
          fontFamily: titleFontFamily ?? textStyleSmallDefault.fontFamily,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: TextStyle(
                fontSize: 16,
                fontFamily: textStyleSmallDefault.fontFamily,
              ),
            )
          : null,
    );
  }
}
