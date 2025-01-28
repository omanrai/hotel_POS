import 'package:flutter/material.dart';

void showSuccessSnackBar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white), // ✅ Ensure text is visible
      ),
      backgroundColor: color, // ✅ Success green background
      behavior: SnackBarBehavior.floating, // ✅ Optional: Floating effect
      duration: Duration(seconds: 2), // ✅ Controls visibility duration
    ),
  );
}
