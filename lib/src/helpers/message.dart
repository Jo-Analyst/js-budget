import 'package:flutter/material.dart';
import 'package:js_budget/src/helpers/show_toast.dart';

mixin class Messages {
  void showError(String message) {
    showToast(message, Colors.red);
  }

  void showInfo(String message) {
    showToast(message, const Color.fromARGB(255, 20, 87, 143));
  }

  void showSuccess(String message) {
    showToast(message, const Color.fromARGB(255, 47, 109, 49));
  }
}
