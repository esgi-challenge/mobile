part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final dynamic profile;
  final dynamic classStudent;

  ProfileLoaded({required this.profile, required this.classStudent});
}

class ProfileNotFound extends ProfileState {}

class ProfilePasswordUpdated extends ProfileState {}

class ProfileError extends ProfileState {
  final String errorMessage;

  ProfileError({required this.errorMessage});
}