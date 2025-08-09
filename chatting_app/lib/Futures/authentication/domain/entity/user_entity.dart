import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String password;
  final String name;
  final String token;
  final String imageUrl;

  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.password,
    required this.token,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, email, name, password, token, imageUrl];
}