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
}
