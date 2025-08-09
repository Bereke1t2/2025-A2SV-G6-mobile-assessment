

import 'package:flutter_test/flutter_test.dart';
import 'package:chatting_app/Futures/authentication/domain/repositories/authentication_repository.dart';
import 'package:chatting_app/Futures/authentication/domain/usecase/checkAuthStatus_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([AuthenticationRepository])
import 'checkAuthStatus_usecase_test.mocks.dart';

void main(){

  group('CheckAuthStatusUsecase', () {
    late AuthenticationRepository mockRepository;
    late CheckAuthStatusUseCase checkAuthStatusUsecase;

    setUp(() {
      mockRepository = MockAuthenticationRepository();
      checkAuthStatusUsecase = CheckAuthStatusUseCase(mockRepository);
    });

    test('should call the checkAuthStatus method of the repository', () async {
      // Arrange
      when(mockRepository.checkAuthStatus()).thenAnswer((_) async => Right(true));

      // Act
      final result = await checkAuthStatusUsecase.call();

      // Assert
      expect(result, Right(true));
      verify(mockRepository.checkAuthStatus()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
    test('should return false when user is not authenticated', () async {
      // Arrange
      when(mockRepository.checkAuthStatus()).thenAnswer((_) async => Right(false));

      // Act
      final result = await checkAuthStatusUsecase.call();

      // Assert
      expect(result, Right(false));
      verify(mockRepository.checkAuthStatus()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  test('should return true when user is authenticated', () async {
    // Arrange
    when(mockRepository.checkAuthStatus()).thenAnswer((_) async => Right(true));

    // Act
    final result = await checkAuthStatusUsecase.call();

    // Assert
    expect(result, Right(true));
    verify(mockRepository.checkAuthStatus()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
  
  });

}