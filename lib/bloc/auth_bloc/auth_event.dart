part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password1;
  final String password2;

  const SignUpEvent({
    required this.email,
    required this.password1,
    required this.password2,
  });

  @override
  List<Object> get props => [email];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});
  @override
  List<Object> get props => [email];
}

class PasswordResetEvent extends AuthEvent {
  final String email;

  const PasswordResetEvent({required this.email});
  @override
  List<Object> get props => [email];
}

class LogoutEvent extends AuthEvent {}
