import 'dart:convert';

import 'package:dio/dio.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../models/customer_master/add_customer_master_model.dart';
import '../models/customer_master/customer_master_list_model.dart';
import '../models/finance_master/add_finance_year_model.dart' show AddFinanceYearMasterModel;
import '../models/finance_master/finance_year_master_model.dart';


class FinanceYearMasterService {
  final Dio _dio = ApiClient.dio;
  
 
  Future<ApiResponse<bool>> addFinanceYearMaster(AddFinanceYearMasterModel request) async {
    try {
      final response = await _dio.post("financeyear", data: request.toJson());
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

  Future<ApiResponse<FinanceYearMasterListModel>> getSFinanceYearMaster() async {
    try {
      final response = await _dio.get("financeyear");

      final responseData = response.data;

      final countryResponse = FinanceYearMasterListModel.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  Future<ApiResponse<FinanceYearMasterListModel>> getFinanceYearMasterSearch(String q) async {
    try {
      final response = await _dio.get("financeyear/search?q=$q");

      final responseData = response.data;

      final countryResponse = FinanceYearMasterListModel.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// INFO Country (GET) -> /countrymaster/{id}
  Future<ApiResponse<FinanceYearMasterListModel>> getFinanceYearMasterById(String id) async {
    try {
      final response = await _dio.get("financeyear/$id");
      return ApiResponse(data: FinanceYearMasterListModel.fromJson(response.data));
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// EDIT Country (PUT) -> /countrymaster
  Future<ApiResponse<bool>> updateFinanceYearMaster(dynamic id, AddFinanceYearMasterModel request) async {
    try {
      final response = await _dio.put("financeyear/$id", data: request.toJson());

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
  Future<ApiResponse<bool>> deleteFinanceYearMaster(dynamic id) async {
    try {
      await _dio.delete("financeyear/$id");
      return ApiResponse(data: true);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }
}
