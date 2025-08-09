import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/message_entity.dart';
import '../repositories/chat_repository.dart';

class GetMessagesUseCase {
  final ChatRepository repository;

  GetMessagesUseCase(this.repository);

  Future<Either<Failure, List<MessageEntity>>> call(String chatId) async {
    return await repository.getMessages(chatId);
  }
}
