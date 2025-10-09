import 'package:facebilling/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


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
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final Widget? addPage;
  final String addTooltip;
  final TextEditingController? controller;

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
    this.focusNode,
    this.onEditingComplete,
    this.addPage,
    this.addTooltip = "Add new",
    this.controller,
  });

  @override
  State<CustomDropdownField<T>> createState() => _CustomDropdownFieldState<T>();
}

class _CustomDropdownFieldState<T> extends State<CustomDropdownField<T>> {
  T? _selectedValue;
  final TextEditingController _searchController = TextEditingController();
  List<DropdownMenuItem<T>> _filteredItems = [];

   @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
    _filteredItems = widget.items;

    // ✅ Sync dropdown -> controller (initially)
    if (widget.controller != null && _selectedValue != null) {
      widget.controller!.text = _selectedValue.toString();
    }

    // ✅ Listen to controller changes (controller -> dropdown)
    widget.controller?.addListener(_syncFromController);
  }

  void _syncFromController() {
    final text = widget.controller?.text;
    if (text == null || text.isEmpty) return;

    // Try matching with one of the dropdown item values
    for (var item in widget.items) {
      if (item.value.toString() == text) {
        setState(() {
          _selectedValue = item.value;
        });
        return;
      }
    }
  }

  /// ✅ Automatically update when parent changes initialValue or items
  @override
  void didUpdateWidget(covariant CustomDropdownField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialValue != oldWidget.initialValue) {
      setState(() {
        _selectedValue = widget.initialValue;
      });
      if (widget.controller != null && _selectedValue != null) {
        widget.controller!.text = _selectedValue.toString();
      }
    }

    if (widget.items != oldWidget.items) {
      setState(() => _filteredItems = widget.items);
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_syncFromController);
    super.dispose();
  }

  /// Optional public helper (only if you want to trigger manually)
  void updateValue(T value) {
    setState(() {
      _selectedValue = value;
      widget.onChanged?.call(value);
    });
  }

  void _filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = widget.items;
      } else {
        _filteredItems = widget.items.where((item) {
          final text = (item.child as Text).data?.toLowerCase() ?? '';
          return text.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  void _openPopup() {
    if (widget.addPage != null) {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
            child: widget.addPage!,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Text(
              widget.title!,
              style: const TextStyle(
                fontSize: 12,
                color: black,
              ),
            ),
          ),
        SizedBox(
          height: 30,
          child: Row(
            children: [
              // 🔹 Dropdown Field with same style as TextField
              Expanded(
                child: DropdownButtonFormField<T>(
                  value: _selectedValue,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down, size: 20),
                  decoration: InputDecoration(
                    prefixIcon: widget.prefixIcon != null
                        ? Icon(widget.prefixIcon, size: 16)
                        : null,
                    hintText: widget.hintText ?? "Select",
                    hintStyle: const TextStyle(fontSize: 12.0, color: black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12.0),
                  ),
                  style: const TextStyle(
                    fontSize: 12.0,
                    height: 1.0,
                    color: black,
                  ),
                  items: _filteredItems,
                  validator:
                      widget.isValidate ? widget.validator : (_) => null,
                  onChanged: widget.isEdit
                      ? null
                      : (value) {
        setState(() => _selectedValue = value);

        // ✅ Sync dropdown -> controller
        if (widget.controller != null && value != null) {
          widget.controller!.text = value.toString();
        }

        widget.onChanged?.call(value);
        widget.onEditingComplete?.call();
      },
                ),
              ),

              // 🔹 Add button (optional)
              if (widget.addPage != null)
                IconButton(
                  tooltip: widget.addTooltip,
                  icon: const Icon(
                    Icons.add_circle,
                    color: Color(0xFF0B2046),
                    size: 20,
                  ),
                  onPressed: _openPopup,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
