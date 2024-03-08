import 'package:flutter/material.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class ListTileProfile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final EdgeInsetsGeometry? contentPadding;
  const ListTileProfile({
    super.key,
    required this.title,
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
        style: textStyleSmallDefault,
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
