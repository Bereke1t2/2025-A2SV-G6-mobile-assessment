import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

// General authentication states
class AuthenticationInitial extends AuthenticationState {}
class UnAuthorizedState extends AuthenticationState {}
class AuthorizedState extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}
class AuthenticationSuccessState extends AuthenticationState {
  final String message;
  const AuthenticationSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}
class AuthenticationErrorState extends AuthenticationState {
  final String message;
  const AuthenticationErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

// Login states
abstract class LoginState extends AuthenticationState {
  const LoginState();
}

class LoginLoadingState extends LoginState {}
class LoginSuccessState extends LoginState {
  final String message;
  const LoginSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}
class LoginErrorState extends LoginState {
  final String message;
  const LoginErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

// Register states
abstract class RegisterState extends AuthenticationState {
  const RegisterState();
}

class RegisterLoadingState extends RegisterState {}
class RegisterSuccessState extends RegisterState {
  final String message;
  const RegisterSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}
class RegisterErrorState extends RegisterState {
  final String message;
  const RegisterErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

// Logout states
abstract class LogoutState extends AuthenticationState {
  const LogoutState();
}

class LogoutLoadingState extends LogoutState {}
class LogoutSuccessState extends LogoutState {
  final String message;
  const LogoutSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}
class LogoutErrorState extends LogoutState {
  final String message;
  const LogoutErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
