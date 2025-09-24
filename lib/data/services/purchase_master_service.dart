import 'dart:convert';

import 'package:dio/dio.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../models/country/country_response.dart';
import '../models/product/add_product_request.dart';
import '../models/product/product_master_list_model.dart';
import '../models/purchase_model/add_purchase_master_model.dart';
import '../models/purchase_model/purchase_list_model.dart';
import '../models/user_master/add_user_master_model.dart';

import '../models/user_master/user_master_list_model.dart';

class PurchaseMasterService {
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
  Future<ApiResponse<bool>> addPurchaseMaster(AddPurchaseMasterModel request) async {
    try {
      final response = await _dio.post("products", data: request.toJson());
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

  Future<ApiResponse<PurchaseMasterListModel>> getSPurchaseMaster() async {
    try {
      final response = await _dio.get("products");

      final responseData = response.data;

      final countryResponse = PurchaseMasterListModel.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  Future<ApiResponse<PurchaseMasterListModel>> getPurchaseMasterSearch(String q) async {
    try {
      final response = await _dio.get("item/search?q=$q");

      final responseData = response.data;

      final countryResponse = PurchaseMasterListModel.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// INFO Country (GET) -> /countrymaster/{id}
  Future<ApiResponse<PurchaseMasterListModel>> getPurchaseMasterById(String id) async {
    try {
      final response = await _dio.get("products/$id");
      return ApiResponse(data: PurchaseMasterListModel.fromJson(response.data));
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// EDIT Country (PUT) -> /countrymaster
  Future<ApiResponse<bool>> updatePurchaseMaster(dynamic id, AddPurchaseMasterModel request) async {
    try {
      final response = await _dio.put("products/$id", data: request.toJson());

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
  Future<ApiResponse<bool>> deletePurchaseMaster(dynamic id) async {
    try {
      await _dio.delete("products/$id");
      return ApiResponse(data: true);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }
}
