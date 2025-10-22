// To parse this JSON data, do
//
//     final stockModel = stockModelFromJson(jsonString);

import 'dart:convert';

List<StockModel> stockModelFromJson(List<dynamic> src) {
  // print("hjkhjkh ${json.decode(str)}");
  return List<StockModel>.from(src.map((x) => StockModel.fromJson(x)));
}

String stockModelToJson(List<StockModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StockModel {
  String? itemId;
  String? itemCode;
  String? barcodeNo;
  String? itemName;
  String? itemNameArabic;
  String? uomCode;
  String? salesRate;
  String? costRate;
  String? branchId;

  StockModel({
    this.itemId,
    this.itemCode,
    this.barcodeNo,
    this.itemName,
    this.itemNameArabic,
    this.uomCode,
    this.salesRate,
    this.costRate,
    this.branchId,
  });

  StockModel copyWith({
    String? itemId,
    String? itemCode,
    String? barcodeNo,
    String? itemName,
    String? itemNameArabic,
    String? uomCode,
    String? salesRate,
    String? costRate,
    String? branchId,
  }) =>
      StockModel(
        itemId: itemId ?? this.itemId,
        itemCode: itemCode ?? this.itemCode,
        barcodeNo: barcodeNo ?? this.barcodeNo,
        itemName: itemName ?? this.itemName,
        itemNameArabic: itemNameArabic ?? this.itemNameArabic,
        uomCode: uomCode ?? this.uomCode,
        salesRate: salesRate ?? this.salesRate,
        costRate: costRate ?? this.costRate,
        branchId: branchId ?? this.branchId,
      );

  factory StockModel.fromJson(Map<String, dynamic> json) => StockModel(
        itemId: json["ItemID"],
        itemCode: json["ItemCode"],
        barcodeNo: json["Barcode_NO"],
        itemName: json["ItemName"],
        itemNameArabic: json["ItemNameArabic"],
        uomCode: json["UOM_CODE"],
        salesRate: json["SalesRate"],
        costRate: json["CostRate"],
        branchId: json["BranchID"],
      );

  Map<String, dynamic> toJson() => {
        "ItemID": itemId,
        "ItemCode": itemCode,
        "Barcode_NO": barcodeNo,
        "ItemName": itemName,
        "ItemNameArabic": itemNameArabic,
        "UOM_CODE": uomCode,
        "SalesRate": salesRate,
        "CostRate": costRate,
        "BranchID": branchId,
      };
}
