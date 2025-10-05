
import 'package:dio/dio.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../models/area_master/add_area_master_model.dart';
import '../models/get_dashboard_detail_model.dart';

class DashboardService {
  final Dio _dio = ApiClient.dio;
  


  Future<ApiResponse<GetDashboardDetailModel>> getDashboardDeatisl() async {
    try {
      final response = await _dio.get("dashboard");

      final responseData = response.data;

      final countryResponse = GetDashboardDetailModel.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }


}
