import 'package:flutter/material.dart';

class GstDataTableWidget extends StatefulWidget {
  const GstDataTableWidget({super.key});

  @override
  _GstDataTableWidgetState createState() => _GstDataTableWidgetState();
}

class _GstDataTableWidgetState extends State<GstDataTableWidget> {
  final List<String> gstRates = ['5%', '18%', '22%'];

  late List<TextEditingController> _gstAmountControllers;
  late List<TextEditingController> _totalAmountControllers;

  @override
  void initState() {
    super.initState();
    _gstAmountControllers =
        List.generate(gstRates.length, (_) => TextEditingController(text: ''));
    _totalAmountControllers =
        List.generate(gstRates.length, (_) => TextEditingController(text: ''));
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(Colors.blue.shade50),
        columns: const [
          DataColumn(label: Text('GST%')),
          DataColumn(label: Text('GST Amount')),
          DataColumn(label: Text('Total Amount')),
        ],
        rows: List.generate(gstRates.length, (index) {
          return DataRow(cells: [
            DataCell(Text(gstRates[index])),
            DataCell(
              SizedBox(
                width: 80,
                child: TextField(
                  controller: _gstAmountControllers[index],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            DataCell(
              SizedBox(
                width: 80,
                child: TextField(
                  controller: _totalAmountControllers[index],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
          ]);
        }),
      ),
    );
  }
}