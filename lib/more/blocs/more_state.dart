abstract class MoreState {}

class MoreInitial extends MoreState {}

class MoreLoading extends MoreState {}

class MoreLoaded extends MoreState {
  final List<dynamic> notes;

  MoreLoaded({required this.notes});
}

class MoreNotFound extends MoreState {}

class MoreError extends MoreState {
  final String errorMessage;

  MoreError({required this.errorMessage});
}