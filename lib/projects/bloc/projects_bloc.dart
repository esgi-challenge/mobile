import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/services/projects_service.dart';
import 'package:mobile/projects/bloc/projects_event.dart';
import 'package:mobile/projects/bloc/projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  ProjectsService projectsService;

  ProjectsBloc(this.projectsService) : super(ProjectsLoading()) {
    on<ProjectsInit>((event, emit) async {
      emit(ProjectsLoading());
      try {
        final projects = await projectsService.getProjects();
        emit(ProjectsLoaded(projects: projects));
      } on Exception catch (e) {
        emit(ProjectsError(errorMessage: e.toString()));
      }
    });
  }
}
