import 'package:flinq/flinq.dart';
import 'package:mobile/core/models/project.dart';
import 'package:mobile/core/services/api.dart';

class ProjectsService {
  final dio = Api().dio;

  Future<List<Project>> getProjects() async {
    final response = await dio.get(
      '/api/projects',
    );
    if (response.statusCode != 200) {
      throw Exception("Error in the API");
    }

    final data = response.data as List<dynamic>;
    return data.mapList((e) => Project.fromJson(e));
  }
}
