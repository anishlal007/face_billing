import 'dart:convert';

import 'package:dio/dio.dart';

import '../api/api_client.dart';
import '../api/api_list.dart';
import '../api/api_response.dart';
import '../models/location_master_model/location_master_list_model.dart';
import '../models/unit/add_location_master_req.dart';
import '../models/unit/add_unit_request.dart';
import '../models/unit/unit_response.dart';

class LocationMasterService {
  final Dio _dio = ApiClient.dio;

  Future<ApiResponse<bool>> addLocationMaster(AddLocationMasterReq request) async {
    try {
      final response = await _dio.post("itemlocationmaster", data: request.toJson());
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

  Future<ApiResponse<ItemLocationMasterList>> getLocationMaster() async {
    try {
      final response = await _dio.get(Httpurl.itemLocationMaster);

      final responseData = response.data;

      final countryResponse = ItemLocationMasterList.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  Future<ApiResponse<ItemLocationMasterList>> getLocationMasterSearch(String q) async {
    try {
      final response = await _dio.get("item-location/search?q=$q");

      final responseData = response.data;

      final countryResponse = ItemLocationMasterList.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// INFO Country (GET) -> /countrymaster/{id}
  Future<ApiResponse<ItemLocationMasterList>> getLocationMasterById(String id) async {
    try {
      final response = await _dio.get("itemlocationmaster/$id");
      return ApiResponse(data: ItemLocationMasterList.fromJson(response.data));
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// EDIT Country (PUT) -> /countrymaster
  Future<ApiResponse<bool>> updateLocationMaster(dynamic id, AddLocationMasterReq request) async {
    try {
      final response = await _dio.put("itemlocationmaster/$id", data: request.toJson());

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
  Future<ApiResponse<bool>> deleteLocationMaster(int id) async {
    try {
      await _dio.delete("itemlocationmaster/$id");
      return ApiResponse(data: true);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }
}
