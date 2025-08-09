import 'package:chatting_app/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:chatting_app/core/network/network_info.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../data_sources/remote/auth_remote_data_srources.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final NetworkInfo networkInfo;
  final AuthRemoteDataSource remoteDataSource;

  AuthenticationRepositoryImpl({required this.networkInfo, required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> login(LoginParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(Failure('No internet connection!'));
    } else {
      return await remoteDataSource.login(params);
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    if (!await networkInfo.isConnected) {
      return Left(Failure('No internet connection!'));
    } else {
      return await remoteDataSource.logout();
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register(SignupParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(Failure('No internet connection!'));
    } else {
      return await remoteDataSource.register(params); 
    }
  }

  @override
  Future<Either<Failure, UserEntity>> checkAuthStatus() async {
    if (!await networkInfo.isConnected) {
      return Left(Failure('No internet connection!'));
    } else {
      return await remoteDataSource.checkAuthStatus();
    }
  }
}