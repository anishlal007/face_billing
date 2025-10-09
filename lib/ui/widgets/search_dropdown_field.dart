import 'package:flutter/material.dart';

typedef FetchCallback<T extends Object> = Future<List<T>> Function(String query);
typedef DisplayString<T extends Object> = String Function(T option);
typedef OnSelected<T extends Object> = void Function(T selected);
typedef OnSubmitted<T extends Object> = void Function(String value);

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
  late final VoidCallback _listener;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _listener = () => _fetchSuggestions(_controller.text);
    _controller.addListener(_listener);
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  Future<void> _fetchSuggestions(String query) async {
    if (query.isEmpty) {
      if (mounted) setState(() => _options = []);
      return;
    }

    setState(() => _loading = true);

    try {
      final results = await widget.fetchItems(query);
      if (mounted) setState(() => _options = results);
    } catch (e) {
      if (mounted) setState(() => _options = []);
      print("Error fetching suggestions: $e");
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 36,
            child: TextField(
              controller: _controller,
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
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              ),
              onChanged: (value) => _fetchSuggestions(value),
              onSubmitted: widget.onSubmitted,
            ),
          ),
          // Dropdown overlay
          if (_options.isNotEmpty)
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: const Offset(0, 36), // height of the TextField
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
                        title: Text(widget.displayString(option),
                            style: const TextStyle(fontSize: 13)),
                        onTap: () {
                          _controller.text = widget.displayString(option);
                          widget.onSelected(option);
                          setState(() => _options = []);
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}