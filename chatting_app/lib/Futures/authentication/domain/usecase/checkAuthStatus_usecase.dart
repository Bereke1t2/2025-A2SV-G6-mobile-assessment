
import 'package:chatting_app/Futures/authentication/domain/entity/user_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repositories/authentication_repository.dart';


class CheckAuthStatusUseCase {
  final AuthenticationRepository authRepository;

  CheckAuthStatusUseCase(this.authRepository);

  Future<Either<Failure, UserEntity>> call() async {
    return await authRepository.checkAuthStatus();
  }
}