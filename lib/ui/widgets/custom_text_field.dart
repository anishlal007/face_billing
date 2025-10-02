import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String? title;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final VoidCallback? onEditingComplete;
  final bool isPassword;
  final bool isNumeric;
  final bool isValidate;
  final String? Function(String?)? validator;
  final bool isEdit;
  final bool autoFocus;

  const CustomTextField({
    super.key,
    required this.controller,
    this.title,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.textInputAction = TextInputAction.next,
    this.onEditingComplete,
    this.isPassword = false,
    this.isNumeric = false,
    this.isValidate = false,
    this.validator,
    this.isEdit = false,
    this.autoFocus = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  String? _errorText;

  void _validate(String value) {
    if (widget.isValidate && widget.validator != null) {
      setState(() {
        _errorText = widget.validator!(value);
      });
    } else {
      setState(() {
        _errorText = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border:
            Border.all(color: const Color.fromARGB(76, 0, 0, 0), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // if (widget.title != null)
          //   Padding(
          //     padding: const EdgeInsets.only(bottom: 6),
          //     child: Text(
          //       widget.title!,
          //       style: const TextStyle(
          //         fontSize: 14,
          //         fontWeight: FontWeight.w500,
          //         color: Colors.black87,
          //       ),
          //     ),
          //   ),
          TextField(
            style: TextStyle(fontSize: 12.0, height: 1.0, color: Colors.black),
            controller: widget.controller,
            focusNode: widget.focusNode,
            textInputAction: widget.textInputAction,
            onEditingComplete: widget.onEditingComplete,
            obscureText: widget.isPassword ? _obscureText : false,
            keyboardType:
                widget.isNumeric ? TextInputType.number : TextInputType.text,
            enabled: !widget.isEdit,
            onChanged: widget.isEdit ? null : _validate,
            autofocus: widget.autoFocus,

            // ✅ Only allow numbers if isNumeric = true
            inputFormatters: widget.isNumeric
                ? [FilteringTextInputFormatter.digitsOnly]
                : [],

            decoration: InputDecoration(
              // labelText: widget.title,
              hintText: widget.hintText,
              // prefixIcon:
              //     widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(_obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: widget.isEdit
                          ? null
                          : () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                    )
                  : (widget.suffixIcon != null
                      ? Icon(widget.suffixIcon)
                      : null),
              errorText: _errorText,
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(8),
              // ),
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
