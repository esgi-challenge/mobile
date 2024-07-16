import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/more/blocs/more_event.dart';
import 'package:mobile/more/services/more_service.dart';
import 'package:mobile/more/blocs/more_state.dart';

class MoreBloc extends Bloc<MoreEvent, MoreState> {
  final MoreService moreService;

  MoreBloc(this.moreService) : super(MoreInitial()) {
    on<LoadMore>((event, emit) async {
      emit(MoreLoading());
      try {
        final notes = await moreService.getNotes();

        if (notes != null && notes.isNotEmpty) {
          final parsedNotes = _parseNotes(notes);
          emit(MoreLoaded(notes: parsedNotes));
        } else {
          emit(MoreNotFound());
        }
      } on Exception catch (e) {
        emit(MoreError(errorMessage: e.toString()));
      }
    });
  }

  List<dynamic> _parseNotes(List<dynamic> notes) {
    Map<String, dynamic> coursesMap = {};

    for (var note in notes) {
      String courseName = note['project']['course']['name'];
      String teacherName = '${note['teacher']['firstname']} ${note['teacher']['lastname']}';

      if (!coursesMap.containsKey(courseName)) {
        coursesMap[courseName] = {
          'course': courseName,
          'teacher': teacherName,
          'notes': [],
        };
      }

      coursesMap[courseName]['notes'].add({
        'value': note['value'],
        'project': note['project']['title'],
      });
    }

    return coursesMap.values.toList();
  }
}
