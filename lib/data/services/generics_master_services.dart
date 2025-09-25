import 'package:dio/dio.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../models/generics_master/add_generics_master_model.dart';
import '../models/generics_master/generics_master_list_model.dart';
import '../models/item_group/add_group_request.dart';
import '../models/item_group/item_group_response.dart';

class GenericsMasterServices {
  final Dio _dio = ApiClient.dio;

  Future<ApiResponse<bool>> addGenericsMaster(AddGenericsMasterModel request) async {
    try {
      final response =
          await _dio.post("generics", data: request.toJson());

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

  Future<ApiResponse<GenericsMasterListModel>> getGenericsMaster() async {
    try {
      final response = await _dio.get("generics");

      final responseData = response.data;

      final groupResponse = GenericsMasterListModel.fromJson(responseData);

      return ApiResponse(data: groupResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  Future<ApiResponse<GenericsMasterListModel>> getGenericsMasterSearch(String q) async {
    print("generic/search?q=$q");
    try {
      final response = await _dio.get("GenericsMaster/search?q=$q");

      final responseData = response.data;

      final groupResponse = GenericsMasterListModel.fromJson(responseData);

      return ApiResponse(data: groupResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  Future<ApiResponse<GenericsMasterListModel>> getGenericsMasterById(String id) async {
    try {
      final response = await _dio.get("generics/$id");
      return ApiResponse(data: GenericsMasterListModel.fromJson(response.data));
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  Future<ApiResponse<bool>> updateGenericsMaster(
      int id, AddGenericsMasterModel request) async {
    try {
      final response =
          await _dio.put("generics/$id", data: request.toJson());

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

  Future<ApiResponse<bool>> deleteGenericsMaster(int id) async {
    try {
      await _dio.delete("generics/$id");
      return ApiResponse(data: true);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }
}
