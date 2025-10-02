import 'package:facebilling/core/colors.dart';
import 'package:flutter/material.dart';

class SearchableDropdown<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T) itemLabel;
  final void Function(T)? onChanged;
  final String hintText;
  final Widget? addPage;
  final String addTooltip;
  final FocusNode? focusNode; // Add focus node
  final VoidCallback?
      onEditingComplete; // callback when user selects item or presses enter

  const SearchableDropdown({
    super.key,
    required this.items,
    required this.itemLabel,
    this.onChanged,
    this.hintText = "Select",
    this.addPage,
    this.addTooltip = "Add new",
    this.focusNode,
    this.onEditingComplete,
  });

  @override
  State<SearchableDropdown<T>> createState() => _SearchableDropdownState<T>();
}

class _SearchableDropdownState<T> extends State<SearchableDropdown<T>> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _internalFocusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  List<T> _filteredItems = [];
  bool _isOpen = false;

  T? _selectedItem;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? _internalFocusNode;

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
  }

  void _openDropdown() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isOpen = true);

    Future.delayed(const Duration(milliseconds: 100), () {
      _effectiveFocusNode.requestFocus();
    });
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isOpen = false;
      _searchController.clear();
      _filteredItems = widget.items;
    });

    _effectiveFocusNode.unfocus();
  }

  void _openAddPopup() {
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
        if (value is T) {
          setState(() {
            widget.items.add(value);
            _selectedItem = value;
          });
          widget.onChanged?.call(value);
          widget.onEditingComplete?.call();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Added successfully")),
          );
        }
      });
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 5),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _searchController,
                  focusNode: _effectiveFocusNode,
                  decoration: InputDecoration(
                    hintText: "Search...",
                    contentPadding: const EdgeInsets.all(8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _filteredItems = widget.items
                          .where((e) => widget
                              .itemLabel(e)
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    });
                    _overlayEntry!.markNeedsBuild();
                  },
                  onEditingComplete: () {
                    if (_filteredItems.isNotEmpty) {
                      _selectedItem = _filteredItems.first;
                      widget.onChanged?.call(_selectedItem!);
                    }
                    _closeDropdown();
                    widget.onEditingComplete?.call();
                  },
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: _filteredItems.isEmpty
                      ? const Center(
                          child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("No items found"),
                        ))
                      : ListView(
                          shrinkWrap: true,
                          children: _filteredItems.map((e) {
                            return ListTile(
                              title: Text(widget.itemLabel(e)),
                              onTap: () {
                                setState(() {
                                  _selectedItem = e;
                                  _filteredItems = widget.items;
                                });
                                widget.onChanged?.call(e);
                                _searchController.clear();
                                _closeDropdown();
                                widget.onEditingComplete?.call();
                              },
                            );
                          }).toList(),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border:
            Border.all(color: const Color.fromARGB(76, 0, 0, 0), width: 1.2),
      ),
      child: Row(
        children: [
          Expanded(
            child: CompositedTransformTarget(
              link: _layerLink,
              child: GestureDetector(
                onTap: _isOpen ? _closeDropdown : _openDropdown,
                child: InputDecorator(
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(12),
                    // ),
                    border: InputBorder.none,
                    // suffixIcon: const Icon(Icons.arrow_drop_down),
                  ),
                  child: Text(
                    _selectedItem != null
                        ? widget.itemLabel(_selectedItem!)
                        : widget.hintText,
                  ),
                ),
              ),
            ),
          ),
          if (widget.addPage != null) ...[
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.add_circle, color: primary, size: 30),
              tooltip: widget.addTooltip,
              onPressed: _openAddPopup,
            ),
          ],
        ],
      ),
    );
  }
}
