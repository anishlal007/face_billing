import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final ValueChanged<String>? onChanged; // ✅ new callback
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
    this.onChanged, // ✅ added
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Text(
                widget.title!,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black87,
                ),
              ),
            ),
          SizedBox(
            height: 30,
            child: TextField(
              style:
                  const TextStyle(fontSize: 12.0, height: 1.0, color: Colors.black),
              controller: widget.controller,
              focusNode: widget.focusNode,
              textInputAction: widget.textInputAction,
              onEditingComplete: widget.onEditingComplete,
              obscureText: widget.isPassword ? _obscureText : false,
              keyboardType:
                  widget.isNumeric ? TextInputType.number : TextInputType.text,
              enabled: !widget.isEdit,
              autofocus: widget.autoFocus,

              // ✅ Combined onChanged functionality
              onChanged: (value) {
                if (widget.isValidate) _validate(value);
                if (widget.onChanged != null) widget.onChanged!(value);
              },

              // ✅ Allow only numbers if numeric
              inputFormatters: widget.isNumeric
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : [],

              decoration: InputDecoration(
                hintText: widget.hintText,
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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
