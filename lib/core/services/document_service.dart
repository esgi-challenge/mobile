import 'package:flinq/flinq.dart';
import 'package:mobile/core/models/document.dart';
import 'package:mobile/core/services/api.dart';

class DocumentService {
  final dio = Api().dio;

  Future<List<Document>> getDocuments() async {
    final response = await dio.get(
      '/api/documents/school',
    );
    if (response.statusCode != 200) {
      throw Exception("Error in the API");
    }

    final data = response.data as List<dynamic>;
    return data.mapList((e) => Document.fromJson(e));
  }
}
