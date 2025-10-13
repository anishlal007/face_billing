import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  final String message;
  final String? imagePath; // optional local asset image path
  final double imageSize;

  const EmptyStateWidget({
    super.key,
    required this.message,
    this.imagePath,
    this.imageSize = 150,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Opacity(
        opacity: 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imagePath != null)
              Image.asset(
                imagePath!,
                height: imageSize,
                fit: BoxFit.contain,
              )
            else
              const Icon(Icons.inbox, size: 100, color: Colors.grey),
            const SizedBox(height: 20),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
