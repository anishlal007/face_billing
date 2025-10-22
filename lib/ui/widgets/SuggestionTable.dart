import 'package:facebilling/core/app_styles.dart';
import 'package:facebilling/core/colors.dart';
import 'package:facebilling/data/models/product/product_master_list_model.dart';
import 'package:flutter/material.dart';

class SuggestionTable extends StatelessWidget {
  final List<productListInfo> suggestions;
  final void Function(productListInfo) onSelect;
  final bool showEmptyMessage;

  const SuggestionTable({
    Key? key,
    required this.suggestions,
    required this.onSelect,
    this.showEmptyMessage = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (suggestions.isEmpty) {
      return showEmptyMessage
          ? Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child: const Text('No items found'),
            )
          : const SizedBox.shrink();
    }

    return Container(
      width: 800,
      margin: const EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        border: Border.all(color: blueAccent),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Header
          Container(
            color: primary,
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                SizedBox(
                    width: 50,
                    child: Center(
                      child: Text(
                        'SlNo',
                        style: tableHeadingStyle,
                      ),
                    )),
                Container(
                  width: 1,
                  height: 30,
                  color: white,
                ),
                SizedBox(
                    width: 150,
                    child: Center(
                      child: Text(
                        'Barcode',
                        style: tableHeadingStyle,
                      ),
                    )),
                Container(
                  width: 1,
                  height: 30,
                  color: white,
                ),
                SizedBox(
                    width: 250,
                    child: Center(
                      child: Text(
                        'Item Name',
                        style: tableHeadingStyle,
                      ),
                    )),
                Container(
                  width: 1,
                  height: 30,
                  color: white,
                ),
                SizedBox(
                    width: 80,
                    child: Center(
                      child: Text(
                        'UOM',
                        style: tableHeadingStyle,
                      ),
                    )),
                Container(
                  width: 1,
                  height: 30,
                  color: white,
                ),
                SizedBox(
                    width: 60,
                    child: Center(
                      child: Text(
                        'Qty',
                        style: tableHeadingStyle,
                      ),
                    )),
                Container(
                  width: 1,
                  height: 30,
                  color: white,
                ),
                SizedBox(
                    width: 80,
                    child: Center(
                      child: Text(
                        'Sales Rate',
                        style: tableHeadingStyle,
                      ),
                    )),
              ],
            ),
          ),
          // Items
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 200),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                final s = suggestions[index];
                return InkWell(
                  onTap: () => onSelect(s),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    child: Row(
                      children: [
                        SizedBox(
                            width: 50,
                            child: Center(child: Text('${index + 1}'))),

                        SizedBox(
                            width: 150,
                            child: Center(child: Text(s.itemCode.toString()))),
                        SizedBox(
                            width: 250,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(s.itemName ?? ''),
                            )),
                        SizedBox(
                            width: 80,
                            child:
                                Center(child: Text(s.itemUnitCode.toString()))),
                        SizedBox(
                            width: 60,
                            child:
                                Center(child: const Text('1'))), // default qty
                        SizedBox(
                            width: 80,
                            child: Center(
                                child: Text(s.salesRate?.toString() ?? ''))),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
