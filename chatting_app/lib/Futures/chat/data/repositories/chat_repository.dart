import 'package:chatting_app/Futures/chat/data/model/chat_model.dart';
import 'package:chatting_app/Futures/chat/data/model/message_model.dart';
import 'package:chatting_app/Futures/chat/domain/entity/message_entity.dart';
import 'package:chatting_app/core/network/network_info.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/repositories/chat_repository.dart';
import '../data_sources/local/chat_local_data_sources.dart';
import '../data_sources/remote/chat_remote_data_sources.dart';


class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource chatRemoteDataSource;
  final ChatLocalDataSource chatLocalDataSource;
  final NetworkInfo networkInfo;

  ChatRepositoryImpl(this.chatRemoteDataSource, this.chatLocalDataSource, this.networkInfo);

  @override
  Future<Either<Failure, ChatModel>> initiateChat(ChatParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(Failure('No internet connection'));
    }
    return chatRemoteDataSource.initiateChat(params);
  }

  @override
  Future<Either<Failure, ChatModel>> getChat(String chatId) async {
    if (!await networkInfo.isConnected) {
      return Future.value(Left(Failure('No internet connection')));
    }
    return chatRemoteDataSource.getChat(chatId);
  }

  @override
  Future<Either<Failure, List<MessageModel>>> getMessages(String chatId) async {
    if (!await networkInfo.isConnected) {
      return Future.value(Left(Failure('No internet connection')));
    }
    return chatRemoteDataSource.getMessages(chatId);
  }

  @override
  Future<Either<Failure, MessageEntity>> sendMessage(MessageEntity message) async {
    if (!await networkInfo.isConnected) {
      return Future.value(Left(Failure('No internet connection')));
    }
    // Convert MessageEntity to MessageModel before sending
    final messageModel = MessageModel.fromEntity(message);
    final result = await chatRemoteDataSource.sendMessage(messageModel);
    return result.map((model) => model.toEntity());
  }

  @override
  Future<Either<Failure, void>> deleteChat(String chatId) async {
    if (!await networkInfo.isConnected) {
      return Future.value(Left(Failure('No internet connection')));
    }
    return chatRemoteDataSource.deleteChat(chatId);
  }
}