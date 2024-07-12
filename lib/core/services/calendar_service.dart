import 'package:dio/dio.dart';
import 'package:flinq/flinq.dart';
import 'package:mobile/core/models/schedule.dart';
import 'package:mobile/core/services/api.dart';

class CalendarService {
  final dio = Api().dio;

  Future<List<Schedule>> getSchedules() async {
    final response = await dio.get(
      '/api/schedules',
    );
    if (response.statusCode != 200) {
      throw Exception("Error in the API");
    }

    final data = response.data as List<dynamic>;
    return data.mapList((e) => Schedule.fromJson(e));
  }

  Future<Schedule> getScheduleById(int id) async {
    final response = await dio.get(
      '/api/schedules/$id',
    );
    if (response.statusCode != 200) {
      throw Exception("Error in the API");
    }

    final data = response.data as dynamic;
    return Schedule.fromJson(data);
  }

  Future<bool> getSignatureById(int id) async {
    try {
      final response = await dio.get(
        '/api/schedules/$id/sign',
      );
      if (response.statusCode != 200) {
        throw Exception("Error in the API");
      }
      return true;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return false;
      }
      throw Exception("Error in the API");
    }
  }

  Future<List<Schedule>> getAttendance() async {
    final response = await dio.get(
      '/api/schedules/unattended',
    );
    if (response.statusCode != 200) {
      throw Exception("Error in the API");
    }

    final data = response.data as List<dynamic>;
    return data.mapList((e) => Schedule.fromJson(e));
  }

  Future<bool> signFor(int id, String code) async {
    final response =
        await dio.post('/api/schedules/$id/sign', data: {"code": code});
    if (response.statusCode != 201) {
      throw Exception("Error in the API");
    }

    return true;
  }
}
