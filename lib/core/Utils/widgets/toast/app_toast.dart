import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class AppToast {
  static void showSuccess(BuildContext context, String message) {
    toastification.show(
      context: context,
      title: Text(message),
      autoCloseDuration: const Duration(seconds: 3),
      type: ToastificationType.success,
      style: ToastificationStyle.fillColored,
    );
  }

  static void showError(BuildContext context, String message) {
    toastification.show(
      context: context,
      title: Text(message),
      autoCloseDuration: const Duration(seconds: 3),
      type: ToastificationType.error,
      style: ToastificationStyle.fillColored,
    );
  }
}
