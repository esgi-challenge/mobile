import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile/core/services/profile_service.dart';
import 'package:mobile/shared/toaster.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileService profileService;

  ProfileBloc(this.profileService) : super(ProfileInitial()) {
    dynamic originalProfile;
    dynamic originalClass;

    on<LoadProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final profile = await profileService.getMe();
        final classStudent = await profileService.getMeClass();

        if (profile != null && profile.isNotEmpty) {
          originalProfile = profile;
          originalClass = classStudent;
          emit(ProfileLoaded(profile: profile, classStudent: classStudent));
        } else {
          emit(ProfileNotFound());
        }
      } on Exception catch (e) {
        emit(ProfileError(errorMessage: e.toString()));
      }
    });

    on<UpdateProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final updatedProfile = await profileService.updateProfile(event.email);

        if (updatedProfile != null) {
          emit(ProfileLoaded(
              profile: updatedProfile, classStudent: originalClass));
        } else {
          emit(ProfileLoaded(
              profile: originalProfile, classStudent: originalClass));
        }
      } on Exception catch (e) {
        showErrorToast("Erreur: ${e.toString().replaceAll('Exception: ', '')}");
        emit(ProfileLoaded(
            profile: originalProfile, classStudent: originalClass));
      }
    });

    on<UpdateProfilePassword>((event, emit) async {
      emit(ProfileLoading());
      try {
        final updatedProfile = await profileService.updateProfilePassword(
            event.oldPassword, event.newPassword);

        if (updatedProfile != null) {
          emit(ProfilePasswordUpdated());
        } else {
          emit(ProfileLoaded(
              profile: originalProfile, classStudent: originalClass));
        }
      } on Exception catch (e) {
        showErrorToast("Erreur: ${e.toString().replaceAll('Exception: ', '')}");
        emit(ProfileLoaded(
            profile: originalProfile, classStudent: originalClass));
      }
    });
  }
}
