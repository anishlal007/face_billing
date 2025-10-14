import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart'; 

typedef FetchCallback<T extends Object> = Future<List<T>> Function(String query);
typedef DisplayString<T extends Object> = String Function(T option);
typedef OnSelected<T extends Object> = void Function(T selected);
typedef OnSubmitted<T extends Object> = void Function(String value);

/// Keeps track of the currently open dropdown globally
final ValueNotifier<OverlayEntry?> _activeDropdownNotifier = ValueNotifier(null);

class SearchDropdownField<T extends Object> extends StatefulWidget {
  final FetchCallback<T> fetchItems;
  final DisplayString<T> displayString;
  final OnSelected<T> onSelected;
  final OnSubmitted<T>? onSubmitted;
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController? controller;

  const SearchDropdownField({
    super.key,
    required this.fetchItems,
    required this.displayString,
    required this.onSelected,
    this.onSubmitted,
    this.hintText = "Search",
    this.prefixIcon = Icons.search,
    this.controller,
  });

  @override
  State<SearchDropdownField<T>> createState() => _SearchDropdownFieldState<T>();
}

class _SearchDropdownFieldState<T extends Object> extends State<SearchDropdownField<T>> {
  List<T> _options = [];
  bool _loading = false;
  late TextEditingController _controller;
  final LayerLink _layerLink = LayerLink();
  late FocusNode _focusNode;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        // _attachGlobalListener();
      } else {
        _removeDropdown();
      }
    });
  }

  @override
  void dispose() {
    _removeDropdown();
    if (widget.controller == null) _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  /// Fetch results dynamically
  Future<void> _fetchSuggestions(String query) async {
    if (query.isEmpty) {
      _removeDropdown();
      return;
    }

    setState(() => _loading = true);
    try {
      final results = await widget.fetchItems(query);
      if (mounted) {
        setState(() => _options = results);
        if (results.isNotEmpty) {
          _showDropdown();
        } else {
          _removeDropdown();
        }
      }
    } catch (e) {
      if (mounted) setState(() => _options = []);
      debugPrint("Error fetching suggestions: $e");
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  /// Show dropdown in overlay
  void _showDropdown() {
    _removeDropdown(); // remove old one if open

    final overlay = Overlay.of(context);
    if (overlay == null) return;

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width * 0.3, // optional width control
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 36),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _options.length,
                itemBuilder: (context, index) {
                  final option = _options[index];
                  return ListTile(
                    dense: true,
                    title: Text(
                      widget.displayString(option),
                      style: const TextStyle(fontSize: 13),
                    ),
                    onTap: () {
                      _controller.text = widget.displayString(option);
                      widget.onSelected(option);
                      _removeDropdown();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    _activeDropdownNotifier.value?.remove(); // close any other dropdown
    _activeDropdownNotifier.value = overlayEntry;
    overlay.insert(overlayEntry);
    _overlayEntry = overlayEntry;
  }

  void _removeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _options.clear();
  }

  /// Detect outside click to close dropdown
  void _attachGlobalListener() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      GestureBinding.instance.pointerRouter.addGlobalRoute(_handlePointerEvent);
    });
  }

  void _handlePointerEvent(PointerEvent event) {
    if (event is PointerDownEvent && !_focusNode.hasFocus) {
      _removeDropdown();
      GestureBinding.instance.pointerRouter.removeGlobalRoute(_handlePointerEvent);
    }
  }

  @override
Widget build(BuildContext context) {
  return CompositedTransformTarget(
    link: _layerLink,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Text(widget.hintText,
              style: const TextStyle(fontSize: 12, color: Colors.black)),
        ),
        SizedBox(
          height: 30,
          child: Focus(
            onFocusChange: (hasFocus) {
              if (!hasFocus) {
                // When user clicks outside → call onSubmitted if not selected from dropdown
                if (widget.onSubmitted != null &&
                    _controller.text.trim().isNotEmpty) {
                  widget.onSubmitted!.call(_controller.text.trim());
                }
                _removeDropdown();
              }
            },
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              style: const TextStyle(fontSize: 12, height: 1.0, color: Colors.black),
              decoration: InputDecoration(
                hintText: widget.hintText,
                prefixIcon: Icon(widget.prefixIcon, size: 18),
                suffixIcon: _loading
                    ? const Padding(
                        padding: EdgeInsets.all(10),
                        child: SizedBox(
                          width: 12,
                          height: 12,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : null,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              ),
              onChanged: (value) => _fetchSuggestions(value),
              onSubmitted: (value) {
                // 🔹 Trigger your custom callback first
                if (widget.onSubmitted != null && value.trim().isNotEmpty) {
                  widget.onSubmitted!(value.trim());
                }
                _removeDropdown();
              },
            ),
          ),
        ),
      ],
    ),
  );
}

}
