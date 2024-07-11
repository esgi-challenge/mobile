import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/services/calendar_service.dart';
import 'package:mobile/signature/bloc/sign_event.dart';
import 'package:mobile/signature/bloc/sign_state.dart';
// import 'package:web/shared/toaster.dart';

class SignBloc extends Bloc<SignEvent, SignState> {
  CalendarService calendarService;
  final int id;

  SignBloc(this.calendarService, this.id) : super(SignInitial()) {
    on<Sign>((event, emit) async {
      emit(SignLoading());
      try {
        await calendarService.signFor(id, event.code);
        emit(SignLoaded());
      } on Exception catch (e) {
        emit(SignError(errorMessage: e.toString()));
      }
    });
  }
}
