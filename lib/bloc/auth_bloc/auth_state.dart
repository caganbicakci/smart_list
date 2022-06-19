// ignore_for_file: must_be_immutable

part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {}

class Unauthenticated extends AuthState {}

class Authenticated extends AuthState {
  User user;
  Authenticated(this.user);

  @override
  List<Object> get props => [user];
}

class AuthError extends AuthState {
  String error;
  AuthError(this.error);

  @override
  List<Object> get props => [error];
}
