import 'package:flutter/material.dart';

// Type definitions for flexibility
typedef FetchCallback<T extends Object> = Future<List<T>> Function(
    String query);
typedef DisplayString<T extends Object> = String Function(T option);
typedef OnSelected<T extends Object> = void Function(T selected);

// ✅ New typedef
typedef OnSubmitted<T extends Object> = void Function(String value);

class SearchDropdownField<T extends Object> extends StatefulWidget {
  final FetchCallback<T> fetchItems; // API fetcher
  final DisplayString<T> displayString; // show item text
  final OnSelected<T> onSelected; // return selected item
  final OnSubmitted<T>? onSubmitted; // ✅ new callback
  final String hintText;
  final IconData prefixIcon;

  const SearchDropdownField({
    super.key,
    required this.fetchItems,
    required this.displayString,
    required this.onSelected,
    this.onSubmitted, // ✅
    this.hintText = "Search",
    this.prefixIcon = Icons.search,
  });

  @override
  State<SearchDropdownField<T>> createState() => _SearchDropdownFieldState<T>();
}

class _SearchDropdownFieldState<T extends Object>
    extends State<SearchDropdownField<T>> {
  List<T> _options = [];
  bool _loading = false;

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
    return RawAutocomplete<T>(
      optionsBuilder: (TextEditingValue textEditingValue) async {
        await _fetchSuggestions(textEditingValue.text);
        return _options;
      },
      displayStringForOption: widget.displayString,
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          onSubmitted: (value) {
            // ✅ trigger parent callback
            if (widget.onSubmitted != null) {
              widget.onSubmitted!(value);
            }
            // Also call RawAutocomplete's onFieldSubmitted
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
      optionsViewBuilder: (context, onSelected, Iterable<T> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: options.length,
              itemBuilder: (context, index) {
                final option = options.elementAt(index);
                return ListTile(
                  leading: const Icon(Icons.search),
                  title: Text(widget.displayString(option)),
                  onTap: () => onSelected(option),
                );
              },
            ),
          ),
        );
      },
      onSelected: widget.onSelected,
    );
  }
}