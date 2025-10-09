import 'package:dio/dio.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../models/item_group/add_group_request.dart';
import '../models/item_group/item_group_response.dart';

class ItemGroupService {
  final Dio _dio = ApiClient.dio;

  Future<ApiResponse<bool>> addItemGroup(AddGroupRequest request) async {
    try {
      
      final response =
          await _dio.post("itemgroupmaster", data: request.toJson());

      // Assume API returns success status
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(data: true);
      } else {
        return ApiResponse(error: "Failed to add Group");
      }
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  Future<ApiResponse<ItemGroupResponse>> getItemGroup() async {
    try {
      final response = await _dio.get("itemgroupmaster");

      final responseData = response.data;

      final groupResponse = ItemGroupResponse.fromJson(responseData);

      return ApiResponse(data: groupResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  Future<ApiResponse<ItemGroupResponse>> getItemGroupSearch(String q) async {
    print("itemgroup/search?q=$q");
    try {
      final response = await _dio.get("itemgroup/search?q=$q");

      final responseData = response.data;

      final groupResponse = ItemGroupResponse.fromJson(responseData);

      return ApiResponse(data: groupResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  Future<ApiResponse<ItemGroupResponse>> getItemGroupById(String id) async {
    try {
      final response = await _dio.get("itemgroupmaster/$id");
      return ApiResponse(data: ItemGroupResponse.fromJson(response.data));
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  Future<ApiResponse<bool>> updateItemGroup(
      int id, AddGroupRequest request) async {
    try {
      final response =
          await _dio.put("itemgroupmaster/$id", data: request.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(data: true);
      } else {
        return ApiResponse(error: "Failed to update Item Group");
      }
    } catch (e) {
      print(e.toString());
      return ApiResponse(error: e.toString());
    }
  }

  Future<ApiResponse<bool>> deleteItemGroup(int id) async {
    try {
      await _dio.delete("itemgroupmaster/$id");
      return ApiResponse(data: true);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }
}
