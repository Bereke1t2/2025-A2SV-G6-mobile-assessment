part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class LoadChatEvent extends ChatEvent {

  final String chatId;

  const LoadChatEvent(this.chatId);

  @override
  List<Object> get props => [chatId];
}

class SendMessageEvent extends ChatEvent {
  final String chatId;
  final String content;
  final String id;
  final String senderId;
  final String receiverId;
  final DateTime timestamp;
  const SendMessageEvent(this.chatId, this.content, this.id, this.senderId, this.receiverId, this.timestamp);

  @override
  List<Object> get props => [chatId, content, id, senderId, receiverId, timestamp];
}

class DeleteChatEvent extends ChatEvent {
  final String chatId;

  const DeleteChatEvent(this.chatId);

  @override
  List<Object> get props => [chatId];
}

class GetMessagesEvent extends ChatEvent {
  final String chatId;

  const GetMessagesEvent(this.chatId);

  @override
  List<Object> get props => [chatId];
}
class LoadChatsEvent extends ChatEvent {
  const LoadChatsEvent();

  @override
  List<Object> get props => [];
}

