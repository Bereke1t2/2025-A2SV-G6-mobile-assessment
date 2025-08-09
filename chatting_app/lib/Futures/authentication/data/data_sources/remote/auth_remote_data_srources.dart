
import 'package:chatting_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/usecase/usecase.dart';
import '../../../data/model/User_model.dart';
import '../../../../../core/const/const.dart';
import '../local/auth_local_data_sources.dart';


abstract class AuthRemoteDataSource {
  Future<Either<Failure, void>> login(LoginParams params);
  Future<Either<Failure, bool>> logout();
  Future<Either<Failure, UserModel>> register(SignupParams params);
  Future<Either<Failure, bool>> checkAuthStatus();
}



class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client httpClient;
  final AuthLocalDataSources authLocalDataSource;

  AuthRemoteDataSourceImpl(this.httpClient, this.authLocalDataSource);

  @override
  Future<Either<Failure, void>> login(LoginParams params) async {
    try {
      final response = await httpClient.post(
        Uri.parse('${Constants.baseUrl}${Constants.loginEndpoint}'),
        body: params.toJson(),
      );
      if (response.statusCode == 201) {
        final token = response.headers['authorization'] ?? '';
        final userId = response.headers['user-id'] ?? '';
        final userInfo = CatchUserInfoParams(
          isLoggedIn: 'true',
          token: token,
          userId: userId,
        );
        await authLocalDataSource.saveUserInfo(userInfo);

        return Right(null);
      } else {
        return Left(Failure('Login failed with status code: ${response.statusCode}'));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      final response = await httpClient.post(
        Uri.parse('${Constants.baseUrl}${Constants.logoutEndpoint}'),
      );
      if (response.statusCode == 201) {
        await authLocalDataSource.saveUserInfo(
          CatchUserInfoParams(isLoggedIn: 'false', token: '', userId: ''),
        );
        return Right(true);

      } else {
        return Left(Failure('Logout failed'));
      }
    } catch (e) {
      return Left(Failure('No intzernet connection'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> register(SignupParams params) async {
    try {
      final response = await httpClient.post(
        Uri.parse('${Constants.baseUrl}${Constants.registerEndpoint}'),
        body: params.toJson(),
      );
      if (response.statusCode == 201) {
        final jsonData = response.body as Map<String, dynamic>;
        final userModel = UserModel(id: jsonData['id'], name: jsonData['name'], email: jsonData['email'] , token:'' , imageUrl: '' , password: '');
        await authLocalDataSource.saveUserInfo(
          CatchUserInfoParams(
            isLoggedIn: 'true',
            token: userModel.token,
            userId: userModel.id,
          ),
        );
        return Right(userModel);
      } else {
        return Left(Failure('Registration failed with status code: ${response.statusCode}'));
      }
    } catch (e) {
      return Left(Failure('No internet connection'));
    }
  }
  @override
  Future<Either<Failure, bool>> checkAuthStatus() async {
    try {
      final userInfo = await authLocalDataSource.getUserInfo();
      return userInfo.fold(
        (failure) => Left(failure),
        (info) => Right(info.isLoggedIn == 'true'),
      );
    } catch (e) {
      return Left(Failure('Failed to check authentication status'));
    }
  }
}