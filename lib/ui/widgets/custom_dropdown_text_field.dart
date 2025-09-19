import 'package:flutter/material.dart';

class CustomDropdownField extends StatefulWidget {
  final String? title;
  final String? hintText;
  final IconData? prefixIcon;
  final List<String> items;
  final String? initialValue;
  final ValueChanged<String?>? onChanged;
  final bool isValidate;
  final String? Function(String?)? validator;
  final bool isEdit;

  const CustomDropdownField({
    super.key,
    this.title,
    this.hintText,
    this.prefixIcon,
    required this.items,
    this.initialValue,
    this.onChanged,
    this.isValidate = false,
    this.validator,
    this.isEdit = false,
  });

  @override
  State<CustomDropdownField> createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  String? _selectedValue;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue; // default null → empty dropdown
  }

  void _validate(String? value) {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              widget.title!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        DropdownButtonFormField<String>(
          value: _selectedValue,
          hint: Text(widget.hintText ?? "Select"),
          icon: const Icon(Icons.arrow_drop_down),
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            errorText: _errorText,
          ),
          items: widget.items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          onChanged: widget.isEdit
              ? null
              : (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                  _validate(value);
                  if (widget.onChanged != null) {
                    widget.onChanged!(value);
                  }
                },
        ),
      ],
    );
  }
}