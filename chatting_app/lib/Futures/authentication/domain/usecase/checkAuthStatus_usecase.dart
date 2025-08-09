
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repositories/authentication_repository.dart';


class CheckAuthStatusUseCase {
  final AuthenticationRepository authRepository;

  CheckAuthStatusUseCase(this.authRepository);

  Future<Either<Failure, bool>> call() async {
    return await authRepository.checkAuthStatus();
  }
}