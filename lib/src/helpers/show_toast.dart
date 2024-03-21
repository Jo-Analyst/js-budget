import 'package:flutter/material.dart';
import 'package:overlay_toast_message/overlay_toast_message.dart';

showToast({
  required String message,
  Color? color,
  required BuildContext context,
  Icon? icon,
}) {
  OverlayToastMessage.show(
    context,
    widget: Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: icon,
        title: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    ),
  );
}
