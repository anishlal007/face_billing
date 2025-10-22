import 'package:facebilling/core/app_globals.dart';
import 'package:facebilling/core/app_styles.dart';
import 'package:facebilling/core/colors.dart';
import 'package:facebilling/core/convertors.dart';
import 'package:facebilling/data/models/unit/unit_response.dart';
import 'package:facebilling/ui/widgets/Table_Component/custom_components.dart';
import 'package:facebilling/ui/widgets/Table_Component/item_add_grid_contoller.dart';
import 'package:facebilling/ui/widgets/Table_Component/models/data_cell_model.dart';
import 'package:facebilling/ui/widgets/Table_Component/models/stock_model.dart';
import 'package:facebilling/ui/widgets/Table_Component/stock_transfer_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'item_add_grid_variable.dart';

class CustomDataTableComponent extends StatefulWidget {
  List<DataCellModel> dataList;
  Function() callBack;
  Function(Widget) suggestionData;
  Function(int totalItems, int totalQty, double totalCost)? onUpdate;
  List<Map<String, dynamic>>? savedTableData;
  Function(List<Map<String, dynamic>>)? onSave;
  final List<Map<String, dynamic>>? initialData;
  String? screen;
  CustomDataTableComponent({
    super.key,
    this.initialData,
    required this.dataList,
    required this.callBack,
    required this.suggestionData,
    this.savedTableData,
    this.onUpdate,
    this.onSave,
    this.screen,
  });

  @override
  State<CustomDataTableComponent> createState() =>
      CustomDataTableComponentState();
}

class CustomDataTableComponentState extends State<CustomDataTableComponent> {
  List<Map<String, dynamic>> tableData = [];
  // List<Map<String, dynamic>> savedTableData = [];
  List<dynamic> printList = [];
  Map<String, DataCellModel> rowField = {};
  Map<int, TableColumnWidth> colWidth = {};
  ScrollController scrollController = ScrollController();
  List<TableRow> tableRowList = [];
  List<Widget> suggestionHeader = [];
  Map<int, double> suggestion1ColWidth = {};
  List<TableRow> headerRowList = [];
  int totalQty = 0;
  int totalItems = 0;
  String uom = "PCS";
  double totalCost = 0.00;
  List<StockModel> stockList = [];
  List<Map<String, dynamic>> savedTableData = [];
  String formatAsCurrency(double value) {
    return "${value.toStringAsFixed(2)} SAR";
  }

  int _suggestionIndex = 0;
  final FocusNode _suggestionListFocus = FocusNode();
  List<StockModel> suggestionDataList = [];

  // bool isRowEmpty(StockItemsTextEditController s) {
  //   return s.itemCodeControl.text.trim().isEmpty &&
  //       s.qtyControl.text.trim().isEmpty;
  // }
  bool isRowEmpty(StockItemsTextEditController controller) {
    return controller.itemCodeControl.text.trim().isEmpty &&
        controller.itemNameControl.text.trim().isEmpty &&
        controller.barcodeControl.text.trim().isEmpty;
  }

  double costRate = 0.0;
  final minqty = const SnackBar(
    content: Text('Minimum Qty 1'),
    backgroundColor: red,
  );
  double parseAndCalculate(String value, int multiplier) {
    return (double.tryParse(value) ?? 0.0) * multiplier;
  }

  int editIndex = 0;
  final FocusNode _focusNode = FocusNode();
  // FocusAttachment? _focusAttachment;
  List<String> fdf = [];

  void saveTableData() {
    tableData = controllers.map((controller) {
      return {
        "slNo": controller.slNoControl.text,
        "itemCode": controller.itemCodeControl.text,
        "barcode": controller.barcodeControl.text,
        "itemName": controller.itemNameControl.text,
        "uom": controller.uomControl.text,
        "qty": controller.qtyControl.text,
        "rate": controller.rateControl.text,
        "grossAmount": controller.grossAmountControl.text,
        "vatAmount": controller.vatAmountControl.text,
        "netAmount": controller.netAmountControl.text,
      };
    }).toList();

    widget.onSave?.call(tableData); // Send data to parent widget
  }

  void loadData() {
    if (savedTableData.isNotEmpty) {
      for (var row in savedTableData) {
        addRow(rowData: row);
      }
    }
  }

  void suggestionDataSelected(StockModel s) {
    final code = s.itemId;
    if (controllers.any((c) => c.itemCodeControl.text == code)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Item already added"),
          backgroundColor: red,
        ),
      );
      widget.suggestionData(Container());
      return;
    }
    // 🛑 Prevent out-of-bounds access
    if (currentRow >= controllers.length) {
      currentRow = controllers.length - 1; // fallback to last valid row
    }

    // ✅ Update the row
    controllers[currentRow].itemNameControl.text = s.itemName!;
    controllers[currentRow].itemCodeControl.text = s.itemId!;
    controllers[currentRow].barcodeControl.text = s.barcodeNo!;
    controllers[currentRow].uomControl.text = s.uomCode!;
    controllers[currentRow].rateControl.text =
        double.parse(s.salesRate!).toStringAsFixed(2);
    controllers[currentRow].costRate = double.parse(s.costRate!);
    controllers[currentRow].qtyControl.text = "1";

    double rate = double.tryParse(s.costRate!) ?? 0.0;
    int qty = 1;
    double gross = rate * qty;
    double vat = gross * 0.15;
    double net = gross + vat;

    controllers[currentRow].grossAmountControl.text =
        "${gross.toStringAsFixed(2)} SAR";
    controllers[currentRow].vatAmountControl.text =
        widget.screen == "Opening_Stock"
            ? "0.00 SAR"
            : "${vat.toStringAsFixed(2)} SAR";
    controllers[currentRow].netAmountControl.text =
        widget.screen == "Opening_Stock"
            ? "${gross.toStringAsFixed(2)} SAR"
            : "${net.toStringAsFixed(2)} SAR";

    // ✅ Only add row if we are editing the last one
    if (currentRow == controllers.length - 1) {
      addRow();
    }

    widget.suggestionData(Container());
  }

  @override
  void initState() {
    savedTableData = widget.initialData ?? [];
    print(savedTableData.length);
    controllers.clear();
    loadData();
    fdf = List.generate(10, (i) => "Hello${i}");
    List<Widget> g = [];

    for (int i = 0; i < widget.dataList.length; i++) {
      g.add(Container(
          padding: const EdgeInsets.all(5),
          child: Text(
            "${widget.dataList[i].label}",
            style: TextStyle(color: white),
            textAlign: TextAlign.center,
          )));
      colWidth[i] = FlexColumnWidth(
          Convertors.convertDataCellToWidth(widget.dataList[i].dataCellSize));
      // rowField[t.label.toLowerCase().replaceAll(" ", "_")]=t;
    }
    var su = widget.dataList.where((test) => test.showInSuggestion).toList();
    for (int i = 0; i < su.length; i++) {
      print(su[i].label);
      if (su[i].label == "SL No" ||
          su[i].label == "ITEM CODE" ||
          su[i].label == "BARCODE NO" ||
          su[i].label == "ITEM NAME" ||
          su[i].label == "UOM" ||
          su[i].label == "QTY" ||
          su[i].label == "RATE" ||
          su[i].label == "COST RATE") {
        suggestionHeader.add(Container(
            decoration: const BoxDecoration(
                color: primary,
                border: Border(bottom: BorderSide(color: gray))),
            width: Convertors.convertDataCellToWidth(su[i].dataCellSize),
            padding: const EdgeInsets.all(5),
            child: su[i].label == "RATE"
                ? Text(
                    "SALES RATE",
                    style: tableHeadingStyle,
                    textAlign: TextAlign.center,
                  )
                : Text(
                    "${su[i].label}",
                    style: tableHeadingStyle,
                    textAlign: TextAlign.center,
                  )));

        suggestion1ColWidth[i] =
            Convertors.convertDataCellToWidth(su[i].dataCellSize);
      }
    }

    headerRowList.add(TableRow(
        decoration: const BoxDecoration(
            color: primary,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        children: g));

    addRow();
    /* var d=widget.dataList.map((i)=>dataCell(con: context, data: i.label)).toList();
    var g=DataRow(cells: d);
    rowDataList.add(g);*/
    // TODO: implement initState
    super.initState();
  }

  void addRow({Map<String, dynamic>? rowData}) {
    StockItemsTextEditController s = StockItemsTextEditController();
    // If rowData is provided, populate the fields
    if (rowData != null) {
      s.slNoControl.text = rowData["sl_no"].toString();
      s.itemCodeControl.text = rowData["item_code"] ?? "";
      s.barcodeControl.text = rowData["barcode"] ?? "";
      s.itemNameControl.text = rowData["item_name"] ?? "";
      s.uomControl.text = rowData["uom"] ?? "";
      s.qtyControl.text = rowData["qty"].toString();
      s.rateControl.text = "${rowData["rate"].toString()} SAR";
      s.costrateControl.text = "${rowData["cost_rate"].toString()} SAR";
      s.costRate = double.tryParse(rowData["cost_rate"].toString()) ?? 0.0;
      s.grossAmountControl.text = "${rowData["gross_amount"].toString()} SAR";
      s.vatAmountControl.text = "${rowData["vat_amount"].toString()} SAR";
      s.netAmountControl.text = "${rowData["net_amount"].toString()} SAR";
    } else {
      // Assign a serial number if it's a new row
      s.slNoControl.text = (controllers.length + 1).toString();
    }

    currentRow = controllers.length;
    totalItems = controllers.length;
    totalQty = controllers.fold(
        0, (sum, item) => sum + (int.tryParse(item.qtyControl.text) ?? 0));
    totalCost = controllers.fold(
      0.0,
      (sum, item) {
        double value = double.tryParse(item.grossAmountControl.text
                .replaceAll(RegExp(r'[^0-9.]'), '')) ??
            0.0;
        return sum + value;
      },
    );

    // Call the callback function to update `StackTransfer.dart`
    widget.onUpdate?.call(totalItems, totalQty, totalCost);

    List<Widget> rowWidgets = [];
    for (int d = 0; d < widget.dataList.length; d++) {
      rowWidgets.add(
        widget.dataList[d].dataCellDataType == DataCellDataType.BUTTON
            ? StatefulBuilder(
                builder: (context, setStateIcon) {
                  return Row(
                    children: [
                      //
                      IconButton(
                        onPressed: () {
                          int index = controllers.indexOf(s);
                          if (index != -1) {
                            print(isRowEmpty);
                            if (isRowEmpty(s)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Cannot delete an empty row.")));
                              return;
                            }

                            // ✅ Proceed with delete
                            tableRowList.removeAt(index);
                            controllers.removeAt(index);
                            totalItems = controllers.length;
                            totalQty = controllers.fold(
                              0,
                              (sum, item) =>
                                  sum +
                                  (int.tryParse(item.qtyControl.text) ?? 0),
                            );
                            totalCost = controllers.fold(0.0, (sum, item) {
                              double value = double.tryParse(
                                    item.grossAmountControl.text
                                        .replaceAll(RegExp(r'[^0-9.]'), ''),
                                  ) ??
                                  0.0;
                              return sum + value;
                            });

                            for (int i = 0; i < controllers.length; i++) {
                              controllers[i].slNoControl.text = "${i + 1}";
                            }

                            widget.onUpdate
                                ?.call(totalItems, totalQty, totalCost);
                            setState(() {});
                          }
                        },
                        icon: Icon(
                          isRowEmpty(s) ? Icons.delete : Icons.delete,
                          color: isRowEmpty(s) ? red : red,
                        ),
                      ),
                    ],
                  );
                },
              )
            : widget.dataList[d].label.toLowerCase().contains("uom")
                ? TypeAheadField<UnitInfo>(
                    controller: s.uomControl,
                    suggestionsCallback: (pattern) {
                      if (pattern.isEmpty) return uomlist;
                      return uomlist
                          .where((t) =>
                              (t.unitId ?? "")
                                  .toLowerCase()
                                  .contains(pattern.toLowerCase()) ||
                              (t.unitName ?? "")
                                  .toLowerCase()
                                  .contains(pattern.toLowerCase()))
                          .toList();
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(
                          suggestion.unitName ?? "",
                          style: const TextStyle(fontSize: 12),
                        ),
                        subtitle: Text(
                          suggestion.unitId ?? "",
                          style: const TextStyle(fontSize: 10),
                        ),
                      );
                    },
                    onSelected: (suggestion) {
                      setState(() {
                        s.uomControl.text = suggestion.unitId ?? "";
                      });
                    },
                    builder: (context, fieldController, focusNode) {
                      return TextField(
                        style: const TextStyle(fontSize: 14),
                        controller: fieldController,
                        focusNode: focusNode,
                        decoration: boxBorderStyle.copyWith(
                          hintText: "Select UOM",
                          hintStyle: normalGreyTextStyle,
                        ),
                      );
                    },
                    emptyBuilder: (context) => const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("No UOM found"),
                    ),
                  )
                : customTableTextField(
                    con: context,
                    title: widget.dataList[d].label,
                    removeLabel: true,
                    // editable: widget.dataList[d].editable,
                    withoutMargin: true,
                    isNumeric: widget.dataList[d].dataCellDataType !=
                        DataCellDataType.TEXT,
                    controller: s.assignController(widget.dataList[d].label
                        .toLowerCase()
                        .replaceAll(" ", "_")),
                    onEditingComplete: () {
                      String label = widget.dataList[d].label.toLowerCase();
                      if (label.contains("qty")) {
                        validateAmount(s);
                      } else if (label.contains("rate")) {
                        validateAmount(s);
                      }
                    },
                    onChange: (da) {
                      String label = widget.dataList[d].label.toLowerCase();
                      if (label.contains("item name")) {
                        updateSuggestionTable("item name", da);
                        setState(() {});
                      } else if (label.contains("uom")) {
                      } else if (label.contains("item code")) {
                        updateSuggestionTable("item code", da);
                      } else if (label.contains("barcode")) {
                        updateSuggestionTable("barcode", da);
                      } else if (label.contains("qty")) {
                        updateGrossAmount(s);
                      } else if (label.contains("rate")) {
                        updateGrossAmount(s);
                      }
                    },
                  ),
      );
    }

    controllers.add(s);
    for (int i = 0; i < controllers.length; i++) {
      controllers[i].slNoControl.text = "${i + 1}";
    }

    tableRowList.add(TableRow(children: rowWidgets));

    if (scrollController.hasClients) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }

    saveTableData();
    setState(() {});
  }

// 🔹 Function to update Gross Amount
  void validateAmount(StockItemsTextEditController s) {
    int qty = int.tryParse(s.qtyControl.text) ?? 1;
    if ((qty <= 0) || s.qtyControl.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(minqty);
      s.qtyControl.text = "1";
      qty = 1;
    }
    double enteredRate = double.tryParse(s.rateControl.text) ?? 0.0;

    if (s.costRate > enteredRate) {
      int qty = int.tryParse(s.qtyControl.text) ?? 1;
      if ((qty <= 0) || s.qtyControl.text == "") {
        ScaffoldMessenger.of(context).showSnackBar(minqty);
        s.qtyControl.text = "1";
        qty = 1;
        updateGrossAmount(s);
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            "Sales Rate must be greater than Cost Rate : (${s.costRate.toStringAsFixed(2)})"),
        backgroundColor: red,
      ));
      s.rateControl.text = "${(s.costRate)}";
      updateGrossAmount(s);
    } else {
      s.rateControl.text = (enteredRate).toStringAsFixed(2);
    }
  }

  void updateGrossAmount(StockItemsTextEditController s) {
    int qty = int.tryParse(s.qtyControl.text) ?? 1;
    if ((qty <= 0) || s.qtyControl.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(minqty);
      // s.qtyControl.text = "1";
      // qty = 1;
    }

    double rate = 0.00;
    double enteredRate = double.tryParse(s.rateControl.text) ?? 0.0;

    if (s.costRate > enteredRate) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            "Sales Rate must be greater than Cost Rate : (${s.costRate.toStringAsFixed(2)})"),
        backgroundColor: red,
      ));
      // s.rateControl.text = "${(s.costRate)}";
      // rate = s.costRate;
    } else {
      rate = double.tryParse(s.rateControl.text) ?? 0.0;
    }

    double grossAmount = qty * rate;

    print(grossAmount);
    s.grossAmountControl.text = "${(qty * rate).toStringAsFixed(2)} SAR";
    s.vatAmountControl.text = "0.00";
    s.netAmountControl.text = "0.00";

    totalQty = controllers.fold(
        0, (sum, item) => (sum + (int.tryParse(item.qtyControl.text) ?? 0)));
    totalItems = (controllers.length - 1);
    totalCost = controllers.fold(
        0,
        (sum, item) =>
            sum +
            (double.tryParse(item.grossAmountControl.text
                    .replaceAll(RegExp(r'[^0-9.]'), '')) ??
                0.0));
    //  controllers.fold(
    //   0.0,
    //   (sum, item) {
    //     // Extract numeric value, ignoring non-numeric characters like "SAR"
    //     double value = double.tryParse(
    //             s.grossAmountControl.text.replaceAll(RegExp(r'[^0-9.]'), '')) ??
    //         0.0;
    //     return sum + value;
    //   },
    // );

    widget.onUpdate?.call(totalItems, totalQty, totalCost);
    saveTableData();
    setState(() {});
  }

  Future<void> updateSuggestionTable(String field, String value) async {
    if (mounted) {
      widget.suggestionData(Container());
    }

    List<StockModel> h = [];
    if (field.toLowerCase() == "item name") {
      h = await ItemAddGridController.getItemByKeyword(itemName: value);
    }
    if (field.toLowerCase() == "item code") {
      h = await ItemAddGridController.getItemByKeyword(itemCode: value);
    }
    if (field.toLowerCase() == "barcode") {
      h = await ItemAddGridController.getItemByKeyword(barCode: value);
    }

    suggestionDataList = h;

    if (suggestionDataList.isEmpty) {
      widget.suggestionData(Container());
    } else {
      final scrollController = ScrollController();

      widget.suggestionData(
        Container(
          decoration: boxCurvedDecoration,
          // width: MediaQuery.of(context).size.width,
          height: 370,
          child: Focus(
            autofocus: true,
            focusNode: _suggestionListFocus,
            onKeyEvent: (node, event) {
              if (event is! KeyDownEvent) return KeyEventResult.ignored;

              if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
                setState(() {
                  _suggestionIndex =
                      (_suggestionIndex + 1) % suggestionDataList.length;
                });
                scrollController.animateTo(
                  _suggestionIndex * 45.0, // approx item height
                  duration: Duration(milliseconds: 150),
                  curve: Curves.easeInOut,
                );
                return KeyEventResult.handled;
              } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
                setState(() {
                  _suggestionIndex =
                      (_suggestionIndex - 1 + suggestionDataList.length) %
                          suggestionDataList.length;
                });
                scrollController.animateTo(
                  _suggestionIndex * 45.0,
                  duration: Duration(milliseconds: 150),
                  curve: Curves.easeInOut,
                );
                return KeyEventResult.handled;
              } else if (event.logicalKey == LogicalKeyboardKey.enter) {
                final selected = suggestionDataList[_suggestionIndex];
                suggestionDataSelected(selected);
                _suggestionIndex = 0;
                widget.suggestionData(Container()); // close list
                return KeyEventResult.handled;
              }

              return KeyEventResult.ignored;
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: suggestionHeader),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: suggestionDataList.length,
                    itemBuilder: (context, index) {
                      final isSelected = index == _suggestionIndex;
                      final item = suggestionDataList[index];

                      return InkWell(
                        onTap: () {
                          suggestionDataSelected(item);
                          widget.suggestionData(Container());
                        },
                        child: Container(
                          color: isSelected
                              ? const Color.fromARGB(65, 20, 41, 84)
                              : null,
                          child: Row(
                            children: [
                              Container(
                                width: suggestion1ColWidth[0],
                                padding: EdgeInsets.all(5),
                                child: Text("1", textAlign: TextAlign.center),
                              ),
                              Container(
                                width: suggestion1ColWidth[1],
                                padding: EdgeInsets.all(5),
                                child: Text("${item.itemCode}",
                                    textAlign: TextAlign.center),
                              ),
                              Container(
                                width: suggestion1ColWidth[2],
                                padding: EdgeInsets.all(5),
                                child: Text("${item.barcodeNo}",
                                    textAlign: TextAlign.center),
                              ),
                              Container(
                                width: suggestion1ColWidth[3],
                                padding: EdgeInsets.all(5),
                                child: Text("${item.itemName}",
                                    textAlign: TextAlign.center),
                              ),
                              Container(
                                width: suggestion1ColWidth[1],
                                padding: EdgeInsets.all(5),
                                child: Text("${item.uomCode}",
                                    textAlign: TextAlign.center),
                              ),
                              Container(
                                width: suggestion1ColWidth[0],
                                padding: EdgeInsets.all(5),
                                child: Text("1", textAlign: TextAlign.center),
                              ),
                              Container(
                                width: suggestion1ColWidth[1],
                                padding: EdgeInsets.all(5),
                                child: Text("${item.salesRate}",
                                    textAlign: TextAlign.center),
                              ),
                              Container(
                                width: suggestion1ColWidth[1],
                                padding: EdgeInsets.all(5),
                                child: Text("${item.costRate}",
                                    textAlign: TextAlign.center),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _suggestionListFocus.requestFocus();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Expanded(
      child: Container(
        child: RawKeyboardListener(
            focusNode: _focusNode,
            onKey: (i) {
              if (i.isKeyPressed(LogicalKeyboardKey.enter)) {
                // addRow();
                if (scrollController.hasClients) {
                  scrollController
                      .jumpTo(scrollController.position.maxScrollExtent);
                }
              }
            },
            child: Column(
              children: [
                Table(
                  border: TableBorder.all(
                      width: 0.2,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  children: headerRowList,
                  columnWidths: colWidth,
                ),
                Expanded(
                    child: SingleChildScrollView(
                        controller: scrollController,
                        child: Table(
                          border: TableBorder.all(
                              width: 0.2,
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          children: tableRowList,
                          columnWidths: colWidth,
                        ))),
              ],
            )),
      ),
    );
  }
}
