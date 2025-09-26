import 'package:facebilling/core/colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  // ✅ New: Add button + popup widget
  final Widget? addPage; // Pass "AddCountryScreen()", "AddStateScreen()" etc.
  final String addTooltip;

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
  });

  @override
  State<CustomDropdownField<T>> createState() => _CustomDropdownFieldState<T>();
}

class _CustomDropdownFieldState<T> extends State<CustomDropdownField<T>> {
  T? _selectedValue;
  final GlobalKey _dropdownKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  void _openDropdown() {
    GestureDetector? detector;
    void search(BuildContext? element) {
      element?.visitChildElements((child) {
        if (child.widget is GestureDetector) {
          detector = child.widget as GestureDetector;
        }
        search(child);
      });
    }

    search(_dropdownKey.currentContext);
    detector?.onTap?.call();
  }

  // ✅ Open popup dialog
  void _openPopup() {
    if (widget.addPage != null) {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
            child: widget.addPage!,
          ),
        ),
      ).then((value) {
        if (value == true) {
          // ✅ You can trigger a reload of dropdown items here if needed
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Added successfully")),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: widget.focusNode,
      onKeyEvent: (node, event) {
        if (event.logicalKey == LogicalKeyboardKey.enter &&
            event is KeyDownEvent) {
          _openDropdown();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                widget.title!,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<T>(
                  key: _dropdownKey,
                  value: _selectedValue,
                  hint: Text(widget.hintText ?? "Select"),
                  icon: const Icon(Icons.arrow_drop_down),
                  decoration: InputDecoration(
                    prefixIcon: widget.prefixIcon != null
                        ? Icon(widget.prefixIcon)
                        : null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  items: widget.items,
                  validator: widget.isValidate ? widget.validator : null,
                  onChanged: widget.isEdit
                      ? null
                      : (value) {
                          setState(() => _selectedValue = value);
                          widget.onChanged?.call(value);

                          if (widget.onEditingComplete != null) {
                            widget.onEditingComplete!();
                          }
                        },
                ),
              ),

              // ✅ Add button (if addPage is provided)
              if (widget.addPage != null) ...[
                // const SizedBox(width: 8),
                IconButton(
                  tooltip: widget.addTooltip,
                  icon: const Icon(
                    Icons.add_circle,
                    color: primary,
                    size: 30,
                  ),
                  onPressed: _openPopup,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
