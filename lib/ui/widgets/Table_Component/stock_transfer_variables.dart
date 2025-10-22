import 'package:flutter/material.dart';

int currentRow = 0;

class StockItemsTextEditController {
  TextEditingController slNoControl = TextEditingController(text: "");
  TextEditingController itemCodeControl = TextEditingController(text: "");
  TextEditingController barcodeControl = TextEditingController(text: "");
  TextEditingController itemNameControl = TextEditingController(text: "");
  TextEditingController uomControl = TextEditingController(text: "");
  TextEditingController qtyControl = TextEditingController(text: "");
  TextEditingController rateControl = TextEditingController(text: "");
  TextEditingController costrateControl = TextEditingController(text: "");
  TextEditingController grossAmountControl = TextEditingController(text: "");
  TextEditingController netAmountControl = TextEditingController(text: "");
  TextEditingController vatAmountControl = TextEditingController(text: "");
  double costRate = 0.0;
  TextEditingController assignController(String field) {
    print(field);
    if (field == "sl_no") {
      return slNoControl;
    } else if (field == "item_code") {
      return itemCodeControl;
    } else if (field == "barcode_no") {
      return barcodeControl;
    } else if (field == "item_name") {
      return itemNameControl;
    } else if (field == "uom") {
      return uomControl;
    } else if (field == "qty") {
      return qtyControl;
    } else if (field == "rate") {
      return rateControl;
    } else if (field == "cost_rate") {
      return costrateControl;
    } else if (field == "gross_amount") {
      return grossAmountControl;
    } else if (field == "net_amount") {
      return netAmountControl;
    } else if (field == "vat_amount") {
      return vatAmountControl;
    } else {
      return TextEditingController();
    }
  }
}
