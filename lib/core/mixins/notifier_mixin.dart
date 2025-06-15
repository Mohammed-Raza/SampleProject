import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

mixin ToastNotifier {
  static showNewToast(String title, String description,
      {int? time,
      ToastificationType type = ToastificationType.info,
      ToastificationStyle? style,
      AlignmentGeometry? alignment}) {
    return toastification.show(
      title: Text(title),
      description: Text(description),
      type: type,
      icon: Icon(_getToastIcon(type)),
      autoCloseDuration: Duration(seconds: time ?? 3),
      style: style ?? ToastificationStyle.flatColored,
      alignment: alignment ?? Alignment.bottomCenter,
    );
  }

  static showSnackBar(
      String label, GlobalKey<ScaffoldState> scaffoldKey, context,
      {Color color = Colors.teal, Color textColor = Colors.white}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: color,
        content: Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.apply(color: textColor),
        )));
  }

  static IconData _getToastIcon(ToastificationType type) {
    switch (type) {
      case ToastificationType.info:
        return Icons.info_outline;
      case ToastificationType.success:
        return Icons.verified_outlined;
      case ToastificationType.error:
        return Icons.error_outline;
      case ToastificationType.warning:
        return Icons.warning_amber;
      default:
        return Icons.info_outline;
    }
  }
}
