import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecase/checkAuthStatus_usecase.dart';
import '../../domain/usecase/login_usecase.dart';
import '../../domain/usecase/logout_usecase.dart';
import '../../domain/usecase/signup_usecase.dart';
import 'authentication_state.dart';

part 'authentication_event.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final CheckAuthStatusUseCase checkAuthStatusUseCase;
  final LoginUsecase loginUsecase;
  final LogoutUsecase logoutUsecase;
  final SignupUsecase signupUsecase;

  AuthenticationBloc(
    this.checkAuthStatusUseCase,
    this.loginUsecase,
    this.logoutUsecase,
    this.signupUsecase,
  ) : super(AuthenticationInitial()) {
    on<AuthenticationStarted>(_onAuthenticationStarted);
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<CheckAuthStatusRequested>(_onCheckAuthStatusRequested);
  }


  Future<void> _onAuthenticationStarted(AuthenticationStarted event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoadingState());
    final authStatus = await checkAuthStatusUseCase();
    authStatus.fold(
      (failure) => emit(AuthenticationErrorState(failure.message)),
      (isAuthenticated) {
        if (isAuthenticated) {
          emit(AuthenticationSuccessState("User is authenticated"));
        } else {
          emit(UnAuthorizedState());
        }
      },
    );
  }
  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthenticationState> emit) async {
    emit(LoginLoadingState());
    final result = await loginUsecase(event.params);
    result.fold(
      (failure) => emit(LoginErrorState(failure.message)), 
      (_) => emit(LoginSuccessState("Login successful")),
    );
  }
  Future<void> _onLogoutRequested(LogoutRequested event, Emitter<AuthenticationState> emit) async {
    emit(LogoutLoadingState());
    final result = await logoutUsecase();
    result.fold(
      (failure) => emit(LogoutErrorState(failure.message)),
      (_) => emit(LogoutSuccessState("Logout successful")),
    );
  }
  Future<void> _onRegisterRequested(RegisterRequested event, Emitter<AuthenticationState> emit) async {
    emit(RegisterLoadingState());
    final result = await signupUsecase(event.params);
    result.fold(
      (failure) => emit(RegisterErrorState(failure.message)),
      (_) => emit(RegisterSuccessState("Registration successful")),
    );
  }
  Future<void> _onCheckAuthStatusRequested(CheckAuthStatusRequested event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoadingState());
    final result = await checkAuthStatusUseCase();
    result.fold(
      (failure) => emit(AuthenticationErrorState(failure.message)),
      (isAuthenticated) => emit(isAuthenticated ? AuthorizedState() : UnAuthorizedState()),
    );
  }
}
