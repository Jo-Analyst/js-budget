import 'package:flutter/material.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:overlay_support/overlay_support.dart';

showToast({
  required String message,
  Color? color,
  Icon? icon,
}) {
  showSimpleNotification(
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        message,
        style: TextStyle(
          fontFamily: textStyleSmallDefault.fontFamily,
          fontSize: textStyleSmallDefault.fontSize,
          color: Colors.white,
        ),
      ),
    ),
    background: color,
    leading: icon,
    position: NotificationPosition.bottom,
    duration: const Duration(seconds: 3),
  );
}
