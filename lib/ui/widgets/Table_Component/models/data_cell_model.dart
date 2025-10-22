import 'package:flutter/cupertino.dart';

class DataCellModel {
  String label;
  DataCellSize dataCellSize;
  DataCellDataType dataCellDataType;
  bool editable;
  bool showInSuggestion;

  DataCellModel(
      {required this.label,
      this.dataCellSize = DataCellSize.M,
      this.dataCellDataType = DataCellDataType.NUMBER,
      this.editable = false,
      this.showInSuggestion = true});
}

enum DataCellSize { XS, S, M, L }

enum DataCellDataType { NUMBER, TEXT, BUTTON }
