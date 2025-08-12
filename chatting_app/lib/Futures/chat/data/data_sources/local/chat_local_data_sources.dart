
import 'package:chatting_app/Futures/chat/domain/entity/message_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entity/chat_entity.dart';



abstract class ChatLocalDataSource {
  Future<Either<Failure, ChatEntity>> getCachedChat(String chatId);
  Future<Either<Failure, List<MessageEntity>>> getCachedMessages(String chatId);
  Future<Either<Failure, void>> cacheChat(ChatEntity chat);
  Future<Either<Failure, void>> cacheMessages(String chatId, List<MessageEntity> messages);
}


class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  @override
  Future<Either<Failure, ChatEntity>> getCachedChat(String chatId) {
    // TODO: implement getCachedChat
    throw UnimplementedError();
  }
  @override
  Future<Either<Failure, List<MessageEntity>>> getCachedMessages(String chatId) {
    // TODO: implement getCachedMessages
    throw UnimplementedError();
  }
  @override
  Future<Either<Failure, void>> cacheChat(ChatEntity chat) {
    // TODO: implement cacheChat
    throw UnimplementedError();
  }
  @override
  Future<Either<Failure, void>> cacheMessages(String chatId, List<MessageEntity> messages) {
    // TODO: implement cacheMessages
    throw UnimplementedError();
  }
}