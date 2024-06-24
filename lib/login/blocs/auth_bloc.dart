import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/login/blocs/auth_event.dart';
import 'package:mobile/login/blocs/auth_state.dart';
import 'package:mobile/login/services/auth_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<AuthLogged>((event, emit) async {
      emit(AuthState(jwt: event.jwt));
    });

    on<AuthInit>((event, emit) async {
      final jwt = await AuthService.init();

      emit(AuthState(jwt: jwt));
    });
  }
}
