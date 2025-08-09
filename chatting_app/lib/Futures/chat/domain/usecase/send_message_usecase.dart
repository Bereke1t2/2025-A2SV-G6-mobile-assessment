import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/message_entity.dart';
import '../repositories/chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  Future<Either<Failure, MessageEntity>> call(MessageEntity message) async {
    return await repository.sendMessage(message);
  }
}
