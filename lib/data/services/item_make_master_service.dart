import 'dart:convert';

import 'package:dio/dio.dart';

import '../api/api_client.dart';
import '../api/api_list.dart';
import '../api/api_response.dart';
import '../models/item_make/item_make_list_master_model.dart';
import '../models/unit/add_item_make_unit_model.dart';
import '../models/unit/add_location_master_req.dart';

class ItemMakeMasterService {
  final Dio _dio = ApiClient.dio;

  Future<ApiResponse<bool>> addItemMakeMaster(AddItemMakeUnit request) async {
    try {
      final response = await _dio.post("itemmakemaster", data: request.toJson());
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

  Future<ApiResponse<ItemMakeMasterListModel>> getItemMakeMaster() async {
    try {
      final response = await _dio.get("itemmakemaster");

      final responseData = response.data;

      final countryResponse = ItemMakeMasterListModel.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  Future<ApiResponse<ItemMakeMasterListModel>> getItemMakeMasterSearch(String q) async {
    try {
      final response = await _dio.get("item-make/search?q=$q");

      final responseData = response.data;

      final countryResponse = ItemMakeMasterListModel.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// INFO Country (GET) -> /countrymaster/{id}
  Future<ApiResponse<ItemMakeMasterListModel>> getItemMakeMasterById(String id) async {
    try {
      final response = await _dio.get("itemmakemaster/$id");
      return ApiResponse(data: ItemMakeMasterListModel.fromJson(response.data));
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// EDIT Country (PUT) -> /countrymaster
  Future<ApiResponse<bool>> updateItemMakeMaster(int id, AddItemMakeUnit request) async {
    try {
      final response = await _dio.put("itemmakemaster/$id", data: request.toJson());

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
  Future<ApiResponse<bool>> deleteItemMakeMaster(int id) async {
    try {
      await _dio.delete("itemmakemaster/$id");
      return ApiResponse(data: true);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }
}
