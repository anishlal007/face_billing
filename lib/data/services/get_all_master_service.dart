import 'dart:convert';

import 'package:dio/dio.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../models/country/country_response.dart';
import '../models/customer_master/add_customer_master_model.dart';
import '../models/customer_master/customer_master_list_model.dart';
import '../models/get_all_master_list_model.dart';
import '../models/user_master/add_user_master_model.dart';

import '../models/user_master/user_master_list_model.dart';

class GetAllMasterService {
  final Dio _dio = ApiClient.dio;
  
 


  Future<ApiResponse<GetAllMasterListModel>> getAllMasterService() async {
    try {
      final response = await _dio.get("all-masters");

      final responseData = response.data;

      final countryResponse = GetAllMasterListModel.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

 
}
