import 'package:flutter/material.dart';
import 'package:js_budget/src/helpers/show_toast.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:overlay_support/overlay_support.dart';

mixin class Messages {
  void showError(String message) {
    showToast(
      message: message,
      color: Colors.red,
      icon: const Icon(
        Icons.error,
        color: Colors.white,
      ),
    );
  }

  void showInfo(String message) {
    showToast(
      message: message,
      color: const Color.fromARGB(255, 20, 87, 143),
      icon: const Icon(
        Icons.info,
        color: Colors.white,
      ),
    );
  }

  void showSuccess(String message) {
    showSimpleNotification(
        Text(
          message,
          style: textStyleSmallDefault,
        ),
        background: Colors.green);
  }
}

// mixin MessageStateMixin {
//   final Signal<String?> _errorMessage = signal(null);
//   String? get errorMessage => _errorMessage();

//   final Signal<String?> _infoMessage = signal(null);
//   String? get infoMessage => _infoMessage();

//   final Signal<String?> _successMessage = signal(null);
//   String? get successMessage => _successMessage();

//   void clearError() => _errorMessage.value = null;
//   void clearInfo() => _infoMessage.value = null;
//   void clearSuccess() => _successMessage.value = null;

//   void showError(String message) {
//     untracked(() => clearError());
//     _errorMessage.value = message;
//   }

//   void showInfo(String message) {
//     untracked(() => clearInfo());
//     _infoMessage.value = message;
//   }

//   void showSuccess(String message) {
//     untracked(() => clearSuccess());
//     _successMessage.value = message;
//   }

//   void clearAllMessages() {
//     untracked(() {
//       clearError();
//       clearInfo();
//       clearSuccess();
//     });
//   }
// }

// mixin MessageViewMixin<T extends StatefulWidget> on State<T> {
//   void messageListener(MessageStateMixin state) {
//     effect(() {
//       switch (state) {
//         case MessageStateMixin(:final errorMessage?):
//           Messages.showError(errorMessage, context);
//         case MessageStateMixin(:final infoMessage?):
//           Messages.showInfo(infoMessage, context);
//         case MessageStateMixin(:final successMessage?):
//           Messages.showSuccess(successMessage, context);
//       }
//     });
//   }
// }
