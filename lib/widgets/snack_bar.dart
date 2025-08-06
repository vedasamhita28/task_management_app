import 'package:flutter/material.dart';

enum SnackbarType { success, error, info }

class CustomSnackbar {
  static void show({
    required BuildContext context,
    required String message,
    SnackbarType type = SnackbarType.info,
    Duration duration = const Duration(seconds: 3),
    IconData? icon,
  }) {
    Color backgroundColor;
    IconData defaultIcon;

    switch (type) {
      case SnackbarType.success:
        backgroundColor = Colors.green;
        defaultIcon = Icons.check_circle;
        break;
      case SnackbarType.error:
        backgroundColor = Colors.red;
        defaultIcon = Icons.error;
        break;
      case SnackbarType.info:
      default:
        backgroundColor = Colors.black87;
        defaultIcon = Icons.info;
        break;
    }

    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Row(
        children: [
          Icon(icon ?? defaultIcon, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
              child:
                  Text(message, style: const TextStyle(color: Colors.white))),
        ],
      ),
      duration: duration,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
