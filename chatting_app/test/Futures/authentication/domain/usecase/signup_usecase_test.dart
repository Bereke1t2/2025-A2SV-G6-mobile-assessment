import 'package:chatting_app/Futures/authentication/domain/entity/user_entity.dart';
import 'package:chatting_app/Futures/authentication/domain/repositories/authentication_repository.dart';
import 'package:chatting_app/Futures/authentication/domain/usecase/signup_usecase.dart';
import 'package:chatting_app/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';


@GenerateMocks([AuthenticationRepository])
import 'signup_usecase_test.mocks.dart';

void main(){
  group('SignupUsecase', () {
    late AuthenticationRepository mockRepository;
    late SignupUsecase signupUsecase;

    setUp(() {
      mockRepository = MockAuthenticationRepository();
      signupUsecase = SignupUsecase(mockRepository);
    });

    final tUserEntity = UserEntity(id: '123', email: 'test@bereket.com', name: 'Test User', password: 'password123', token: '', imageUrl: '');
    final tSignupParams = SignupParams(email: 'test@bereket.com', name: 'Test User', password: 'password123');
    test('should return a UserEntity when signup is successful', () async {
      // Arrange
      when(mockRepository.register(tSignupParams)).thenAnswer((_) async => Right(tUserEntity));

      // Act
      final result = await signupUsecase.call(tSignupParams);

      // Assert
      expect(result, Right(tUserEntity));
      verify(mockRepository.register(tSignupParams)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
    test('should call the signup method of the repository', () async {
      // Arrange
      when(mockRepository.register(tSignupParams)).thenAnswer((_) async => Right(tUserEntity));

      // Act
      final result = await signupUsecase.call(tSignupParams);

      // Assert
      expect(result, Right(tUserEntity));
      verify(mockRepository.register(tSignupParams)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

  });
}