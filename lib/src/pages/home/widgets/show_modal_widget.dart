import 'package:flutter/material.dart';

class Modal {
  static Future<dynamic> showModal(BuildContext context, Widget content,
      {double scrollControlDisabledMaxHeightRatio = .8}) async {
    return showModalBottomSheet<dynamic>(
      scrollControlDisabledMaxHeightRatio: scrollControlDisabledMaxHeightRatio,
      context: context,
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.deepPurple,
                ),
                width: 50,
                height: 3,
              ),
              Expanded(child: content)
            ],
          ),
        );
      },
    );
  }
}
