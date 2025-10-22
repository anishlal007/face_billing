import 'package:facebilling/ui/widgets/Table_Component/models/stock_model.dart';

class ItemAddGridController {
  static Future<List<StockModel>> getItemByKeyword(
      {String? itemCode, String? barCode, String? itemName}) async {
    Map<String, String> body = {};
    body["CompanyID"] = "1";
    if (itemCode != null) {
      body["ItemCode"] = itemCode;
    }
    if (itemName != null) {
      body["ItemName"] = itemName;
    }
    if (barCode != null) {
      body["Barcode_NO"] = barCode;
    }
    List<StockModel> list = [];
    // var f = await ApiHandlers.postRequestHandler(
    //     requestFrom: "Item add grid page",
    //     requestUrl: Endpoints.apiSCANME,
    //     body: body);
    // if (f.status) {
    //   list = stockModelFromJson(f.data);
    // }
    return list;
  }
}
