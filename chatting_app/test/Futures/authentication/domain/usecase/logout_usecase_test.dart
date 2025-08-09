import 'package:flutter_test/flutter_test.dart';
import 'package:chatting_app/Futures/authentication/domain/repositories/authentication_repository.dart';
import 'package:chatting_app/Futures/authentication/domain/usecase/logout_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([AuthenticationRepository])
import 'logout_usecase_test.mocks.dart';

void main() {
  group('LogoutUsecase', () {
    late AuthenticationRepository mockRepository;
    late LogoutUsecase logoutUsecase;

    setUp(() {
      mockRepository = MockAuthenticationRepository();
      logoutUsecase = LogoutUsecase(mockRepository);
    });

    test('should call the logout method of the repository', () async {
      // Arrange
      when(mockRepository.logout()).thenAnswer((_) async => Right(true));

      // Act
      final result = await logoutUsecase.call();

      // Assert
      expect(result, Right(true));
      verify(mockRepository.logout()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
   
  });
}
