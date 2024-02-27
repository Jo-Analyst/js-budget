import 'package:flutter/material.dart';

class Modal {
  static void showModal(BuildContext context, Widget widget) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          height: 270,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.deepPurple,
                ),
                width: 50,
                height: 5,
              ),
              widget
            ],
          ),
        );
      },
    );
  }
}
