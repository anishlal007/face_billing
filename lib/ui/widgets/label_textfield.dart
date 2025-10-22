import 'package:flutter/material.dart';

import '../../core/colors.dart';

class LabeledTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode; // 👈 next field to focus
  final bool readOnly;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final double labelWidth;
  final double fieldWidth;
  final double spacing;
  final double? calculateValue;
  final bool isTextField;

  const LabeledTextField({
    super.key,
    required this.label,
    this.controller,
    this.focusNode,
    this.nextFocusNode,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.labelWidth = 100,
    this.fieldWidth = 150,
    this.spacing = 4,
    this.isTextField = false,
    this.calculateValue,
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
              style: const TextStyle(fontSize: 12.0, height: 1.0, color: black),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 40,
            width: fieldWidth,
            child: isTextField == false
                ? Center(
                    child: Container(
                      width: fieldWidth,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: const Color.fromARGB(158, 142, 143, 145)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "${calculateValue?.toStringAsFixed(3)} ₹",
                          style: const TextStyle(
                              fontSize: 15.0,
                              height: 1.0,
                              color: Color.fromARGB(159, 0, 0, 0)),
                        ),
                      ),
                    ),
                  )
                : TextField(
                    style: const TextStyle(
                        fontSize: 12.0, height: 2.0, color: black),
                    controller: controller,
                    focusNode: focusNode,
                    // readOnly: readOnly,
                    keyboardType: keyboardType,
                    textInputAction: nextFocusNode != null
                        ? TextInputAction.next
                        : TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: "0.00",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 12.0),
                    ),
                    onChanged: onChanged,
                    // enabled: false,
                    onSubmitted: (_) {
                      if (nextFocusNode != null) {
                        FocusScope.of(context).requestFocus(nextFocusNode);
                      } else {
                        FocusScope.of(context)
                            .unfocus(); // close keyboard if last
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
