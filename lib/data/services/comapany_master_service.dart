import 'dart:convert';

import 'package:dio/dio.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../models/company_master/add_company_master_model.dart';
import '../models/company_master/company_master_list_model.dart';
import '../models/customer_master/add_customer_master_model.dart';
import '../models/customer_master/customer_master_list_model.dart';


class ComapanyMasterService {
  final Dio _dio = ApiClient.dio;
  
 
  Future<ApiResponse<bool>> addComapanyMaster(AddCompanyMasterModel request) async {
    try {
      final response = await _dio.post("companies", data: request.toJson());
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

  Future<ApiResponse<CompanyMasterListModel>> getSComapanyMaster() async {
    try {
      final response = await _dio.get("companies");

      final responseData = response.data;

      final countryResponse = CompanyMasterListModel.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  Future<ApiResponse<CompanyMasterListModel>> getComapanyMasterSearch(String q) async {
    try {
      final response = await _dio.get("companie/search?q=$q");

      final responseData = response.data;

      final countryResponse = CompanyMasterListModel.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// INFO Country (GET) -> /countrymaster/{id}
  Future<ApiResponse<CompanyMasterListModel>> getComapanyMasterById(String id) async {
    try {
      final response = await _dio.get("companies/$id");
      return ApiResponse(data: CompanyMasterListModel.fromJson(response.data));
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// EDIT Country (PUT) -> /countrymaster
  Future<ApiResponse<bool>> updateComapanyMaster(dynamic id, AddCompanyMasterModel request) async {
    try {
      final response = await _dio.put("companies/$id", data: request.toJson());

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
  Future<ApiResponse<bool>> deleteComapanyMaster(dynamic id) async {
    try {
      await _dio.delete("companies/$id");
      return ApiResponse(data: true);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }
}
