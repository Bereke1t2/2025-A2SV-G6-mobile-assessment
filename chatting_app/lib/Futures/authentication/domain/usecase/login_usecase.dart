
import '../../../../core/usecase/usecase.dart';

import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../repositories/authentication_repository.dart';

class LoginUsecase {
  final AuthenticationRepository _repository;

  LoginUsecase(this._repository);

  Future<Either<Failure, void>> call(LoginParams params) {
    return _repository.login(params);
  }
  
}