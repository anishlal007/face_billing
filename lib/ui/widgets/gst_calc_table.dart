import 'package:facebilling/core/colors.dart';
import 'package:flutter/material.dart';

class GstDataTableWidget extends StatefulWidget {
  final double totalAmount; // 👈 pass total amount from parent

  const GstDataTableWidget({
    super.key,
    required this.totalAmount,
  });

  @override
  _GstDataTableWidgetState createState() => _GstDataTableWidgetState();
}

class _GstDataTableWidgetState extends State<GstDataTableWidget> {
  final List<double> gstRates = [5, 18, 22]; // percentages

  late List<TextEditingController> _gstAmountControllers;
  late List<TextEditingController> _totalAmountControllers;

  @override
  void initState() {
    super.initState();
    _gstAmountControllers =
        List.generate(gstRates.length, (_) => TextEditingController());
    _totalAmountControllers =
        List.generate(gstRates.length, (_) => TextEditingController());

    _calculateGST(); // 👈 initial calculation
  }

  @override
  void didUpdateWidget(covariant GstDataTableWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.totalAmount != widget.totalAmount) {
      _calculateGST(); // 👈 recalc if parent sends new total
    }
  }

  void _calculateGST() {
    for (int i = 0; i < gstRates.length; i++) {
      final gstPercent = gstRates[i];
      final gstAmount = (widget.totalAmount * gstPercent) / 100;
      final totalWithGst = widget.totalAmount + gstAmount;

      _gstAmountControllers[i].text = gstAmount.toStringAsFixed(2);
      _totalAmountControllers[i].text = totalWithGst.toStringAsFixed(2);
    }
  }

  @override
  void dispose() {
    for (var controller in _gstAmountControllers) {
      controller.dispose();
    }
    for (var controller in _totalAmountControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: gray, width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(50, 0, 0, 0),
            blurRadius: 2,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(primary),
          columns: const [
            DataColumn(
                label: Text(
              'GST%',
              style: const TextStyle(fontSize: 12.0, height: 2.0, color: white),
            )),
            DataColumn(
                label: Text(
              'GST Amount',
              style: const TextStyle(fontSize: 12.0, height: 2.0, color: white),
            )),
            DataColumn(
                label: Text(
              'Total Amount',
              style: const TextStyle(fontSize: 12.0, height: 2.0, color: white),
            )),
          ],
          rows: List.generate(gstRates.length, (index) {
            return DataRow(cells: [
              DataCell(Text(
                "${gstRates[index]}%",
                style:
                    const TextStyle(fontSize: 12.0, height: 2.0, color: black),
              )),
              DataCell(
                SizedBox(
                  width: 100,
                  child: TextField(
                    style: const TextStyle(
                        fontSize: 12.0, height: 2.0, color: black),
                    controller: _gstAmountControllers[index],
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                    ),
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 100,
                  child: TextField(
                    style: const TextStyle(
                        fontSize: 12.0, height: 2.0, color: black),
                    controller: _totalAmountControllers[index],
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    ),
                  ),
                ),
              ),
            ]);
          }),
        ),
      ),
    );
  }
}
