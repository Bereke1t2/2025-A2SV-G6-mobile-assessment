import 'package:chatting_app/core/usecase/usecase.dart';

import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../repositories/authentication_repository.dart';


class SignupUsecase {
  final AuthenticationRepository _repository;

  SignupUsecase(this._repository);

  Future<Either<Failure, void>> call(SignupParams params) {
    return _repository.register(params);
  }
}