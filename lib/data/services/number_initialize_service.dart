import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:facebilling/data/models/number_initialize/NumberInitializationResponse.dart';
import 'package:facebilling/data/models/number_initialize/add_number_initlize_model.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../models/area_master/add_area_master_model.dart';
import '../models/area_master/area_master_list_model.dart';
import '../models/country/country_response.dart';
import '../models/user_master/add_user_master_model.dart';

import '../models/user_master/user_master_list_model.dart';

class NumberInitializeService {
  final Dio _dio = ApiClient.dio;

  Future<ApiResponse<bool>> addNumberInitialize(
      AddNumberInitializeModel request) async {
    try {
      final response =
          await _dio.post("numberinitialize", data: request.toJson());
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

  Future<ApiResponse<NumberSerilizationResponse>> getNumberInitialize() async {
    try {
      final response = await _dio.get("numberinitialize");

      final responseData = response.data;
      print(response.data.toString());
      final countryResponse = NumberSerilizationResponse.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  Future<ApiResponse<AreaMasterListModel>> getAreaMasterSearch(String q) async {
    try {
      final response = await _dio.get("area/search?q=$q");

      final responseData = response.data;

      final countryResponse = AreaMasterListModel.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// INFO Country (GET) -> /countrymaster/{id}
  Future<ApiResponse<AreaMasterListModel>> getAreaMasterById(String id) async {
    try {
      final response = await _dio.get("areamaster/$id");
      return ApiResponse(data: AreaMasterListModel.fromJson(response.data));
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// EDIT Country (PUT) -> /countrymaster
  Future<ApiResponse<bool>> updateNumberiitialize(
      dynamic id, AddNumberInitializeModel request) async {
    try {
      final response =
          await _dio.put("numberinitialize/$id", data: request.toJson());

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
  Future<ApiResponse<bool>> deleteAreaMaster(dynamic id) async {
    try {
      await _dio.delete("areamaster/$id");
      return ApiResponse(data: true);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }
}
