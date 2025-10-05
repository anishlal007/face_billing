import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../models/country/country_response.dart';
import '../models/get_serial_no_model.dart';
import '../models/product/add_product_request.dart';
import '../models/product/product_master_list_model.dart';
import '../models/user_master/add_user_master_model.dart';

import '../models/user_master/user_master_list_model.dart';

class GetSerialNoServices {
  final Dio _dio = ApiClient.dio;
  
 Future<ApiResponse<GetSerialNoModel>> getSerialNo() async {
    try {
      final response = await _dio.get("next-serials");

      final responseData = response.data;

      final countryResponse = GetSerialNoModel.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }



}
