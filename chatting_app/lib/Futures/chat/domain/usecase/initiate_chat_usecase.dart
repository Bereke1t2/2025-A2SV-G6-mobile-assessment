import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/chat_entity.dart';
import '../repositories/chat_repository.dart';

class InitiateChatUseCase {
  final ChatRepository repository;

  InitiateChatUseCase(this.repository);

  Future<Either<Failure, ChatEntity>> call(ChatParams params) async{
    return await repository.initiateChat(params);
  }
}
