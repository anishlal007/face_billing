import 'package:facebilling/core/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TableTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final FocusNode? focusNode;
  final bool isEditable;
  final TextInputType inputType;
  final void Function(String)? onChanged;
  final TextAlign textAlign;
  final double? width;
  final bool showCurrency;
  final bool? persentage;


  const TableTextField({
    Key? key,
    required this.controller,
    this.hintText,
    this.focusNode,
    this.persentage  = false,
    this.isEditable = true,
    this.inputType = TextInputType.text,
    this.onChanged,
    this.textAlign = TextAlign.left,
    this.showCurrency = false,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextField(
        focusNode: focusNode,
        style: blueTextStyle,
        controller: controller,
        enabled: isEditable,
        keyboardType: inputType,
        inputFormatters: inputType == TextInputType.number
            ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))]
            : null,
        textAlign: textAlign,
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.grey),
          hintText: hintText ?? '',
          border: InputBorder.none, // no border
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          suffix: persentage == true ? const Text('% ') : showCurrency ? const Text('₹ ') : null,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
