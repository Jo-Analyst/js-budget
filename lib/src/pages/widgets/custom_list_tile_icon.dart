// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/flexible_text.dart';

class CustomListTileIcon extends StatelessWidget {
  final String title;
  final String? titleFontFamily;
  final String? subtitle;
  final Widget? leading;
  final FontWeight? titleFontWeight;
  final EdgeInsetsGeometry? contentPadding;
  const CustomListTileIcon({
    Key? key,
    required this.title,
    this.titleFontFamily,
    this.subtitle,
    this.leading,
    this.titleFontWeight,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: contentPadding ?? EdgeInsets.zero,
      leading: leading,
      title: FlexibleText(
        text: title,
        fontFamily: titleFontFamily ?? textStyleMediumDefault.fontFamily,
        fontWeight: titleFontWeight,
      ),
      subtitle: subtitle != null
          ? FlexibleText(
              text: subtitle!,
              maxFontSize: 17.5,
            )
          : null,
    );
  }
}
