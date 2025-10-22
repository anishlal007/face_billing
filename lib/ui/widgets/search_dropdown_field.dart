import 'package:flutter/material.dart';

typedef FetchCallback<T> = Future<List<T>> Function(String query);
typedef DisplayString<T> = String Function(T option);
typedef OnSelected<T> = void Function(T selected);
typedef OnSubmitted<T> = void Function(String value);

class SearchDropdownField<T> extends StatefulWidget {
  final FetchCallback<T> fetchItems;
  final DisplayString<T> displayString;
  final OnSelected<T> onSelected;
  final OnSubmitted<T>? onSubmitted;
  final String hintText;
  final FocusNode? focusNode;
  final IconData prefixIcon;
  final TextEditingController? controller;

  const SearchDropdownField({
    Key? key,
    required this.fetchItems,
    required this.displayString,
    required this.onSelected,
    this.focusNode,
    this.onSubmitted,
    this.hintText = "Search",
    this.prefixIcon = Icons.search,
    this.controller,
  }) : super(key: key);

  @override
  _SearchDropdownFieldState<T> createState() => _SearchDropdownFieldState<T>();
}

class _SearchDropdownFieldState<T> extends State<SearchDropdownField<T>> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  //  FocusNode get _effectiveFocusNode => widget.focusNode ?? _internalFocusNode;
  List<T> _options = [];
  bool _loading = false;

  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) _removeDropdown();
    });
  }

  @override
  void dispose() {
    _removeDropdown();
    if (widget.controller == null) _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _fetchSuggestions(String query) async {
    if (query.isEmpty) {
      _removeDropdown();
      return;
    }

    setState(() => _loading = true);
    try {
      final results = await widget.fetchItems(query);
      if (mounted) {
        _options = results;
        if (_options.isNotEmpty && _focusNode.hasFocus) {
          _showDropdown();
        } else {
          _removeDropdown();
        }
      }
    } catch (e) {
      debugPrint("Error fetching suggestions: $e");
      _options = [];
      _removeDropdown();
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _showDropdown() {
    _removeDropdown();

    final overlay = Overlay.of(context);
    if (overlay == null) return;

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 4),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(4),
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
                      style: const TextStyle(fontSize: 14),
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

    overlay.insert(_overlayEntry!);
  }

  void _removeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.hintText,
              style: const TextStyle(fontSize: 12, color: Colors.black)),
          const SizedBox(height: 4),
          TextField(
            textCapitalization: TextCapitalization.characters,
            controller: _controller,
            focusNode: _focusNode,
            style: const TextStyle(fontSize: 14),
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
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            ),
            onChanged: (value) => _fetchSuggestions(value),
            onSubmitted: (value) {
              if (widget.onSubmitted != null && value.trim().isNotEmpty) {
                widget.onSubmitted!(value.trim());
              }
              _removeDropdown();
            },
          ),
        ],
      ),
    );
  }
}
