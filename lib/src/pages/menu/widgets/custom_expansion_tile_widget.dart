// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class CustomExpansionTileWidget extends StatelessWidget {
  final String title;
  final Icon? icon;
  final List<Widget>? children;
  const CustomExpansionTileWidget({
    super.key,
    required this.title,
    this.icon,
    this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: .5,
          ),
        ),
      ),
      child: ExpansionTile(
        shape: const Border.symmetric(
          vertical: BorderSide.none,
          horizontal: BorderSide.none,
        ),
        collapsedShape: const Border.symmetric(
          vertical: BorderSide.none,
          horizontal: BorderSide.none,
        ),
        leading: icon,
        title: Text(
          title,
          style: textStyleSmallDefault,
        ),
      ),
    );
  }
}
