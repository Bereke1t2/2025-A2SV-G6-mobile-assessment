part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();
  
  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}
class ChatLoaded extends ChatState {
  final List<ChatEntity> chats;

  const ChatLoaded(this.chats);

  @override
  List<Object> get props => [chats];
}

class ChatError extends ChatState {
  final String message;

  const ChatError(this.message);

  @override
  List<Object> get props => [message];
}


class MessagesLoaded extends ChatState {
  final List<MessageEntity> messages;

  const MessagesLoaded(this.messages);

  @override
  List<Object> get props => [messages];
}

class MessageSent extends ChatState {
  final MessageEntity message;

  const MessageSent(this.message);

  @override
  List<Object> get props => [message];
}


class MessageDeleted extends ChatState {
  final String messageId;

  const MessageDeleted(this.messageId);

  @override
  List<Object> get props => [messageId];
}

class ChatDeleted extends ChatState {
  final String chatId;

  const ChatDeleted(this.chatId);

  @override
  List<Object> get props => [chatId];
}