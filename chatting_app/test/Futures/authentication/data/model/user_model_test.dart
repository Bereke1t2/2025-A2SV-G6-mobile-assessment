import 'package:chatting_app/Futures/authentication/domain/entity/user_entity.dart';
import 'package:chatting_app/Futures/authentication/data/model/User_model.dart';


import 'package:flutter_test/flutter_test.dart';

void main(){
  group('UserModel', () {
    test('should be a subclass of UserEntity', () {
      expect(UserModel(id: '123', email: 'test@bereket.com', name: 'Test User', password: 'password123', token: '', imageUrl: ''), isA<UserEntity>());
    });

    test('should return a valid model when fromJson is called', () {
      final jsonMap = {
        'id': '123',
        'name': 'Test User',
        'email': 'test@example.com',
        'password': 'password123',
        'token': '',
        'imageUrl': '',
      };
      final userModel = UserModel.fromJson(jsonMap);
      expect(userModel, isA<UserModel>());
    });

    test('should return a valid JSON map when toJson is called', () {
      final userModel = UserModel(
        id: '123',
        email: 'test@example.com',
        name: 'Test User',
        password: 'password123', token: '', imageUrl: '',
      );
      final jsonMap = userModel.toJson();
      expect(jsonMap, isA<Map<String, dynamic>>());
    });
  });
}
