import 'dart:convert';

import 'package:dio/dio.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../models/country/country_response.dart';
import '../models/hns_master/add_hns_model.dart';
import '../models/state_master/add_state_master_model.dart';
import '../models/state_master/state_master_list_model.dart';
import '../models/supplier_group_master/add_spplier_group_model.dart';
import '../models/supplier_group_master/supplier_group_master_list_model.dart';
import '../models/supplier_master/add_supplier_master_model.dart';
import '../models/supplier_master/supplier_master_list_model.dart';

class SupplierGroupMasterService {
  final Dio _dio = ApiClient.dio;
  

  Future<ApiResponse<bool>> addSupplierGroupMaster(AddSupplierGroupMasterModel request) async {
    try {
      final response = await _dio.post("suppliergroupmaster", data: request.toJson());
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

  Future<ApiResponse<SupplierGroupMasterListModel>> getSupplierGroupMaster() async {
    try {
      final response = await _dio.get("suppliergroupmaster");

      final responseData = response.data;

      final countryResponse = SupplierGroupMasterListModel.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  Future<ApiResponse<SupplierGroupMasterListModel>> getSupplierGroupMasterSearch(String q) async {
    try {
      final response = await _dio.get("supplier-group/search?q=$q");

      final responseData = response.data;

      final countryResponse = SupplierGroupMasterListModel.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// INFO Country (GET) -> /countrymaster/{id}
  Future<ApiResponse<SupplierGroupMasterListModel>> getSupplierGroupMasterById(String id) async {
    try {
      final response = await _dio.get("suppliergroupmaster/$id");
      return ApiResponse(data: SupplierGroupMasterListModel.fromJson(response.data));
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// EDIT Country (PUT) -> /countrymaster
  Future<ApiResponse<bool>> updateSupplierGroupMasterr(dynamic id, AddSupplierGroupMasterModel request) async {
    try {
      final response = await _dio.put("suppliergroupmaster/$id", data: request.toJson());

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
  Future<ApiResponse<bool>> deleteSupplierGroupMaster(dynamic id) async {
    try {
      await _dio.delete("suppliergroupmaster/$id");
      return ApiResponse(data: true);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }
}
