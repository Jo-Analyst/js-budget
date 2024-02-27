import 'package:flutter/material.dart';

class Modal {
  static void showModal(BuildContext context, Widget widget) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * .5,
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
              widget
            ],
          ),
        );
      },
    );
  }
}
