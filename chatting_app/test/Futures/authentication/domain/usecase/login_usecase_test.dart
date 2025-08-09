import 'package:chatting_app/Futures/authentication/domain/entity/user_entity.dart';
import 'package:chatting_app/core/usecase/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chatting_app/Futures/authentication/domain/repositories/authentication_repository.dart';
import 'package:chatting_app/Futures/authentication/domain/usecase/login_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';


@GenerateMocks([AuthenticationRepository])
import 'login_usecase_test.mocks.dart';
void main(){
  group('LoginUsecase', () {
    late AuthenticationRepository mockRepository;
    late LoginUsecase loginUsecase;

    setUp(() {
      mockRepository = MockAuthenticationRepository();
      loginUsecase = LoginUsecase(mockRepository);
    });

    final tUserEntity = UserEntity(id: '123', email: 'test@bereket.com', name: 'Test User', password: 'password123', token: '', imageUrl: '');
    final tLoginParams = LoginParams(email: 'test@bereket.com', password: 'password123');
    test('should call the login method of the repository', () async {
      // Arrange
      when(mockRepository.login(tLoginParams)).thenAnswer((_) async => Right(tUserEntity));

      // Act
      final result = await loginUsecase.call(tLoginParams);

      // Assert
      expect(result, Right(tUserEntity));
      verify(mockRepository.login(tLoginParams)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}