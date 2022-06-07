import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_list/services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late UserCredential user;

  AuthBloc(AuthService authService) : super(AuthInitial()) {
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
      var loginResult = await authService.signInWithEmailAndPassword(
          event.email, event.password);

      if (loginResult != null) {
        emit(Authenticated(loginResult.user!));
      } else {
        emit(AuthError());
      }
    });

    on<LogoutEvent>((event, emit) async {
      authService.signOut();
      emit(AuthInitial());
    });
  }
}
