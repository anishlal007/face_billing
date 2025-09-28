import 'package:flutter/material.dart';

class ItemRowControllers {
  // Text controllers
  final TextEditingController itemCodeController;
  final TextEditingController itemNameController;
  final TextEditingController batchNoController;
  final TextEditingController expiryController;
  final TextEditingController hsnController;
  final TextEditingController qtyController;
  final TextEditingController mrpController;
  final TextEditingController salesRateController;
  final TextEditingController gstController;

  // Newly added controllers
  final TextEditingController discountPercentageController;
  final TextEditingController discountValueController;
  final TextEditingController gstPercentageController;
  final TextEditingController gstValueController;
  final TextEditingController taxableValueController;
  final TextEditingController netRateController;
  final TextEditingController netValueController;
  final TextEditingController remarkController;

  // Focus nodes
  final FocusNode itemCodeFocus;
  final FocusNode itemNameFocus;
  final FocusNode batchNoFocus;
  final FocusNode expiryFocus;
  final FocusNode hsnFocus;
  final FocusNode qtyFocus;
  final FocusNode mrpFocus;
  final FocusNode salesRateFocus;
  final FocusNode gstFocus;

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
    String? discountPercentage,
    String? discountValue,
    String? gstPercentage,
    String? gstValue,
    String? taxableValue,
    String? netRate,
    String? netValue,
    String? remark,
  })  : itemCodeController = TextEditingController(text: itemCode),
        itemNameController = TextEditingController(text: itemName),
        batchNoController = TextEditingController(text: batchNo),
        expiryController = TextEditingController(text: expiry),
        hsnController = TextEditingController(text: hsn),
        qtyController = TextEditingController(text: qty),
        mrpController = TextEditingController(text: mrp),
        salesRateController = TextEditingController(text: salesRate),
        gstController = TextEditingController(text: gst),
        discountPercentageController =
            TextEditingController(text: discountPercentage),
        discountValueController = TextEditingController(text: discountValue),
        gstPercentageController = TextEditingController(text: gstPercentage),
        gstValueController = TextEditingController(text: gstValue),
        taxableValueController = TextEditingController(text: taxableValue),
        netRateController = TextEditingController(text: netRate),
        netValueController = TextEditingController(text: netValue),
        remarkController = TextEditingController(text: remark),
        itemCodeFocus = FocusNode(),
        itemNameFocus = FocusNode(),
        batchNoFocus = FocusNode(),
        expiryFocus = FocusNode(),
        hsnFocus = FocusNode(),
        qtyFocus = FocusNode(),
        mrpFocus = FocusNode(),
        salesRateFocus = FocusNode(),
        gstFocus = FocusNode();

  void dispose() {
    itemCodeController.dispose();
    itemNameController.dispose();
    batchNoController.dispose();
    expiryController.dispose();
    hsnController.dispose();
    qtyController.dispose();
    mrpController.dispose();
    salesRateController.dispose();
    gstController.dispose();
    discountPercentageController.dispose();
    discountValueController.dispose();
    gstPercentageController.dispose();
    gstValueController.dispose();
    taxableValueController.dispose();
    netRateController.dispose();
    netValueController.dispose();
    remarkController.dispose();

    itemCodeFocus.dispose();
    itemNameFocus.dispose();
    batchNoFocus.dispose();
    expiryFocus.dispose();
    hsnFocus.dispose();
    qtyFocus.dispose();
    mrpFocus.dispose();
    salesRateFocus.dispose();
    gstFocus.dispose();
  }
}
