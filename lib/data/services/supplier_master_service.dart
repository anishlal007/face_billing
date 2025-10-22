import 'dart:convert';

import 'package:dio/dio.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../models/country/country_response.dart';
import '../models/hns_master/add_hns_model.dart';
import '../models/state_master/add_state_master_model.dart';
import '../models/state_master/state_master_list_model.dart';
import '../models/supplier_master/add_supplier_master_model.dart';
import '../models/supplier_master/supplier_master_list_model.dart';

class SupplierMasterService {
  final Dio _dio = ApiClient.dio;

  Future<ApiResponse<bool>> addSupplierMaster(
      AddSupplierMasterModel request) async {
    try {
      final response = await _dio.post("suppliers", data: request.toJson());
      print("Sending JSON: ${jsonEncode(request.toJson())}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(data: true);
      } else {
        return ApiResponse(error: "Failed to add Supplier");
      }
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  Future<ApiResponse<SupplierMasterListModel>> getSupplierMaster() async {
    try {
      final response = await _dio.get("suppliers");

      final responseData = response.data;

      final countryResponse = SupplierMasterListModel.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  // Future<ApiResponse<SupplierMasterListModel>> getSupplierMasterSearch(String q) async {
  //   try {
  //     final response = await _dio.get("supplier/search?q=$q");

  //     final responseData = response.data;

  //     final countryResponse = SupplierMasterListModel.fromJson(responseData);

  //     return ApiResponse(data: countryResponse);
  //   } catch (e) {
  //     return ApiResponse(error: e.toString());
  //   }
  // }

  Future<ApiResponse<SupplierMasterListModel>> getSupplierMasterSearch(
      String q) async {
    try {
      final response = await _dio.get("supplier/search?q=$q");

      // ✅ Print the raw response
      print("===== Raw API Response =====");
      print(response.data);

      // Make sure response data is not null
      final responseData = response.data;
      if (responseData == null) {
        print("Response data is null!");
        return ApiResponse(error: "Response data is null");
      }

      // ✅ Print responseData type
      print("Response type: ${responseData.runtimeType}");

      // Parse to your model
      final productResponse = SupplierMasterListModel.fromJson(responseData);

      // ✅ Print parsed info list
      print("Parsed Info list length: ${productResponse.info?.length}");
      if (productResponse.info != null) {
        for (var item in productResponse.info!) {
          print("Item: ${item.supName}, Code: ${item.supCode}");
        }
      }

      return ApiResponse(data: productResponse);
    } catch (e) {
      print("Error in getProductServiceSearch: $e");
      return ApiResponse(error: e.toString());
    }
  }

  /// INFO Country (GET) -> /countrymaster/{id}
  Future<ApiResponse<SupplierMasterListModel>> getSupplierMasterById(
      String id) async {
    try {
      final response = await _dio.get("suppliers/$id");
      return ApiResponse(data: SupplierMasterListModel.fromJson(response.data));
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// EDIT Country (PUT) -> /countrymaster
  Future<ApiResponse<bool>> updateSupplierMasterr(
      dynamic id, AddSupplierMasterModel request) async {
    try {
      final response = await _dio.put("suppliers/$id", data: request.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(data: true);
      } else {
        return ApiResponse(error: "Failed to update Supplier");
      }
    } catch (e) {
      print(e.toString());
      return ApiResponse(error: e.toString());
    }
  }

  /// DELETE Country (DELETE) -> /countrymaster
  Future<ApiResponse<bool>> deleteSupplierMaster(dynamic id) async {
    try {
      await _dio.delete("suppliers/$id");
      return ApiResponse(data: true);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }
}
