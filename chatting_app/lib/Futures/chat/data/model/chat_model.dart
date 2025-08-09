import '../../domain/entity/chat_entity.dart';

class ChatModel extends ChatEntity {
  const ChatModel({
    required super.id,
    required super.user1Id,
    required super.user2Id,
    required super.lastMessageId,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      user1Id: json['user1Id'],
      user2Id: json['user2Id'],
      lastMessageId: json['lastMessageId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user1Id': user1Id,
      'user2Id': user2Id,
      'lastMessageId': lastMessageId,
    };
  }
}
