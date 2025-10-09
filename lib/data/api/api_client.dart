import 'package:dio/dio.dart';
import 'package:facebilling/core/const.dart';

class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://billingapp.captchatime.com/api/",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
    ),
  )..interceptors.addAll([
      LogInterceptor(responseBody: true),
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add token dynamically
          final token = globalToken.value;
          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },
      ),
    ]);
}