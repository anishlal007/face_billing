import 'package:facebilling/core/colors.dart';
import 'package:flutter/material.dart';

class ListCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String initials;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final bool isviewcircleavathar;

  const ListCardWidget({
    super.key,
    required this.title,
    required this.isviewcircleavathar,
    required this.subtitle,
    required this.initials,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: white, // ✅ Set background color here
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            // Left avatar
            isviewcircleavathar
                ? CircleAvatar(
                    radius: 22,
                    backgroundColor: primary,
                    child: Text(
                      initials,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: white,
                      ),
                    ),
                  )
                : const SizedBox(),
            const SizedBox(width: 12),

            // Title + Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: black,
                    ),
                  ),
                ],
              ),
            ),

            // Action Buttons
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: primary),
                  tooltip: "Edit",
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: red),
                  tooltip: "Delete",
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
