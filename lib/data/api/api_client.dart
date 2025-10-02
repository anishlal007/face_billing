import 'package:dio/dio.dart';

class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://billingapp.captchatime.com/api/",
      // baseUrl: "http://127.0.0.1:8000/api/", //local
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
    ),
  )..interceptors.add(LogInterceptor(responseBody: true)); // log requests
}
