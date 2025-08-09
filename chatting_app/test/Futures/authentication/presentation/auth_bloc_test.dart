import 'package:bloc_test/bloc_test.dart';
import 'package:chatting_app/Futures/authentication/domain/entity/user_entity.dart';
import 'package:chatting_app/Futures/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:chatting_app/Futures/authentication/presentation/bloc/authentication_state.dart';
import 'package:chatting_app/Futures/authentication/domain/usecase/checkAuthStatus_usecase.dart';
import 'package:chatting_app/Futures/authentication/domain/usecase/login_usecase.dart';
import 'package:chatting_app/Futures/authentication/domain/usecase/logout_usecase.dart';
import 'package:chatting_app/Futures/authentication/domain/usecase/signup_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:chatting_app/core/error/failure.dart' as custom_failure;


import 'auth_bloc_test.mocks.dart';

// Simple Failure for testing
@GenerateMocks([
  CheckAuthStatusUseCase,
  LoginUsecase,
  SignupUsecase,
  LogoutUsecase,
])
void main() {
  late MockCheckAuthStatusUseCase mockCheckAuthStatusUseCase;
  late MockLoginUsecase mockLoginUsecase;
  late MockSignupUsecase mockSignupUsecase;
  late MockLogoutUsecase mockLogoutUsecase;
  late AuthenticationBloc authenticationBloc;

  setUp(() {
    mockCheckAuthStatusUseCase = MockCheckAuthStatusUseCase();
    mockLoginUsecase = MockLoginUsecase();
    mockSignupUsecase = MockSignupUsecase();
    mockLogoutUsecase = MockLogoutUsecase();

    authenticationBloc = AuthenticationBloc(
      mockCheckAuthStatusUseCase,
      mockLoginUsecase,
      mockLogoutUsecase,
      mockSignupUsecase,
    );
  });

  tearDown(() {
    authenticationBloc.close();
  });

  group('AuthenticationBloc', () {
    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationLoadingState, AuthenticationSuccessState] when authentication starts',
      build: () {
        when(mockCheckAuthStatusUseCase())
            .thenAnswer((_) async => const Right(
          UserEntity(id: '123', name: 'Test User', email: 'test@example.com', password: '', token: '', imageUrl: '')
            ));
        return authenticationBloc;
      },
      act: (bloc) => bloc.add(AuthenticationStarted()),
      expect: () => [
        AuthenticationLoadingState(),
        isA<AuthenticationSuccessState>(),
      ],
    );

   
    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [LogoutLoadingState, LogoutSuccessState] when logout is requested',
      build: () {
        when(mockLogoutUsecase())
            .thenAnswer((_) async => const Right(true));
        return authenticationBloc;
      },
      act: (bloc) => bloc.add(LogoutRequested()),
      expect: () => [
        LogoutLoadingState(),
        LogoutSuccessState("Logout successful"),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [LogoutLoadingState, LogoutErrorState] when logout fails',
      build: () {
        when(mockLogoutUsecase())
            .thenAnswer((_) async => Left(custom_failure.TestFailure("Logout failed")));
        return authenticationBloc;
      },
      act: (bloc) => bloc.add(LogoutRequested()),
      expect: () => [
        LogoutLoadingState(),
        LogoutErrorState("Logout failed"),
      ],
    );

    
  
    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationLoadingState, AuthorizedState] when auth status is checked and user is authenticated',
      build: () {
        when(mockCheckAuthStatusUseCase())
            .thenAnswer((_) async => const Right(
          UserEntity(id: '123', name: 'Test User', email: 'test@example.com', password: '', token: '', imageUrl: '')
            ));
        return authenticationBloc;
      },
      act: (bloc) => bloc.add(CheckAuthStatusRequested()),
      expect: () => [
        AuthenticationLoadingState(),
        AuthorizedState(UserEntity(id: '123', name: 'Test User', email: 'test@example.com', password: '', token: '', imageUrl: '')),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationLoadingState, UnAuthorizedState] when auth status is checked and user is not authenticated',
      build: () {
        when(mockCheckAuthStatusUseCase())
            .thenAnswer((_) async => const Right(
          UserEntity(id: '', name: '', email: '', password: '', token: '', imageUrl: '')
            ));
        return authenticationBloc;
      },
      act: (bloc) => bloc.add(CheckAuthStatusRequested()),
      expect: () => [
        AuthenticationLoadingState(),
        UnAuthorizedState(),
      ],
    );
  });
}
