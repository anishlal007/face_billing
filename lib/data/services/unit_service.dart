import 'package:dio/dio.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../models/unit/add_unit_request.dart';
import '../models/unit/unit_response.dart';

class UnitService {
  final Dio _dio = ApiClient.dio;

  Future<ApiResponse<bool>> addUnit(AddUnitRequest request) async {
    try {
      final response = await _dio.post("unitmaster", data: request.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(data: true);
      } else {
        return ApiResponse(error: "Failed to add Unit");
      }
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  Future<ApiResponse<UnitResponse>> getUnit() async {
    try {
      final response = await _dio.get("unitmaster");

      final responseData = response.data;

      final countryResponse = UnitResponse.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  Future<ApiResponse<UnitResponse>> getUnitSearch(String q) async {
    try {
      final response = await _dio.get("unit/search?q=$q");

      final responseData = response.data;

      final countryResponse = UnitResponse.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// INFO Country (GET) -> /countrymaster/{id}
  Future<ApiResponse<UnitResponse>> getUnitById(String id) async {
    try {
      final response = await _dio.get("unitmaster/$id");
      return ApiResponse(data: UnitResponse.fromJson(response.data));
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// EDIT Country (PUT) -> /countrymaster
  Future<ApiResponse<bool>> updateUnit(int id, AddUnitRequest request) async {
    try {
      final response = await _dio.put("unitmaster/$id", data: request.toJson());

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
  Future<ApiResponse<bool>> deleteUnit(int id) async {
    try {
      await _dio.delete("unitmaster/$id");
      return ApiResponse(data: true);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }
}
