import 'package:flinq/flinq.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/models/information.dart';
import 'package:mobile/core/services/api.dart';
import 'package:mobile/infos/blocs/informations_event.dart';
import 'package:mobile/infos/blocs/informations_state.dart';

class InformationsBloc extends Bloc<InformationEvent, InformationState> {
  InformationsBloc() : super(InformationState()) {
    final dio = Api().dio;

    on<InformationInit>((event, emit) async {
      var response = await dio.get('/api/informations');
      final data = response.data as List<dynamic>;
      final informations = data.mapList((e) => Information.fromJson(e));

      emit(InformationState(
          informations: informations, status: InformationStatus.success));
    });
  }
}
