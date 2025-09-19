import 'dart:convert';

import 'package:dio/dio.dart';

import '../api/api_client.dart';
import '../api/api_list.dart';
import '../api/api_response.dart';
import '../models/hns_master/add_hns_model.dart';
import '../models/hns_master/hns_master_list_model.dart';
import '../models/location_master_model/location_master_list_model.dart';
import '../models/tax_master/tax_master_list_model.dart';
import '../models/unit/add_location_master_req.dart';
import '../models/unit/add_tax_unit_model.dart';
import '../models/unit/add_unit_request.dart';
import '../models/unit/unit_response.dart';

class HnsMasterService {
  final Dio _dio = ApiClient.dio;

  Future<ApiResponse<bool>> addHnsMasterr(AddHnsModel request) async {
    try {
      final response = await _dio.post("hsnmaster", data: request.toJson());
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

  Future<ApiResponse<HnsMasterListModel>> getHnsMaster() async {
    try {
      final response = await _dio.get("hsnmaster");

      final responseData = response.data;

      final countryResponse = HnsMasterListModel.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  Future<ApiResponse<HnsMasterListModel>> getHnsMasterSearch(String q) async {
    try {
      final response = await _dio.get("hsn/search?q=$q");

      final responseData = response.data;

      final countryResponse = HnsMasterListModel.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// INFO Country (GET) -> /countrymaster/{id}
  Future<ApiResponse<HnsMasterListModel>> getHnsMasterById(String id) async {
    try {
      final response = await _dio.get("hsnmaster/$id");
      return ApiResponse(data: HnsMasterListModel.fromJson(response.data));
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// EDIT Country (PUT) -> /countrymaster
  Future<ApiResponse<bool>> updateHnsMasterr(int id, AddHnsModel request) async {
    try {
      final response = await _dio.put("hsnmaster/$id", data: request.toJson());

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
  Future<ApiResponse<bool>> deleteHnsMaster(dynamic id) async {
    try {
      await _dio.delete("hsnmaster/$id");
      return ApiResponse(data: true);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }
}
