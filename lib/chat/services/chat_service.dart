import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mobile/core/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:mobile/globals.dart' as globals;

class ChatService {
  final dio = Api().dio;

  Future<List<dynamic>?> getChannels() async {
    try {
      final response = await dio.get(
        '/api/chats/channel',
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
    try {
      final response = await dio.get(
        '/api/chats/channel/$id',
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
    try {
      final response = await dio.get(
        '/api/chats/students',
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
    try {
      final response = await dio.get(
        '/api/chats/teachers',
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
      final response = await dio.post('/api/chats/channel', data: {
        'firstUserId': decodedToken['user']['id'],
        'secondUserId': studentId,
      });

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
