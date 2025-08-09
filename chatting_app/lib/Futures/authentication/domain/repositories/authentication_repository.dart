import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/user_entity.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, void>> login(LoginParams params);
  Future<Either<Failure, bool>> logout();
  Future<Either<Failure, UserEntity>> register(SignupParams params);
  Future<Either<Failure, bool>> checkAuthStatus();
}