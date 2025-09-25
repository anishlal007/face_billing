import 'package:facebilling/ui/widgets/product_drop_down_field.dart';
import 'package:flutter/material.dart';
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

class _ProductSearchFieldState<T extends Object> extends State<ProductSearchField<T>> {
  final TextEditingController _controller = TextEditingController();
  List<T> _results = [];
  bool _loading = false;

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

  @override
  Widget build(BuildContext context) {
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
          //  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onChanged: _search,
        ),
        const SizedBox(height: 8),
        if (_results.isNotEmpty || _loading)
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            constraints: BoxConstraints(
              maxHeight: 300, // adjust height as needed
            ),
            child: _loading
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  )
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      child: DataTable(
                        headingRowColor:
                            MaterialStateProperty.all(Colors.blue[50]),
                        columns: widget.columnHeaders
                            .map((h) => DataColumn(label: Text(h)))
                            .toList(),
                        rows: _results.map((item) {
                          return DataRow(
                            cells: widget.rowBuilder(item),
                            onSelectChanged: (_) {
                              if (widget.onSelected != null) {
                                widget.onSelected!(item);
                              }
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
          ),
      ],
    );
  }
}