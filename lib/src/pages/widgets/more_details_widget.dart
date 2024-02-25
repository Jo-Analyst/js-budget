import 'package:flutter/material.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class MoreDetailsWidget extends StatelessWidget {
  const MoreDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Ver mais detalhes',
          style: TextStyle(
            color: Colors.blue,
            fontSize: textTitleSmall.fontSize,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            width: 50,
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
            ),
            child: const Icon(
              Icons.keyboard_arrow_right,
              size: 30,
            ),
          ),
        )
      ],
    );
  }
}
