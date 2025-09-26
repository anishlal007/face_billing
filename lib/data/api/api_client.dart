import 'package:dio/dio.dart';

class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl:
          "http://billingapp.captchatime.com/api/", // replace with your backend
      // baseUrl: "http://127.0.0.1:8000/api/", //local
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  )..interceptors.add(LogInterceptor(responseBody: true)); // log requests
}
