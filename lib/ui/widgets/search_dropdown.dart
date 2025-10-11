import 'package:facebilling/core/colors.dart';
import 'package:flutter/material.dart';
class SearchableDropdown<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T) itemLabel;
  final void Function(T)? onChanged;
  final String hintText;
  final Widget? addPage;
  final String addTooltip;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final TextEditingController? controller; // ✅ new
  final T? initialValue; // ✅ new

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
    this.controller,
    this.initialValue,
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
     if (widget.initialValue != null) {
      _selectedItem = widget.initialValue;
    }
  }

  void _openDropdown() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isOpen = true);

    Future.delayed(const Duration(milliseconds: 100), () {
      _effectiveFocusNode.requestFocus();
    });
  }
 @override
  void didUpdateWidget(covariant SearchableDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      setState(() {
        _selectedItem = widget.initialValue;
      });
    }
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
    builder: (context) => Stack(
      children: [
        // 🔹 Transparent layer to detect outside taps
        Positioned.fill(
          child: GestureDetector(
            onTap: _closeDropdown, // close when tapped outside
            behavior: HitTestBehavior.translucent,
            child: Container(
             // color: Colors.transparent,
            ),
          ),
        ),

        // 🔹 The dropdown overlay
        Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 🔹 Search field
                  TextField(
                    controller: _searchController,
                    focusNode: _effectiveFocusNode,
                    style: const TextStyle(fontSize: 12.0, height: 1.0, color: black),
                    decoration: InputDecoration(
                      hintText: "Search...",
                      isDense: true,
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: black),
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

                  // 🔹 List of items
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 200),
                    child: _filteredItems.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("No items found"),
                            ),
                          )
                        : ListView(
                            shrinkWrap: true,
                            children: _filteredItems.map((e) {
                              return ListTile(
                                dense: true,
                                visualDensity: VisualDensity.compact,
                                title: Text(
                                  widget.itemLabel(e),
                                  style: const TextStyle(fontSize: 12),
                                ),
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
      ],
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.hintText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Text(
              widget.hintText!,
              style: const TextStyle(
                fontSize: 12,
                color: black,
              ),
            ),
          ),
        SizedBox(
          height: 30, // ✅ same as CustomTextField
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: CompositedTransformTarget(
                  link: _layerLink,
                  child: GestureDetector(
                    onTap: _isOpen ? _closeDropdown : _openDropdown,
                    child: InputDecorator(
                      decoration: InputDecoration(
                        hintText: widget.hintText,
                        hintStyle: const TextStyle(fontSize: 12, color: black),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide:
                              const BorderSide(color: Color.fromARGB(76, 0, 0, 0), width: 1.2),
                        ),
                        suffixIcon: const Icon(Icons.arrow_drop_down, size: 18),
                      ),
                      child: Text(
                        _selectedItem != null
                            ? widget.itemLabel(_selectedItem!)
                            : widget.hintText,
                        style: const TextStyle(fontSize: 12, color: black),
                      ),
                    ),
                  ),
                ),
              ),
        
              // 🔹 Add (+) button
              if (widget.addPage != null)
                IconButton(
                  icon: const Icon(Icons.add_circle, color: Color(0xFF0B2046), size: 20),
                  tooltip: widget.addTooltip,
                  onPressed: _openAddPopup,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
