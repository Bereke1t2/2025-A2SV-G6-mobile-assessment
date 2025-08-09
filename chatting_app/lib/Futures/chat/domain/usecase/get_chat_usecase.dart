import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/chat_entity.dart';
import '../repositories/chat_repository.dart';

class GetChatUseCase {
  final ChatRepository repository;

  GetChatUseCase(this.repository);

  Future<Either<Failure, ChatEntity>> call(String chatId) async {
    return await repository.getChat(chatId);
  }
}
