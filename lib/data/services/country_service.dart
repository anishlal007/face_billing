import 'package:dio/dio.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../models/country/add_country_request.dart';
import '../models/country/country_response.dart';

class CountryService {
  final Dio _dio = ApiClient.dio;

  /// ADD Country (POST) -> /countrymaster
  Future<ApiResponse<bool>> addCountry(AddCountryRequest request) async {
    try {
      final response = await _dio.post("countrymaster", data: request.toJson());

      // Assume API returns success status
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(data: true);
      } else {
        return ApiResponse(error: "Failed to add country");
      }
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// LIST Countries (GET) -> /countrymaster
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

  /// Search Countries (GET) -> /countrymaster
  Future<ApiResponse<Country>> getCountriesSearch(String q) async {
    try {
      final response = await _dio.get("countries/search?q=$q");

      final responseData = response.data;

      final countryResponse = Country.fromJson(responseData);

      return ApiResponse(data: countryResponse);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// INFO Country (GET) -> /countrymaster/{id}
  Future<ApiResponse<Country>> getCountryById(String id) async {
    try {
      final response = await _dio.get("countrymaster/$id");
      return ApiResponse(data: Country.fromJson(response.data));
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  /// EDIT Country (PUT) -> /countrymaster
  Future<ApiResponse<bool>> updateCountry(
      int id, AddCountryRequest request) async {
    try {
      final response =
          await _dio.put("countrymaster/$id", data: request.toJson());

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
  Future<ApiResponse<bool>> deleteCountry(int id) async {
    print("countrymaster/$id");
    try {
      await _dio.delete("countrymaster/$id");
      return ApiResponse(data: true);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }
}
