import 'package:flutter/material.dart';
import 'package:js_budget/src/helpers/message.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:overlay_support/overlay_support.dart';

showToast(
    {required String message,
    Color? color,
    Icon? icon,
    required Position position,
    required int timeSeconds}) {
  showSimpleNotification(
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        message,
        style: TextStyle(
          fontFamily: textStyleMediumDefault.fontFamily,
          fontSize: textStyleMediumDefault.fontSize,
          color: Colors.white,
        ),
      ),
    ),
    background: color,
    leading: icon,
    position: position == Position.bottom
        ? NotificationPosition.bottom
        : NotificationPosition.top,
    duration: Duration(seconds: timeSeconds),
  );
}
