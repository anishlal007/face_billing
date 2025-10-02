import 'package:flutter/material.dart';

// Type definitions for flexibility
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

class _SearchDropdownFieldState<T extends Object>
    extends State<SearchDropdownField<T>> {
  List<T> _options = [];
  bool _loading = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(() {
      _fetchSuggestions(_controller.text);
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  Future<void> _fetchSuggestions(String query) async {
    if (query.isEmpty) {
      setState(() => _options = []);
      return;
    }
    setState(() => _loading = true);
    final results = await widget.fetchItems(query);
    setState(() {
      _options = results;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<T>(
      displayStringForOption: widget.displayString,
      optionsBuilder: (textEditingValue) {
        return _options; // synchronous
      },
      fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
        // Sync controller with our external one
        textEditingController.text = _controller.text;
        textEditingController.selection = _controller.selection;

        return TextField(
          controller: _controller,
          focusNode: focusNode,
          onSubmitted: (value) {
            widget.onSubmitted?.call(value);
            onFieldSubmitted();
          },
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: Icon(widget.prefixIcon),
            suffixIcon: _loading
                ? const Padding(
                    padding: EdgeInsets.all(12),
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: options.length,
              itemBuilder: (context, index) {
                final option = options.elementAt(index);
                return ListTile(
                  title: Text(widget.displayString(option)),
                  onTap: () {
                    _controller.text = widget.displayString(option);
                    onSelected(option);
                    widget.onSelected(option);
                  },
                );
              },
            ),
          ),
        );
      },
      onSelected: (value) {
        _controller.text = widget.displayString(value);
        widget.onSelected(value);
      },
    );
  }
}

