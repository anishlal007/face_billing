import 'package:facebilling/data/models/product/product_master_list_model.dart';
import 'package:flutter/material.dart';

// class MainTableRow {
//   TextEditingController barcodeController;
//   TextEditingController itemNameController;
//   String? uom;
//   String? qty;
//   String? tax;
//   String? salesRate;
//   String? netRate;

//   MainTableRow({
//     required this.barcodeController,
//     required this.itemNameController,
//     this.uom,
//     this.qty,
//     this.tax,
//     this.salesRate,
//     this.netRate,
//   });

//   factory MainTableRow.empty() => MainTableRow(
//         barcodeController: TextEditingController(),
//         itemNameController: TextEditingController(),
//         uom: '',
//         qty: '',
//         tax: '',
//         salesRate: '',
//         netRate: '',
//       );

//   bool get isEmpty =>
//       barcodeController.text.isEmpty && itemNameController.text.isEmpty;
// }
// Model for main table row
// class MainTableRow {
//   dynamic itemCode;
//   dynamic itemID;
//   dynamic itemName;
//   dynamic itemType;
//   dynamic itemGroupCode;
//   dynamic itemMakeCode;
//   dynamic itemGenericCode;
//   dynamic batchNoRequired;
//   dynamic expiryDateRequired;
//   dynamic expiryDateFormat;
//   dynamic mFGDateRequired;
//   dynamic narcoticItem;
//   dynamic nonScheduleItem;
//   dynamic scheduledH1Item;
//   dynamic itemUnitCode;
//   dynamic subUnitCode;
//   dynamic subQty;
//   dynamic subQtyFormalDigits;
//   dynamic stockRequired;
//   dynamic minimumStockQty;
//   dynamic maximumStockQty;
//   dynamic reOrderLevel;
//   dynamic reOrderQty;
//   dynamic hSNCode;
//   dynamic gstPercentage;
//   dynamic priceTakenFrom;
//   dynamic purchaseRate;
//   dynamic purchaseRateWTax;
//   dynamic salesRate;
//   dynamic mRPRate;
//   dynamic itemDiscountRequired;
//   dynamic itemDiscountPercentage;
//   dynamic itemDiscountValue;
//   dynamic itemImage;
//   dynamic createdDate;
//   dynamic createdUserCode;
//   dynamic updatedDate;
//   dynamic updatedUserCode;
//   dynamic itemRackNo;
//   dynamic itemSelfNo;
//   dynamic itemBoxNo;
//   String? qty;

//   MainTableRow({
//    this.itemCode,
//       this.itemID,
//       this.itemName,
//       this.itemType,
//       this.itemGroupCode,
//       this.itemMakeCode,
//       this.itemGenericCode,
//       this.batchNoRequired,
//       this.expiryDateRequired,
//       this.expiryDateFormat,
//       this.mFGDateRequired,
//       this.narcoticItem,
//       this.nonScheduleItem,
//       this.scheduledH1Item,
//       this.itemUnitCode,
//       this.subUnitCode,
//       this.subQty,
//       this.subQtyFormalDigits,
//       this.stockRequired,
//       this.minimumStockQty,
//       this.maximumStockQty,
//       this.reOrderLevel,
//       this.reOrderQty,
//       this.hSNCode,
//       this.gstPercentage,
//       this.priceTakenFrom,
//       this.purchaseRate,
//       this.purchaseRateWTax,
//       this.salesRate,
//       this.mRPRate,
//       this.itemDiscountRequired,
//       this.itemDiscountPercentage,
//       this.itemDiscountValue,
//       this.itemImage,
//       this.createdDate,
//       this.createdUserCode,
//       this.updatedDate,
//       this.updatedUserCode,
//       this.itemRackNo,
//       this.itemSelfNo,
//       this.itemBoxNo,
//       this.qty
//   });

//   factory MainTableRow.empty() => MainTableRow(
//          itemCode : "" ,
//        itemID : "" ,
//        itemName : "" ,
//        itemType : "" ,
//        itemGroupCode : "" ,
//        itemMakeCode : "" ,
//        itemGenericCode : "" ,
//        batchNoRequired : "" ,
//        expiryDateRequired : "" ,
//        expiryDateFormat : "" ,
//        mFGDateRequired : "" ,
//        narcoticItem : "" ,
//        nonScheduleItem : "" ,
//        scheduledH1Item : "" ,
//        itemUnitCode : "" ,
//        subUnitCode : "" ,
//        subQty : "" ,
//        subQtyFormalDigits : "" ,
//        stockRequired : "" ,
//        minimumStockQty : "" ,
//        maximumStockQty : "" ,
//        reOrderLevel : "" ,
//        reOrderQty : "" ,
//        hSNCode : "" ,
//        gstPercentage : "" ,
//        priceTakenFrom : "" ,
//        purchaseRate : "" ,
//        purchaseRateWTax : "" ,
//        salesRate : "" ,
//        mRPRate : "" ,
//        itemDiscountRequired : "" ,
//        itemDiscountPercentage : "" ,
//        itemDiscountValue : "" ,
//        itemImage : "" ,
//        createdDate : "" ,
//        createdUserCode : "" ,
//        updatedDate : "" ,
//        updatedUserCode : "" ,
//        itemRackNo : "" ,
//        itemSelfNo : "" ,
//        itemBoxNo : "" ,
//        qty: "",
//       );

//   bool get isEmpty => (itemCode ?? '').isEmpty && (itemName ?? '').isEmpty;
// }
class MainTableRow {
  TextEditingController itemCodeController;
  TextEditingController itemNameController;
  TextEditingController batchNoRequired;
  TextEditingController qtyController;
  TextEditingController purchaseRateController;
  TextEditingController salesRateController;
  TextEditingController mrpRateController;
  TextEditingController gstPercentageController;
  TextEditingController discountPercentageController;
  TextEditingController taxableValueController;

  TextEditingController netRateController = TextEditingController();
  double gstValue = 0;
  double discountValue = 0;
  double taxableRate = 0;
  double netRate = 0;
  double netValue = 0;

  // You can keep other metadata fields as dynamic if not directly editable
  dynamic itemID;
  dynamic itemType;
  // dynamic batchNoRequired;
  dynamic expiryDateFormat;
  dynamic subUnitCode;
  dynamic hsn;

  MainTableRow({
    String? itemCode,
    String? itemName,
    String? batchNoRequired,
    String? qty,
    String? purchaseRate,
    String? salesRate,
    String? mrpRate,
    String? gstPercentage,
    String? discountPercentage,
    String? taxableValue,
    this.itemID,
    this.hsn,
    this.itemType,
    // this.batchNoRequired,
    this.expiryDateFormat,
    this.subUnitCode,
  })  : itemCodeController = TextEditingController(text: itemCode ?? ''),
        itemNameController = TextEditingController(text: itemName ?? ''),
        batchNoRequired = TextEditingController(text: batchNoRequired ?? ''),
        qtyController = TextEditingController(text: qty ?? ''),
        purchaseRateController =
            TextEditingController(text: purchaseRate ?? ''),
        salesRateController = TextEditingController(text: salesRate ?? ''),
        mrpRateController = TextEditingController(text: mrpRate ?? ''),
        gstPercentageController =
            TextEditingController(text: gstPercentage ?? ''),
        discountPercentageController =
            TextEditingController(text: discountPercentage ?? ''),
        taxableValueController =
            TextEditingController(text: taxableValue ?? '');

  factory MainTableRow.empty() => MainTableRow();

  bool get isEmpty =>
      itemCodeController.text.isEmpty && itemNameController.text.isEmpty;
}

class ProductRow {
  String? barcode;
  String? itemName;
  String? uom;
  String? qty;
  String? tax;
  String? salesRate;
  String? netRate;

  ProductRow({
    this.barcode,
    this.itemName,
    this.uom,
    this.qty,
    this.tax,
    this.salesRate,
    this.netRate,
  });

  bool get isEmpty =>
      (barcode == null || barcode!.isEmpty) &&
      (itemName == null || itemName!.isEmpty);

  factory ProductRow.empty() => ProductRow();

  factory ProductRow.fromInfo(productListInfo info) {
    return ProductRow(
      barcode: info.itemCode?.toString() ?? "",
      itemName: info.itemName?.toString() ?? "",
      uom: info.itemUnitCode?.toString() ?? "",
      qty: "1",
      tax: info.gstPercentage?.toString() ?? "0",
      salesRate: info.salesRate?.toString() ?? "0",
      netRate: info.salesRate?.toString() ?? "0",
    );
  }
}
