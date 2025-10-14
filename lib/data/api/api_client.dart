import 'dart:io';
import 'package:dio/dio.dart';
import 'package:facebilling/core/app_globals.dart';
import 'package:facebilling/core/const.dart';
import 'package:facebilling/ui/widgets/ErrorPopupWidget.dart';
import 'package:flutter/material.dart';  

class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://billingapp.captchatime.com/api/",
      //baseUrl: "http://127.0.0.1:8000/api/",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      validateStatus: (status) => true, // ✅ prevent Dio from throwing before we handle
    ),
  )..interceptors.addAll([
      LogInterceptor(responseBody: true),
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = globalToken.value;
          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // ✅ Handle Laravel validation errors gracefully
          if (response.statusCode == 422) {
            final data = response.data;
            if (data is Map && data.containsKey('errors')) {
              final errorMessages = (data['errors'] as Map)
                  .values
                  .expand((v) => v as List)
                  .join('\n');
              _showErrorPopup("Validation failed:\n$errorMessages");
            }
          }
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            _handleUnauthorized();
          } else if (e.type == DioExceptionType.connectionTimeout ||
              e.type == DioExceptionType.receiveTimeout ||
              e.type == DioExceptionType.connectionError ||
              e.error is SocketException) {
            _showErrorPopup("No internet or slow connection detected.");
          } else if (e.response?.statusCode == 422) {
            // ✅ Extract and show Laravel validation errors
            final data = e.response?.data;
            if (data is Map && data.containsKey('errors')) {
              final errors = (data['errors'] as Map)
                  .values
                  .expand((v) => v as List)
                  .join('\n');
              _showErrorPopup(errors);
            } else {
              _showErrorPopup("Validation failed. Please check your input.");
            }
          } else if (e.response?.statusCode == 500) {
            _showErrorPopup("Server error. Please try again later.");
          } else {
            _showErrorPopup("Unexpected error: ${e.message}");
          }

          return handler.next(e);
        },
      ),
    ]);

  // 🔹 Handle unauthorized token
  static void _handleUnauthorized() {
    globalToken.value = '';
    _showErrorPopup("Session expired. Please log in again.");
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      '/login',
      (route) => false,
    );
  }

  // 🔹 Show error popup
  static void _showErrorPopup(String message) {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    showDialog(
      context: context,
      builder: (_) => ErrorPopupWidget(
        title: "Error",
        message: message,
        image: "assets/error.png",
      ),
    );
  }
}



// import 'package:dio/dio.dart';
// import 'package:facebilling/core/const.dart';

// class ApiClient {
//   static final Dio dio = Dio(
//     BaseOptions(
//       baseUrl: "http://127.0.0.1:8000/api/", 
//       //  baseUrl: "https://billingapp.captchatime.com/api/",
//       connectTimeout: const Duration(seconds: 10),
//       receiveTimeout: const Duration(seconds: 10),
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json'
//       },
//     ),
//   )..interceptors.addAll([
//       LogInterceptor(responseBody: true),
//       InterceptorsWrapper(
//         onRequest: (options, handler) {
//           // Add token dynamically
//           final token = globalToken.value;
//           if (token != null && token.isNotEmpty) {
//             options.headers["Authorization"] = "Bearer $token";
//           }
//           return handler.next(options);
//         },
//       ),
//     ]);
// }