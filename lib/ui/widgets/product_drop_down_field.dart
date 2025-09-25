import 'package:flutter/material.dart';

// Type definitions
typedef FetchCallback<T extends Object> = Future<List<T>> Function(String query);
typedef DisplayString<T extends Object> = String Function(T option);
typedef OnSelected<T extends Object> = void Function(T selected);
typedef RowBuilder<T extends Object> = List<DataCell> Function(T option);

class ProductSearchDropdownField<T extends Object> extends StatefulWidget {
  final FetchCallback<T> fetchItems; // API fetcher
  final DisplayString<T> displayString; // show item text (fallback)
  final OnSelected<T> onSelected; // return selected item
  final RowBuilder<T>? rowBuilder; // custom row builder for DataTable
  final List<String>? columnHeaders; // DataTable headers
  final String hintText;
  final IconData prefixIcon;

  const ProductSearchDropdownField({
    super.key,
    required this.fetchItems,
    required this.displayString,
    required this.onSelected,
    this.rowBuilder,
    this.columnHeaders,
    this.hintText = "Search",
    this.prefixIcon = Icons.search,
  });

  @override
  State<ProductSearchDropdownField<T>> createState() =>
      _ProductSearchDropdownFieldState<T>();
}

class _ProductSearchDropdownFieldState<T extends Object>
    extends State<ProductSearchDropdownField<T>> {
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
        // ✅ Show DataTable if rowBuilder + columnHeaders provided
        if (widget.rowBuilder != null && widget.columnHeaders != null) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width:MediaQuery.of(context).size.width ,
                height: MediaQuery.of(context).size.height * 0.5,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(Colors.blue[50]),
                    columns: widget.columnHeaders!
                        .map((h) => DataColumn(label: Text(h)))
                        .toList(),
                    rows: options.map((option) {
                      return DataRow(
                        cells: widget.rowBuilder!(option),
                        onSelectChanged: (_) => onSelected(option),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          );
        }

        // ✅ Default simple list
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

