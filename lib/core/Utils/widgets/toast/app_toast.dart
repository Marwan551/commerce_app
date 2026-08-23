import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class AppToast {
  AppToast._();

  static void show(
    BuildContext context, {
    required String message,
    required ToastificationType type,
  }) {
    toastification.show(
      context: context,
      title: Text(message),
      autoCloseDuration: const Duration(seconds: 3),
      type: type,
      style: ToastificationStyle.fillColored,
    );
  }
}
