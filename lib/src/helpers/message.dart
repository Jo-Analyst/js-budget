import 'package:flutter/material.dart';
import 'package:js_budget/src/helpers/show_toast.dart';

enum Position { top, bottom }

mixin class Messages {
  void showError(String message,
      {Position position = Position.bottom, int timeSeconds = 3}) {
    showToast(
      timeSeconds: timeSeconds,
      message: message,
      color: Colors.red,
      position: position,
      icon: const Icon(
        Icons.error,
        color: Colors.white,
      ),
    );
  }

  void showInfo(String message,
      {Position position = Position.bottom, int timeSeconds = 3}) {
    showToast(
      timeSeconds: timeSeconds,
      position: position,
      message: message,
      color: const Color.fromARGB(255, 20, 87, 143),
      icon: const Icon(
        Icons.info,
        color: Colors.white,
      ),
    );
  }

  void showSuccess(String message,
      {Position position = Position.bottom, int timeSeconds = 3}) {
    showToast(
      timeSeconds: timeSeconds,
      position: position,
      message: message,
      color: Colors.green,
      icon: const Icon(Icons.thumb_up),
    );
  }
}
