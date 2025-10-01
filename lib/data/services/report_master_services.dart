import 'dart:convert';

import 'package:dio/dio.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../models/country/country_response.dart';
import '../models/get_all_master_list_model.dart';
import '../models/get_report_master_model.dart';
import '../models/product/add_product_request.dart';
import '../models/product/product_master_list_model.dart';


class ReportMasterServices {
  final Dio _dio = ApiClient.dio;

Future<ApiResponse<GetReportMasterModel>> getReportService({
  String? purchaseNo,
  String? purchaseDate,
  String? supplierInvoiceNo,
  String? supplierId,
  String? supplierName,
  String? purchaseValue,
}) async {
  try {
    final response = await _dio.get(
      "purchase-filter",
      queryParameters: {
        if (purchaseNo != null && purchaseNo.isNotEmpty) "PurchaseNo": purchaseNo,
        if (purchaseDate != null && purchaseDate.isNotEmpty) "PurchaseDate": purchaseDate,
        if (supplierInvoiceNo != null && supplierInvoiceNo.isNotEmpty) "InvoiceNo": supplierInvoiceNo,
        if (supplierId != null && supplierId.isNotEmpty) "SupCode": supplierId,
        if (supplierName != null && supplierName.isNotEmpty) "SupName": supplierName,
        if (purchaseValue != null && purchaseValue.isNotEmpty) "PurchaseNetAmount": purchaseValue,
      },
    );

    final responseData = response.data;
    final countryResponse = GetReportMasterModel.fromJson(responseData);

    return ApiResponse(data: countryResponse);
  } catch (e) {
    return ApiResponse(error: e.toString());
  }
}

  // Future<ApiResponse<ProductMasterListModel>> getProductServiceSearch(String q) async {
  //   try {
  //     final response = await _dio.get("item/search?q=$q");

  //     final responseData = response.data;

  //     final countryResponse = ProductMasterListModel.fromJson(responseData);

  //     return ApiResponse(data: countryResponse);
  //   } catch (e) {
  //     return ApiResponse(error: e.toString());
  //   }
  // }

  // /// INFO Country (GET) -> /countrymaster/{id}
  // Future<ApiResponse<ProductMasterListModel>> getProductServiceById(String id) async {
  //   try {
  //     final response = await _dio.get("products/$id");
  //     return ApiResponse(data: ProductMasterListModel.fromJson(response.data));
  //   } catch (e) {
  //     return ApiResponse(error: e.toString());
  //   }
  // }

  // /// EDIT Country (PUT) -> /countrymaster
  // Future<ApiResponse<bool>> updateProductService(dynamic id, AddProductMasterModel request) async {
  //   try {
  //     final response = await _dio.put("products/$id", data: request.toJson());

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return ApiResponse(data: true);
  //     } else {
  //       return ApiResponse(error: "Failed to update country");
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     return ApiResponse(error: e.toString());
  //   }
  // }

  // /// DELETE Country (DELETE) -> /countrymaster
  // Future<ApiResponse<bool>> deleteProductService(dynamic id) async {
  //   try {
  //     await _dio.delete("products/$id");
  //     return ApiResponse(data: true);
  //   } catch (e) {
  //     return ApiResponse(error: e.toString());
  //   }
  // }

}
