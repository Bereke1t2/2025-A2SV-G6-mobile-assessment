
import 'dart:convert';

import 'package:chatting_app/Futures/chat/data/model/message_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../model/chat_model.dart';
import '../../../../../core/const/const.dart';

abstract class ChatRemoteDataSource {
  Future<Either<Failure, ChatModel>> initiateChat(ChatParams params);
  Future<Either<Failure, ChatModel>> getChat(String chatId);
  Future<Either<Failure, List<MessageModel>>> getMessages(String chatId);
  Future<Either<Failure, MessageModel>> sendMessage(MessageModel message);
  Future<Either<Failure, void>> deleteChat(String chatId);
}


class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  @override
  Future<Either<Failure, ChatModel>> initiateChat(ChatParams params) async {
    try {
      final response = await http.post(
        Uri.parse(Constants.chatApiUrl + Constants.initiateChatEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(params.toJson()),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final chatModel = ChatModel.fromJson(data);
        return Right(chatModel);
      } else {
        return Left(Failure('Failed to initiate chat'));
      }
      
    } catch (e) {
      return Left(Failure(e.toString()));  
    }
  }

  @override
  Future<Either<Failure, ChatModel>> getChat(String chatId) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.chatApiUrl}${Constants.getChatEndpoint}$chatId'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final chatModel = ChatModel.fromJson(data);
        return Right(chatModel);
      } else {
        return Left(Failure('Failed to get chat'));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MessageModel>>> getMessages(String chatId) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.chatApiUrl}${Constants.getMessagesEndpoint}$chatId'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final messages = (data as List)
            .map((message) => MessageModel.fromJson(message))
            .toList();
        return Right(messages);
      } else {
        return Left(Failure('Failed to get messages'));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MessageModel>> sendMessage(MessageModel message) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.chatApiUrl}${Constants.sendMessageEndpoint}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(message.toJson()),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final messageModel = MessageModel.fromJson(data);
        return Right(messageModel);
      } else {
        return Left(Failure('Failed to send message'));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    } 
  }

  @override
  Future<Either<Failure, void>> deleteChat(String chatId) async {
    try {
      final response = await http.delete(
        Uri.parse('${Constants.chatApiUrl}${Constants.deleteChatEndpoint}$chatId'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return Right(null);
      } else {
        return Left(Failure('Failed to delete chat'));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}