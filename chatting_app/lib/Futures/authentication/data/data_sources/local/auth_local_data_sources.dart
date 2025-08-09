
import 'dart:convert';

import 'package:chatting_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/usecase/usecase.dart';


abstract class AuthLocalDataSources {
  Future<Either<Failure, bool>> saveUserInfo(CatchUserInfoParams params);
  Future<Either<Failure, CatchUserInfoParams>> getUserInfo();
}



class AuthLocalDataSourcesImpl implements AuthLocalDataSources {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourcesImpl(this.sharedPreferences);

  @override
  Future<Either<Failure, bool>> saveUserInfo(CatchUserInfoParams params) async {
    try {
      await sharedPreferences.setString('user_info', json.encode(params.toJson()));
      return Right(true);
    } catch (e) {
      return Left(Failure('Failed to save user info'));
    }
  }

  @override
  Future<Either<Failure, CatchUserInfoParams>> getUserInfo() async {
    try {
      final userInfo = sharedPreferences.getString('user_info');
      if (userInfo != null) {
        return Right(CatchUserInfoParams.fromJson(userInfo));
      } else {
        return Left(Failure('No user info found'));
      }
    } catch (e) {
      return Left(Failure('Failed to retrieve user info'));
    }
  }
}