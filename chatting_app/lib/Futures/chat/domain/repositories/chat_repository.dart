
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/chat_entity.dart';
import '../entity/message_entity.dart';

abstract class ChatRepository {
  Future<Either<Failure, ChatEntity>> initiateChat(ChatParams params);
  Future<Either<Failure, ChatEntity>> getChat(String chatId);
  Future<Either<Failure, List<MessageEntity>>> getMessages(String chatId);
  Future<Either<Failure, MessageEntity>> sendMessage(MessageEntity message);
  Future<Either<Failure, void>> deleteChat(String chatId);
}