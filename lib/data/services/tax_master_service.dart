import 'dart:convert';

import 'package:dio/dio.dart';

import '../api/api_client.dart';
import '../api/api_list.dart';
import '../api/api_response.dart';
import '../models/location_master_model/location_master_list_model.dart';
import '../models/tax_master/tax_master_list_model.dart';
import '../models/unit/add_location_master_req.dart';
import '../models/unit/add_tax_unit_model.dart';
import '../models/unit/add_unit_request.dart';
import '../models/unit/unit_response.dart';

class TaxMasterService {
  final Dio _dio = ApiClient.dio;

  Future<ApiResponse<bool>> addTaxMaster(AddTaxModelReq request) async {
    try {
      final response = await _dio.post("taxmaster", data: request.toJson());
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

  Future<ApiResponse<TaxMasterListModel>> getTaxMaster() async {
    try {
      final response = await _dio.get("taxmaster");

      final responseData = response.data;

      final countryResponse = TaxMasterListModel.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  Future<ApiResponse<TaxMasterListModel>> getTaxMasterSearch(String q) async {
    try {
      final response = await _dio.get("tax/search?q=$q");

      final responseData = response.data;

      final countryResponse = TaxMasterListModel.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// INFO Country (GET) -> /countrymaster/{id}
  Future<ApiResponse<TaxMasterListModel>> getTaxMasterById(String id) async {
    try {
      final response = await _dio.get("taxmaster/$id");
      return ApiResponse(data: TaxMasterListModel.fromJson(response.data));
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// EDIT Country (PUT) -> /countrymaster
  Future<ApiResponse<bool>> updateTaxMaster(int id, AddTaxModelReq request) async {
    try {
      final response = await _dio.put("taxmaster/$id", data: request.toJson());

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
  Future<ApiResponse<bool>> deleteTaxMaster(dynamic id) async {
    try {
      await _dio.delete("taxmaster/$id");
      return ApiResponse(data: true);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }
}
