// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:js_budget/src/themes/light_theme.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    Key? key,
    required this.title,
    required this.text,
    this.isNull = false,
    this.isEmpty = false,
  }) : super(key: key);

  final String title;
  final String text;
  final bool isNull;
  final bool isEmpty;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !isNull && !isEmpty,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(top: 3),
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
          ),
          const Divider()
        ],
      ),
    );
  }
}
