import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_list/services/auth/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthService authService) : super(AuthInitial()) {
    /////
    on<SignUpEvent>((event, emit) async {
      if (event.password1 == event.password2) {
        var signUpResult = await authService.signUpWithEmailAndPassword(
          event.email,
          event.password1,
        );
        if (signUpResult != null) {
          emit(Authenticated(signUpResult.user!));
        } else {
          emit(AuthError());
        }
      }
    });

    on<LoginEvent>((event, emit) async {
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
            emit(AuthInitial());
          }
        });
      } catch (e) {
        emit(AuthError());
      }
    });

    on<PasswordResetEvent>((event, emit) {
      try {
        authService.resetPassword(email: event.email);
        emit(AuthInitial());
      } catch (e) {
        emit(AuthError());
      }
    });

    on<LogoutEvent>((event, emit) {
      try {
        authService.signOut();
        emit(Unauthenticated());
      } catch (e) {
        emit(AuthError());
      }
    });
  }
}
