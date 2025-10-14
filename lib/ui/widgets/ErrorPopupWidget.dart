import 'package:flutter/material.dart';

class ErrorPopupWidget extends StatelessWidget {
  final String title;
  final String message;
  final String image;

  const ErrorPopupWidget({
    super.key,
    required this.title,
    required this.message,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(image, width: 120, height: 120),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("OK"),
        ),
      ],
    );
  }
}
