import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/services/calendar_service.dart';
import 'package:mobile/schedule/bloc/calendar_event.dart';
import 'package:mobile/schedule/bloc/calendar_state.dart';
// import 'package:web/shared/toaster.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  CalendarService calendarService;

  ScheduleBloc(this.calendarService) : super(ScheduleInitial()) {
    on<LoadSchedule>((event, emit) async {
      emit(ScheduleLoading());
      try {
        final schedule = await calendarService.getScheduleById(event.id);
        emit(ScheduleLoaded(schedule: schedule));
      } on Exception catch (e) {
        emit(ScheduleError(errorMessage: e.toString()));
      }
    });
  }
}
