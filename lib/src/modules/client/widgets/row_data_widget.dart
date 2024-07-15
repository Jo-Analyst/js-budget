// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class RowDataWidget extends StatelessWidget {
  final String title;
  final String text;
  const RowDataWidget({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Row(
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$title: ',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(text: text),
              ],
              style: textStyleMediumDefault,
            ),
          ),
        ],
      ),
    );
  }
}
