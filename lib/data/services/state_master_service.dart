import 'dart:convert';

import 'package:dio/dio.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../models/country/country_response.dart';
import '../models/hns_master/add_hns_model.dart';
import '../models/state_master/add_state_master_model.dart';
import '../models/state_master/state_master_list_model.dart';

class StateMasterService {
  final Dio _dio = ApiClient.dio;


  Future<ApiResponse<Country>> getCountries() async {
    try {
      final response = await _dio.get("countrymaster");

      final responseData = response.data;

      final countryResponse = Country.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }
  Future<ApiResponse<bool>> addStateMaster(AddStateModel request) async {
    try {
      final response = await _dio.post("statemaster", data: request.toJson());
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

  Future<ApiResponse<StateMasterListModel>> getStateMaster() async {
    try {
      final response = await _dio.get("statemaster");

      final responseData = response.data;

      final countryResponse = StateMasterListModel.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  Future<ApiResponse<StateMasterListModel>> getStateMasterSearch(String q) async {
    try {
      final response = await _dio.get("state/search?q=$q");

      final responseData = response.data;

      final countryResponse = StateMasterListModel.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// INFO Country (GET) -> /countrymaster/{id}
  Future<ApiResponse<StateMasterListModel>> getStateMasterById(String id) async {
    try {
      final response = await _dio.get("statemaster/$id");
      return ApiResponse(data: StateMasterListModel.fromJson(response.data));
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// EDIT Country (PUT) -> /countrymaster
  Future<ApiResponse<bool>> updateStateMasterr(dynamic id, AddStateModel request) async {
    try {
      final response = await _dio.put("statemaster/$id", data: request.toJson());

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
  Future<ApiResponse<bool>> deleteStateMaster(dynamic id) async {
    try {
      await _dio.delete("statemaster/$id");
      return ApiResponse(data: true);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }
}
