part of 'authentication_bloc.dart';


sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {}


class LoginStarted extends AuthenticationEvent{}

class LoginRequested extends AuthenticationEvent {
  final LoginParams params;

  const LoginRequested(this.params);

  @override
  List<Object> get props => [params];
}

class LogoutRequested extends AuthenticationEvent {}

class RegisterRequested extends AuthenticationEvent {
  final SignupParams params;

  const RegisterRequested(this.params);

  @override
  List<Object> get props => [params];
}

class CheckAuthStatusRequested extends AuthenticationEvent {}


