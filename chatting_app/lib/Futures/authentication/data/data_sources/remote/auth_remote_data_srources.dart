
import 'package:chatting_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../../core/usecase/usecase.dart';
import '../../../data/model/User_model.dart';
import '../../../../../core/const/const.dart';
import '../local/auth_local_data_sources.dart';


abstract class AuthRemoteDataSource {
  Future<Either<Failure, void>> login(LoginParams params);
  Future<Either<Failure, bool>> logout();
  Future<Either<Failure, UserModel>> register(SignupParams params);
  Future<Either<Failure, UserModel>> checkAuthStatus();
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
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: json.encode(params.toJson()),
      );
      if (response.statusCode == 201) {
        final token = json.decode(response.body)['data']['access_token'] ?? '';
        final userId = json.decode(response.body)['data']['userId'] ?? '';
        final userInfo = UserInfoParams(
          isLoggedIn: 'true',
          token: token,
          userId: userId,
        );
        await authLocalDataSource.saveUserInfo(userInfo);
        return Right(null);
      } else if (response.statusCode == 401) {
        return Left(Failure('Invalid credentials'));
      } else if (response.statusCode == 500) {
        return Left(Failure('Server error'));
      } else {
        return Left(Failure('Login failed'));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      final response = await httpClient.post(
        headers: {
          'Content-Type': 'application/json',
        },
        Uri.parse('${Constants.baseUrl}${Constants.logoutEndpoint}'),
      );
      if (response.statusCode == 201) {
        
        await authLocalDataSource.saveUserInfo(
          UserInfoParams(isLoggedIn: 'false', token: '', userId: ''),
        );
        return Right(true);
      } else {
        return Left(Failure('Logout failed'));
      }
    } catch (e) {
      return Left(Failure('something went wrong while logging out'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> register(SignupParams params) async {
  try {
    final response = await httpClient.post(
      Uri.parse('${Constants.baseUrl}${Constants.registerEndpoint}'),
      headers: <String, String>{
          'Content-Type': 'application/json',
        },
      body: json.encode(params.toJson()),
    );
    final statusCode = response.statusCode;
    final bodyString = response.body;
    if (statusCode == 201) {
      final decoded = json.decode(bodyString);
      final jsonData = decoded['data'];
      if (jsonData == null) {
        return Left(Failure('Invalid response data'));
      }
      final userModel = UserModel(
        id: jsonData['id'] ?? '',
        name: jsonData['name'] ?? '',
        email: jsonData['email'] ?? '',
        token: '',
        imageUrl: '',
        password: '',
      );

      return Right(userModel);
    } else {
      String errorMessage;
      try {
        errorMessage = jsonDecode(bodyString)['message'] ?? 'Unknown error';
      } catch (_) {
        errorMessage = 'Unknown error';
      }
      return Left(Failure('Registration failed ($statusCode): $errorMessage'));
    }
  } catch (e) {
    return Left(Failure('Failed to register: $e'));
  }
}

  @override
 Future<Either<Failure, UserModel>> checkAuthStatus() async {
  try {
    final Either<Failure, UserInfoParams> userInfoEither =
        await authLocalDataSource.getUserInfo();

    return userInfoEither.fold(
      (failure) => Left(failure),
      (userInfo) async {
        final isLoggedIn = userInfo.isLoggedIn;
        final token = userInfo.token;

        if (isLoggedIn == 'true' && token.isNotEmpty) {
          final response = await httpClient.get(
            Uri.parse('${Constants.baseUrl}${Constants.userProfileEndpoint}'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          );

          if (response.statusCode == 200) {
            final jsonData = json.decode(response.body)['data'];

            final userModel = UserModel(
              id: jsonData['id'] ?? '',
              name: jsonData['name'] ?? '',
              email: jsonData['email'] ?? '',
              password: '',
              token: '',
              imageUrl: '',
            );

            await authLocalDataSource.saveUserInfo(
              UserInfoParams(
                isLoggedIn: 'true',
                token: token,
                userId: userModel.id,
              ),
            );

            return Right(userModel);
          } else if (response.statusCode == 401) {
            return Left(LoginFailure('Unauthorized access'));
          } else {
            return Left(LoginFailure('Failed to fetch user profile'));
          }
        } else {
          return Left(Failure('User is not authenticated'));
        }
      },
    );
  } catch (e) {
    return Left(Failure('Failed to check authentication status: $e'));
  }
}
}