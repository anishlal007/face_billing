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
  

  Future<ApiResponse<bool>> addSupplierMaster(AddSupplierMasterModel request) async {
    try {
      final response = await _dio.post("suppliers", data: request.toJson());
print("Sending JSON: ${jsonEncode(request.toJson())}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(data: true);
      } else {
        return ApiResponse(error: "Failed to add Loction");
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

  Future<ApiResponse<SupplierMasterListModel>> getSupplierMasterSearch(String q) async {
    try {
      final response = await _dio.get("supplier/search?q=$q");

      final responseData = response.data;

      final countryResponse = SupplierMasterListModel.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// INFO Country (GET) -> /countrymaster/{id}
  Future<ApiResponse<SupplierMasterListModel>> getSupplierMasterById(String id) async {
    try {
      final response = await _dio.get("suppliers/$id");
      return ApiResponse(data: SupplierMasterListModel.fromJson(response.data));
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// EDIT Country (PUT) -> /countrymaster
  Future<ApiResponse<bool>> updateSupplierMasterr(dynamic id, AddSupplierMasterModel request) async {
    try {
      final response = await _dio.put("suppliers/$id", data: request.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(data: true);
      } else {
        return ApiResponse(error: "Failed to update country");
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
