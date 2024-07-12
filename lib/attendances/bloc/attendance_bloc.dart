import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/attendances/bloc/attendance_event.dart';
import 'package:mobile/attendances/bloc/attendance_state.dart';
import 'package:mobile/core/services/calendar_service.dart';

// import 'package:web/shared/toaster.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  CalendarService calendarService;

  AttendanceBloc(this.calendarService) : super(AttendanceLoading()) {
    on<AttendanceInit>((event, emit) async {
      emit(AttendanceLoading());
      try {
        final schedules = await calendarService.getAttendance();
        emit(AttendanceLoaded(schedules: schedules));
      } on Exception catch (e) {
        emit(AttendanceError(errorMessage: e.toString()));
      }
    });
  }
}
