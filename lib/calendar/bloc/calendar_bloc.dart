import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/calendar/bloc/calendar_event.dart';
import 'package:mobile/calendar/bloc/calendar_state.dart';
import 'package:mobile/core/services/calendar_service.dart';
// import 'package:web/shared/toaster.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarService calendarService;

  CalendarBloc(this.calendarService) : super(CalendarInitial()) {
    on<LoadCalendar>((event, emit) async {
      emit(CalendarLoading());
      try {
        final schedules = await calendarService.getSchedules();
        emit(CalendarLoaded(schedules: schedules));
      } on Exception catch (e) {
        emit(CalendarError(errorMessage: e.toString()));
      }
    });
  }
}
