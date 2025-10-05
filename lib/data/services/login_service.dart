import 'dart:convert';
import 'package:dio/dio.dart';
import '../api/api_client.dart';
import '../api/api_response.dart';
import '../models/login_model.dart'; // import your model

class LoginService {
  final Dio _dio = ApiClient.dio;

  Future<ApiResponse<LoginModel>> login({
    required String userId,
    required String userPassword,
  }) async {
    try {
      final data = {
        "UserId": userId,
        "UserPassword": userPassword,
      };

      print("Sending JSON: ${jsonEncode(data)}");

      final response = await _dio.post(
        "login",
        data: jsonEncode(data), // encode JSON
       // options: Options(headers: {"Content-Type": "application/json"}),
      );

      print("Response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse JSON to LoginModel
        final loginModel = LoginModel.fromJson(response.data);
        return ApiResponse(data: loginModel);
      } else {
        return ApiResponse(
          error: "Login failed with status code ${response.statusCode}",
        );
      }
    } catch (e) {
      print("Login error: $e");
      return ApiResponse(error: e.toString());
    }
  }
}