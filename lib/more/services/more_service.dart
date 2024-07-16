import 'package:mobile/core/services/api.dart';
import 'package:dio/dio.dart';

class MoreService {
  final dio = Api().dio;

  Future<List<dynamic>?> getNotes() async {
    try {
      final response = await dio.get(
        '/api/notes',
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
