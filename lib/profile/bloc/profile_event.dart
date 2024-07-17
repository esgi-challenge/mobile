part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final String email;

  UpdateProfile(this.email);
}

class UpdateProfilePassword extends ProfileEvent {
  final String oldPassword;
  final String newPassword;

  UpdateProfilePassword(this.oldPassword, this.newPassword);
}