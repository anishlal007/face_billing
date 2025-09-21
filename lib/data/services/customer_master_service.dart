import 'dart:convert';

import 'package:dio/dio.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../models/country/country_response.dart';
import '../models/customer_master/add_customer_master_model.dart';
import '../models/customer_master/customer_master_list_model.dart';
import '../models/user_master/add_user_master_model.dart';

import '../models/user_master/user_master_list_model.dart';

class CustomerMasterService {
  final Dio _dio = ApiClient.dio;
  
 
  Future<ApiResponse<bool>> addCustomerMaster(AddCustomerMasterModel request) async {
    try {
      final response = await _dio.post("customers", data: request.toJson());
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

  Future<ApiResponse<CustomerMasterListModel>> getSCustomerMaster() async {
    try {
      final response = await _dio.get("customers");

      final responseData = response.data;

      final countryResponse = CustomerMasterListModel.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  Future<ApiResponse<CustomerMasterListModel>> getCustomerMasterSearch(String q) async {
    try {
      final response = await _dio.get("customer/search?q=$q");

      final responseData = response.data;

      final countryResponse = CustomerMasterListModel.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// INFO Country (GET) -> /countrymaster/{id}
  Future<ApiResponse<CustomerMasterListModel>> getCustomerMasterById(String id) async {
    try {
      final response = await _dio.get("customers/$id");
      return ApiResponse(data: CustomerMasterListModel.fromJson(response.data));
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// EDIT Country (PUT) -> /countrymaster
  Future<ApiResponse<bool>> updateCustomerMaster(dynamic id, AddCustomerMasterModel request) async {
    try {
      final response = await _dio.put("customers/$id", data: request.toJson());

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
  Future<ApiResponse<bool>> deleteCustomerMaster(dynamic id) async {
    try {
      await _dio.delete("customers/$id");
      return ApiResponse(data: true);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }
}
