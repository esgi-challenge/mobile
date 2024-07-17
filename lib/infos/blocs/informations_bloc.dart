import 'package:flinq/flinq.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/models/information.dart';
import 'package:mobile/core/services/api.dart';
import 'package:mobile/infos/blocs/informations_event.dart';
import 'package:mobile/infos/blocs/informations_state.dart';

class InformationsBloc extends Bloc<InformationEvent, ProjectsState> {
  InformationsBloc() : super(InformationLoad()) {
    final dio = Api().dio;

    on<InformationInit>((event, emit) async {
      try {
        var response = await dio.get('/api/informations');
        final data = response.data as List<dynamic>;
        final informations = data.mapList((e) => Information.fromJson(e));

        emit(InformationLoad(
            informations: informations, status: InformationStatus.success));
      } on Exception catch (e) {
        emit(InformationError(errorMessage: e.toString()));
      }
    });
  }
}
