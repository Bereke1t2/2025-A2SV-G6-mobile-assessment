
import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String id;
  final String user1Id;
  final String user2Id;
  final String lastMessageId;
  const ChatEntity({
    required this.id,
    required this.user1Id,
    required this.user2Id,
    required this.lastMessageId,
  });

  @override
  List<Object> get props => [id, user1Id, user2Id, lastMessageId];
}
