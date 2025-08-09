// import '../../../../core/usecase/usecase.dart';
// import '../entity/user_entity.dart';

import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../repositories/authentication_repository.dart';


class LogoutUsecase {
  final AuthenticationRepository _repository;

  LogoutUsecase(this._repository);

  Future<Either<Failure, bool>> call() {
    return _repository.logout();
  }
}