import 'package:flutter/material.dart';

class LabeledTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;   // 👈 next field to focus
  final bool readOnly;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final double labelWidth;
  final double fieldWidth;
  final double spacing;

  const LabeledTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.labelWidth = 100,
    this.fieldWidth = 100,
    this.spacing = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: labelWidth,
            child: Text(
              label,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: fieldWidth,
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              readOnly: readOnly,
              keyboardType: keyboardType,
              textInputAction:
                  nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              onChanged: onChanged,
              onSubmitted: (_) {
                if (nextFocusNode != null) {
                  FocusScope.of(context).requestFocus(nextFocusNode);
                } else {
                  FocusScope.of(context).unfocus(); // close keyboard if last
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}