import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ProfileService {
  String? apiUrl = dotenv.env['API_URL'];
  final dio = Dio();

  Future<dynamic> getMe() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('kAuth');
    try {
      final response = await dio.get(
        '$apiUrl/api/users/me',
        options: Options(
          headers: {'Authorization': 'Bearer $token'}
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return null;
      }
    } on DioException {
      return null;
    }
  }

  Future<dynamic> getMeClass() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('kAuth');
    try {
      final response = await dio.get(
        '$apiUrl/api/classes/student',
        options: Options(
          headers: {'Authorization': 'Bearer $token'}
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return null;
      }
    } on DioException {
      return null;
    }
  }

  Future updateProfile(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('kAuth');
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);
    String firstname = decodedToken['user']['firstname'];
    String lastname = decodedToken['user']['lastname'];

    try {
      final response = await dio.put(
        '$apiUrl/api/users/me',
        options: Options(
          headers: {'Authorization': 'Bearer $token'}
        ),
        data: {
          'firstname': firstname,
          'lastname': lastname,
          'email': email,
        }
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return null;
      }
    } on DioException {
      return null;
    }
  }

  Future updateProfilePassword(String oldPassword, String newPassword) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('kAuth');
    try {
      final response = await dio.put(
        '$apiUrl/api/users/me/password',
        options: Options(
          headers: {'Authorization': 'Bearer $token'}
        ),
        data: {
          'old_password': oldPassword,
          'new_password': newPassword,
        }
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return null;
      }
    } on DioException {
      return null;
    }
  }
}