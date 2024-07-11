import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:mobile/globals.dart' as globals;

class ChatService {
  final dio = Dio();

  Future<List<dynamic>?> getChannels() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('kAuth');
    try {
      final response = await dio.get(
        '${globals.apiUrl}/api/chats/channel',
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

  Future<dynamic> getChannelById(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('kAuth');
    try {
      final response = await dio.get(
        '${globals.apiUrl}/api/chats/channel/$id',
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

  Future<List<dynamic>?> getStudents() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('kAuth');
    try {
      final response = await dio.get(
        '${globals.apiUrl}/api/chats/students',
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

  Future<List<dynamic>?> getTeachers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('kAuth');
    try {
      final response = await dio.get(
        '${globals.apiUrl}/api/chats/teachers',
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

  Future addChannel(int studentId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('kAuth');
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);
    try {
      final response = await dio.post(
        '${globals.apiUrl}/api/chats/channel',
        options: Options(
          headers: {'Authorization': 'Bearer $token'}
        ),
        data: {
          'firstUserId': decodedToken['user']['id'],
          'secondUserId': studentId,
        }
      );

      if (response.statusCode == 201) {
        return response.data;
      } else {
        return null;
      }
    } on DioException {
      return null;
    }
  }
}