import 'package:flutter/material.dart';

class CustomDropdownField<T> extends StatefulWidget {
  final String? title;
  final String? hintText;
  final IconData? prefixIcon;
  final List<DropdownMenuItem<T>> items;
  final T? initialValue;
  final ValueChanged<T?>? onChanged;
  final bool isValidate;
  final String? Function(T?)? validator;
  final bool isEdit;
  final TextEditingController? controller; // optional controller

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
    this.controller,
  });

  @override
  State<CustomDropdownField<T>> createState() => _CustomDropdownFieldState<T>();
}

class _CustomDropdownFieldState<T> extends State<CustomDropdownField<T>> {
  T? _selectedValue;
  String? _errorText;

  @override
  void initState() {
    super.initState();

    // If controller is provided, try to parse its value to T
    if (widget.controller != null && widget.controller!.text.isNotEmpty) {
      final textValue = widget.controller!.text;
      if (T == int) {
        _selectedValue = int.tryParse(textValue) as T?;
      } else if (T == double) {
        _selectedValue = double.tryParse(textValue) as T?;
      } else {
        _selectedValue = textValue as T?;
      }
    } else {
      _selectedValue = widget.initialValue;
    }
  }

  void _onValueChanged(T? value) {
    setState(() => _selectedValue = value);

    if (widget.controller != null) {
      widget.controller!.text = value.toString();
    }

    if (widget.onChanged != null) widget.onChanged!(value);
  }

  void _validate(T? value) {
    if (widget.isValidate && widget.validator != null) {
      setState(() {
        _errorText = widget.validator!(value);
      });
    } else {
      setState(() => _errorText = null);
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
            child: Text(widget.title!,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          ),
        DropdownButtonFormField<T>(
          value: _selectedValue,
          hint: Text(widget.hintText ?? "Select"),
          icon: const Icon(Icons.arrow_drop_down),
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            errorText: _errorText,
          ),
          items: widget.items,
          onChanged: widget.isEdit ? null : (value) {
            _onValueChanged(value);
            _validate(value);
          },
        ),
      ],
    );
  }
}