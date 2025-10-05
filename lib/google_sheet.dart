import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart'; // for xlsx
import 'package:csv/csv.dart';     // for csv

class GoogleSheetUploadPage extends StatefulWidget {
  @override
  _GoogleSheetUploadPageState createState() => _GoogleSheetUploadPageState();
}

class _GoogleSheetUploadPageState extends State<GoogleSheetUploadPage> {
  List<List<dynamic>> sheetData = [];

Future<void> pickFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['xlsx', 'csv'],
  );

  if (result != null) {
    if (result.files.single.extension == "xlsx") {
      // ✅ Excel file
      var bytes = result.files.single.bytes; // <-- use bytes for web
      if (bytes != null) {
        var excel = Excel.decodeBytes(bytes);
        List<List<dynamic>> rows = [];

        for (var table in excel.tables.keys) {
          for (var row in excel.tables[table]!.rows) {
            rows.add(row.map((e) => e?.value ?? "").toList());
          }
        }

        setState(() {
          sheetData = rows;
        });
      }
    } else if (result.files.single.extension == "csv") {
      // ✅ CSV file
      var bytes = result.files.single.bytes;
      if (bytes != null) {
        String csvStr = String.fromCharCodes(bytes);
        List<List<dynamic>> rows = const CsvToListConverter().convert(csvStr);

        setState(() {
          sheetData = rows;
        });
      }
    }
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Google Sheet")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: pickFile,
            child: Text("Upload Google Sheet"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: sheetData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(sheetData[index].join(" | ")),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}