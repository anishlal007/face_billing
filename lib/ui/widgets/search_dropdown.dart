import 'package:facebilling/core/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // for LogicalKeyboardKey

class SearchableDropdown<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T) itemLabel;
  final void Function(T)? onChanged;
  final String hintText;
  final Widget? addPage;
  final String addTooltip;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final TextEditingController? controller;
  final T? initialValue;

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
  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    if (widget.initialValue != null) {
      _selectedItem = widget.initialValue;
    }

    // ✅ Use a flag to prevent auto-opening when tapping
    bool _userTapped = false;

    // Detect manual tap
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final gestureBinding = GestureBinding.instance;
      gestureBinding.pointerRouter.addGlobalRoute((PointerEvent event) {
        if (event is PointerDownEvent) {
          _userTapped = true;
        }
      });
    });

    // Auto-open only when focus comes from keyboard navigation
    widget.focusNode?.addListener(() {
      if (widget.focusNode!.hasFocus && !_isOpen && !_userTapped) {
        _openDropdown();
      }
      _userTapped = false; // reset after any focus event
    });

    // Refresh UI when focus changes (border/highlight)
    _effectiveFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(() {});
    _searchController.dispose();
    super.dispose();
  }

  void _openDropdown() {
    if (_isOpen) return;
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isOpen = true);

    Future.delayed(const Duration(milliseconds: 100), () {
      _effectiveFocusNode.requestFocus();
    });
  }

  void _closeDropdown() {
    if (!_isOpen) return;
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

  @override
  void didUpdateWidget(covariant SearchableDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Rebuild when the initialValue changes from parent widget
    if (widget.initialValue != oldWidget.initialValue) {
      setState(() {
        _selectedItem = widget.initialValue;
      });
    }

    // Rebuild when items list changes (like when loading new data)
    if (widget.items.length != oldWidget.items.length) {
      setState(() {
        _filteredItems = widget.items;
      });
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    int highlightedIndex = 0; // 🔹 Track current highlighted item

    return OverlayEntry(
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setOverlayState) => Stack(
            children: [
              // 🔹 Tap outside to close
              Positioned.fill(
                child: GestureDetector(
                  onTap: _closeDropdown,
                  behavior: HitTestBehavior.translucent,
                ),
              ),

              // 🔹 Dropdown box
              Positioned(
                width: size.width,
                child: CompositedTransformFollower(
                  link: _layerLink,
                  showWhenUnlinked: false,
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(4),
                    child: RawKeyboardListener(
                      focusNode: _effectiveFocusNode,
                      onKey: (event) {
                        if (event is RawKeyDownEvent) {
                          if (event.logicalKey ==
                              LogicalKeyboardKey.arrowDown) {
                            if (highlightedIndex < _filteredItems.length - 1) {
                              setOverlayState(() => highlightedIndex++);
                            }
                          } else if (event.logicalKey ==
                              LogicalKeyboardKey.arrowUp) {
                            if (highlightedIndex > 0) {
                              setOverlayState(() => highlightedIndex--);
                            }
                          } else if (event.logicalKey ==
                              LogicalKeyboardKey.enter) {
                            if (_filteredItems.isNotEmpty) {
                              final selected = _filteredItems[highlightedIndex];
                              setState(() => _selectedItem = selected);
                              widget.onChanged?.call(selected);
                            }
                            _closeDropdown();
                            widget.onEditingComplete?.call();
                          } else if (event.logicalKey ==
                              LogicalKeyboardKey.escape) {
                            _closeDropdown();
                          }
                        }
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // 🔹 Search bar
                          TextField(
                            controller: _searchController,
                            style: const TextStyle(
                                fontSize: 12.0, height: 1.0, color: black),
                            decoration: const InputDecoration(
                              hintText: "Search...",
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 8),
                              border: OutlineInputBorder(
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
                                highlightedIndex = 0;
                              });
                              setOverlayState(() {});
                            },
                          ),

                          // 🔹 Item list
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 200),
                            child: _filteredItems.isEmpty
                                ? const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text("No items found",
                                            style: TextStyle(fontSize: 12))),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: _filteredItems.length,
                                    itemBuilder: (context, index) {
                                      final e = _filteredItems[index];
                                      final isHighlighted =
                                          index == highlightedIndex;

                                      return Container(
                                        color: isHighlighted
                                            ? const Color(0xFFE0E0E0)
                                            : const Color.fromARGB(17, 0, 0, 0),
                                        child: ListTile(
                                          dense: true,
                                          visualDensity: VisualDensity.compact,
                                          title: Text(
                                            widget.itemLabel(e),
                                            style:
                                                const TextStyle(fontSize: 12.0),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              _selectedItem = e;
                                            });
                                            widget.onChanged?.call(e);
                                            _closeDropdown();
                                            widget.onEditingComplete?.call();
                                          },
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.hintText.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Text(
              widget.hintText,
              style: const TextStyle(fontSize: 12, color: black),
            ),
          ),
        SizedBox(
          height: 30,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 🔹 Focus + Dropdown display
              Expanded(
                child: Focus(
                  focusNode: _effectiveFocusNode,
                  onKeyEvent: (node, event) {
                    // 🔹 When pressing Enter while dropdown is closed, go to next field
                    if (event is KeyDownEvent &&
                        (event.logicalKey == LogicalKeyboardKey.enter ||
                            event.logicalKey ==
                                LogicalKeyboardKey.numpadEnter)) {
                      if (_isOpen) {
                        // If dropdown is open → close it and keep focus here
                        _closeDropdown();
                      } else {
                        // If dropdown is closed → trigger next field
                        widget.onEditingComplete?.call();
                      }
                      return KeyEventResult.handled;
                    }

                    // 🔹 Optional: open dropdown when user presses ArrowDown
                    if (event is KeyDownEvent &&
                        event.logicalKey == LogicalKeyboardKey.arrowDown &&
                        !_isOpen) {
                      _openDropdown();
                      return KeyEventResult.handled;
                    }

                    return KeyEventResult.ignored;
                  },
                  child: CompositedTransformTarget(
                    link: _layerLink,
                    child: GestureDetector(
                      onTap: _isOpen ? _closeDropdown : _openDropdown,
                      child: InputDecorator(
                        decoration: InputDecoration(
                          hintText: widget.hintText,
                          hintStyle:
                              const TextStyle(fontSize: 12, color: black),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(76, 0, 0, 0), width: 1.2),
                          ),
                          suffixIcon:
                              const Icon(Icons.arrow_drop_down, size: 18),
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
              ),

              // 🔹 Add (+) button
              if (widget.addPage != null)
                IconButton(
                  tooltip: widget.addTooltip,
                  icon: const Icon(Icons.add_circle,
                      color: Color(0xFF0B2046), size: 20),
                  onPressed: _openAddPopup,
                )
              else
                const SizedBox(width: 35),
            ],
          ),
        ),
      ],
    );
  }
}
