import 'package:flutter/material.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:overlay_support/overlay_support.dart';

showToast({
  required String message,
  Color? color,
  Icon? icon,
}) {
  showSimpleNotification(
    Text(
      message,
      style: TextStyle(
        fontFamily: textStyleSmallDefault.fontFamily,
        fontSize: textStyleSmallDefault.fontSize,
        color: Colors.white,
      ),
    ),
    background: color,
  );
}
