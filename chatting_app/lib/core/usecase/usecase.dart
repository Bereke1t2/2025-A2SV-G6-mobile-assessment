import 'dart:convert';

import '../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);

}

class LoginParams {
  final String email;
  final String password;


  LoginParams({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}


class SignupParams {
  final String name;
  final String email;
  final String password;

  SignupParams({required this.name, required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}



class CatchUserInfoParams {
  final String isLoggedIn;
  final String token;
  final String userId;

  CatchUserInfoParams({required this.isLoggedIn, required this.token, required this.userId});

  Map<String, dynamic> toJson() {
    return {
      'isLoggedIn': isLoggedIn,
      'token': token,
      'userId': userId,
    };
  }

  factory CatchUserInfoParams.fromJson(String source) {
    final json = jsonDecode(source);
    return CatchUserInfoParams(
      isLoggedIn: json['isLoggedIn'],
      token: json['token'],
      userId: json['userId'],
    );
  }
}


class ChatParams {
  final String userId;

  ChatParams({required this.userId});

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
    };
  }

  factory ChatParams.fromJson(Map<String, dynamic> json) {
    return ChatParams(
      userId: json['userId'] as String,
    );
  }
}