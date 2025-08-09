import '../../domain/entity/user_entity.dart';


class UserModel extends UserEntity{
  const UserModel({
    required super.id,
    required super.email,
    required super.name,
    required super.password,
    required super.token,
    required super.imageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      token: json['token'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'password': password,
      'token': token,
      'imageUrl': imageUrl,
    };
  }
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      password: entity.password,
      token: entity.token,
      imageUrl: entity.imageUrl,
    );
  }
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      name: name,
      password: password,
      token: token,
      imageUrl: imageUrl,
    );
  }
}