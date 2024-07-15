import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/login/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  final dio = createDio();

  Api._internal();

  static final Api _instance = Api._internal();

  factory Api() => _instance;

  static Dio createDio() {
    var dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['API_URL']!,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );

    dio.interceptors.add(AppInterceptors());

    return dio;
  }
}

class AppInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AuthService.authKey);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      await AuthService.logout();
      handler.reject(err);
    }
    handler.next(err);
  }
}
