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

  // Add button + popup widget
  final Widget? addPage;
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
  final TextEditingController _searchController = TextEditingController();
  List<DropdownMenuItem<T>> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
    _filteredItems = widget.items;
  }

  void _filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = widget.items;
      } else {
        _filteredItems = widget.items.where((item) {
          final text = (item.child as Text).data?.toLowerCase() ?? '';
          return text.contains(query.toLowerCase()); // 🔹 FIXED
        }).toList();
      }

      print("Typed: $query");
      print("Filtered items:");
      for (var item in _filteredItems) {
        final text = (item.child as Text).data ?? '';
        print(text);
      }
    });
  }

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
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border:
              Border.all(color: const Color.fromARGB(76, 0, 0, 0), width: 1.2),
        ),
        child: Row(
          children: [
            Expanded(
                child: DropdownButtonFormField<T>(
              style: TextStyle(fontSize: 12.0, height: 1.0, color: black),
              key: _dropdownKey,
              value: _selectedValue,
              hint: Text(widget.hintText ?? "Select"),
              icon: const Icon(Icons.arrow_drop_down),
              decoration: InputDecoration(
                // labelText: widget.title,
                prefixIcon:
                    widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(8),
                // ),
                border: InputBorder.none,
              ),
              items: [
                DropdownMenuItem<T>(
                  enabled: false,
                  child: StatefulBuilder(
                    builder: (context, setInnerState) {
                      return SizedBox(
                        width: 200,
                        child: TextField(
                          style: const TextStyle(
                              fontSize: 12.0, height: 1.0, color: black),
                          controller: _searchController,
                          decoration: const InputDecoration(
                            hintText: "Search",
                            isDense: true,
                            // contentPadding: EdgeInsets.symmetric(
                            //     horizontal: 8, vertical: 8),
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            _filterItems(value);
                            setInnerState(
                                () {}); // 🔹 force refresh of dropdown
                          },
                        ),
                      );
                    },
                  ),
                ),
                ..._filteredItems,
              ],
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
            )),
            if (widget.addPage != null) ...[
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
      ),
    );
  }
}
