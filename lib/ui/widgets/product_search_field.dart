import 'dart:async';
import 'package:flutter/material.dart';

// small typedefs so the file is self-contained
typedef FetchCallback<T extends Object> = Future<List<T>> Function(String query);
typedef RowBuilder<T extends Object> = List<DataCell> Function(T option);
typedef OnSelected<T extends Object> = void Function(T selected);

class ProductSearchField<T extends Object> extends StatefulWidget {
  final FetchCallback<T> fetchItems;
  final RowBuilder<T> rowBuilder;
  final List<String> columnHeaders;
  final String hintText;
  final OnSelected<T>? onSelected;

  const ProductSearchField({
    super.key,
    required this.fetchItems,
    required this.rowBuilder,
    required this.columnHeaders,
    this.hintText = "",
    this.onSelected,
  });

  @override
  State<ProductSearchField<T>> createState() => _ProductSearchFieldState<T>();
}

class _ProductSearchFieldState<T extends Object>
    extends State<ProductSearchField<T>> {
  final TextEditingController _controller = TextEditingController();
  List<T> _results = [];
  bool _loading = false;
  Timer? _debounce;

  Future<void> _search(String query) async {
    if (query.isEmpty) {
      setState(() => _results = []);
      return;
    }
    setState(() => _loading = true);
    final results = await widget.fetchItems(query);
    setState(() {
      _results = results;
      _loading = false;
    });
  }

  void _onChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      _search(query);
    });
  }

  void _handleSelect(T item) {
    print("✅ ProductSearchField - selected: ${item.toString()}");

    widget.onSelected?.call(item);

    setState(() {
      _controller.clear();
      _results.clear();
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasQuery = _controller.text.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: const Icon(Icons.search),
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
          ),
          onChanged: _onChanged,
          onSubmitted: _search,
        ),
        const SizedBox(height: 8),
        if (_loading)
          const Center(child: CircularProgressIndicator())
        else if (hasQuery && _results.isEmpty)
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text("No results found"),
          )
        else if (_results.isNotEmpty)
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            constraints: const BoxConstraints(maxHeight: 300),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                showCheckboxColumn: false,
                headingRowColor:
                    MaterialStateProperty.all(Colors.blue[50]),
                columns: widget.columnHeaders
                    .map((h) => DataColumn(label: Text(h)))
                    .toList(),
                rows: _results.map((item) {
                  return DataRow(
                    onSelectChanged: (_) => _handleSelect(item),
                    cells: widget.rowBuilder(item),
                  );
                }).toList(),
              ),
            ),
          ),
      ],
    );
  }
}
