import 'dart:convert';

import 'package:dio/dio.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../models/country/country_response.dart';
import '../models/user_master/add_user_master_model.dart';

import '../models/user_master/user_master_list_model.dart';

class UserMasterService {
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
  Future<ApiResponse<bool>> addUserMaster(AddUserMasterModel request) async {
    try {
      final response = await _dio.post("users", data: request.toJson());
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

  Future<ApiResponse<UserMasterListModel>> getSUserMaster() async {
    try {
      final response = await _dio.get("users");

      final responseData = response.data;

      final countryResponse = UserMasterListModel.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  Future<ApiResponse<UserMasterListModel>> getUserMasterSearch(String q) async {
    try {
      final response = await _dio.get("user/search?q=$q");

      final responseData = response.data;

      final countryResponse = UserMasterListModel.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// INFO Country (GET) -> /countrymaster/{id}
  Future<ApiResponse<UserMasterListModel>> getUserMasterById(String id) async {
    try {
      final response = await _dio.get("users/$id");
      return ApiResponse(data: UserMasterListModel.fromJson(response.data));
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// EDIT Country (PUT) -> /countrymaster
  Future<ApiResponse<bool>> updateUserMaster(dynamic id, AddUserMasterModel request) async {
    try {
      final response = await _dio.put("users/$id", data: request.toJson());

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
  Future<ApiResponse<bool>> deleteUserMaster(dynamic id) async {
    try {
      await _dio.delete("users/$id");
      return ApiResponse(data: true);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }
}
