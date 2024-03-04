// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:js_budget/src/themes/light_theme.dart';

class InfoClientWidget extends StatelessWidget {
  const InfoClientWidget({
    Key? key,
    required this.title,
    required this.text,
    this.isNull = false,
  }) : super(key: key);

  final String title;
  final String text;
  final bool isNull;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !isNull,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$title: ',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: text,
                ),
              ],
              style: textStyleSmallDefault,
            ),
          ),
        ),
      ),
    );
  }
}
