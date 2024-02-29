import 'package:flutter/material.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class ListTileIcon extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const ListTileIcon({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon),
      title: Text(title, style: textStyleSmallDefault),
    );
  }
}
