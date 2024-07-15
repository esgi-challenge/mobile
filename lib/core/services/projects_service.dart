import 'package:flinq/flinq.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mobile/core/models/group.dart';
import 'package:mobile/core/models/project.dart';
import 'package:mobile/core/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<List<Group>> getGroups(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('kAuth');
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);
    final response = await dio.get(
      '/api/projects/$id/groups',
    );
    if (response.statusCode != 200) {
      throw Exception("Error in the API");
    }

    final data = response.data as List<dynamic>;
    return data.mapList((e) => Group.fromJson(e, decodedToken['user']['id']));
  }

  Future<void> quitGroup(int projectId) async {
    final response = await dio.delete(
      '/api/projects/$projectId/quit',
    );
    if (response.statusCode != 200) {
      throw Exception("Error in the API");
    }
  }

  Future<void> joinGroup(int projectId, int groupId) async {
    final response = await dio
        .post('/api/projects/$projectId/join', data: {"group": groupId});
    if (response.statusCode != 201) {
      throw Exception("Error in the API");
    }
  }
}
