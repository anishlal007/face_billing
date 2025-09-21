import 'dart:convert';

import 'package:dio/dio.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../models/customer_group_master/add_customer_group_master_model.dart';
import '../models/customer_group_master/customer_group_master_list_model.dart';


class CustomerGroupMasterService {
  final Dio _dio = ApiClient.dio;
  
 
  Future<ApiResponse<bool>> addCCustomerGroupMaster(AddCustomerGroupMasterModel request) async {
    try {
      final response = await _dio.post("customergroupmaster", data: request.toJson());
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

  Future<ApiResponse<CustomerGroupMasterModel>> getSCCustomerGroupMaster() async {
    try {
      final response = await _dio.get("customergroupmaster");

      final responseData = response.data;

      final countryResponse = CustomerGroupMasterModel.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  Future<ApiResponse<CustomerGroupMasterModel>> getCCustomerGroupMasterSearch(String q) async {
    try {
      final response = await _dio.get("customer-group/search?q=$q");

      final responseData = response.data;

      final countryResponse = CustomerGroupMasterModel.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// INFO Country (GET) -> /countrymaster/{id}
  Future<ApiResponse<CustomerGroupMasterModel>> getCCustomerGroupMasterById(String id) async {
    try {
      final response = await _dio.get("customergroupmaster/$id");
      return ApiResponse(data: CustomerGroupMasterModel.fromJson(response.data));
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// EDIT Country (PUT) -> /countrymaster
  Future<ApiResponse<bool>> updateCCustomerGroupMaster(dynamic id, AddCustomerGroupMasterModel request) async {
    try {
      final response = await _dio.put("customergroupmaster/$id", data: request.toJson());

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
  Future<ApiResponse<bool>> deleteCCustomerGroupMaster(dynamic id) async {
    try {
      await _dio.delete("customergroupmaster/$id");
      return ApiResponse(data: true);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }
}
