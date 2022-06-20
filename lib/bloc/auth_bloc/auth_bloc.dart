import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../constants/strings.dart';
import '../../services/auth/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthService authService) : super(Unauthenticated()) {
    /////
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      if (event.password1 != event.password2) {
        emit(AuthError(PASSWORDS_MISSMATCH));
        return;
      }
      if (event.password1 == event.password2) {
        var signUpResult = await authService.signUpWithEmailAndPassword(
          event.email,
          event.password1,
        );
        if (signUpResult != null) {
          emit(Authenticated(signUpResult.user!));
        } else {
          emit(AuthError(AuthService.exception));
        }
      }
    });

    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await authService
            .signInWithEmailAndPassword(
          event.email,
          event.password,
        )
            .then((value) {
          if (value != null) {
            emit(Authenticated(value.user!));
          } else {
            emit(AuthError(AuthService.exception));
          }
        });
      } catch (e) {
        emit(AuthError(AuthService.exception));
      }
    });

    on<PasswordResetEvent>((event, emit) {
      try {
        authService.resetPassword(email: event.email);
      } catch (e) {
        emit(AuthError(AuthService.exception));
      }
    });

    on<LogoutEvent>((event, emit) {
      try {
        authService.signOut();
        emit(Unauthenticated());
      } catch (e) {
        emit(AuthError(AuthService.exception));
      }
    });
  }
}
