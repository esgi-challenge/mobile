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

    on<GroupLoad>((event, emit) async {
      emit(ProjectsLoading());
      try {
        final groups = await projectsService.getGroups(event.id);
        emit(GroupLoaded(groups: groups));
      } on Exception catch (e) {
        emit(ProjectsError(errorMessage: e.toString()));
      }
    });

    on<GroupJoin>((event, emit) async {
      emit(ProjectsLoading());
      try {
        await projectsService.quitGroup(event.projectId);
        await projectsService.joinGroup(event.projectId, event.groupId);
        final groups = await projectsService.getGroups(event.projectId);
        emit(GroupLoaded(groups: groups));
      } on Exception catch (e) {
        emit(ProjectsError(errorMessage: e.toString()));
      }
    });

    on<GroupQuit>((event, emit) async {
      emit(ProjectsLoading());
      try {
        await projectsService.quitGroup(event.projectId);
        final groups = await projectsService.getGroups(event.projectId);
        emit(GroupLoaded(groups: groups));
      } on Exception catch (e) {
        emit(ProjectsError(errorMessage: e.toString()));
      }
    });
  }
}
