import 'package:flutter/material.dart';

class ItemRowControllers {
  final TextEditingController itemCodeController;
  final TextEditingController itemNameController;
  final TextEditingController batchNoController;
  final TextEditingController expiryController;
  final TextEditingController hsnController;
  final TextEditingController qtyController;
  final TextEditingController mrpController;
  final TextEditingController salesRateController;
  final TextEditingController gstController;

  ItemRowControllers({
    String? itemCode,
    String? itemName,
    String? batchNo,
    String? expiry,
    String? hsn,
    String? qty,
    String? mrp,
    String? salesRate,
    String? gst,
  })  : itemCodeController = TextEditingController(text: itemCode),
        itemNameController = TextEditingController(text: itemName),
        batchNoController = TextEditingController(text: batchNo),
        expiryController = TextEditingController(text: expiry),
        hsnController = TextEditingController(text: hsn),
        qtyController = TextEditingController(text: qty),
        mrpController = TextEditingController(text: mrp),
        salesRateController = TextEditingController(text: salesRate),
        gstController = TextEditingController(text: gst);
}