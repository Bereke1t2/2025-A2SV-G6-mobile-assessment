
import 'package:chatting_app/Futures/authentication/domain/entity/user_entity.dart';
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
      final user = UserEntity(id: '123', name: 'Test User', email: 'test@example.com', password: '', token: '', imageUrl: '');
      when(mockRepository.checkAuthStatus()).thenAnswer((_) async => Right(user));

      // Act
      final result = await checkAuthStatusUsecase.call();

      // Assert
      expect(result, Right(user));
      verify(mockRepository.checkAuthStatus()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
    test('should return null when user is not authenticated', () async {
      // Arrange
      when(mockRepository.checkAuthStatus()).thenAnswer((_) async => Right(
        UserEntity(id: '', name: '', email: '', password: '', token: '', imageUrl: '')
      ));

      // Act
      final result = await checkAuthStatusUsecase.call();

      // Assert
      expect(result, Right(null));
      verify(mockRepository.checkAuthStatus()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  test('should return user when user is authenticated', () async {
    // Arrange
    final user = UserEntity(id: '456', name: 'Another User', email: 'another@example.com', password: '', token: '', imageUrl: '');
    when(mockRepository.checkAuthStatus()).thenAnswer((_) async => Right(user));

    // Act
    final result = await checkAuthStatusUsecase.call();

    // Assert
    expect(result, Right(user));
    verify(mockRepository.checkAuthStatus()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
  
  });

}