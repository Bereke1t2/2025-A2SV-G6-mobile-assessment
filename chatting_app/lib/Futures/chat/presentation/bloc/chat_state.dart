part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();
  
  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}
class MessageState extends ChatState {
}






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
class ChatDeleted extends ChatState {
  final String chatId;

  const ChatDeleted(this.chatId);

  @override
  List<Object> get props => [chatId];
}





class MessagesLoadedState extends MessageState {
  final String chatId;
  final List<MessageEntity> messages;

  MessagesLoadedState(this.chatId, this.messages);

  @override
  List<Object> get props => [chatId, messages];
}

class MessageSentState extends MessageState {
  final MessageEntity message;

  MessageSentState(this.message);

  @override
  List<Object> get props => [message];
}


class MessageDeletedState extends MessageState {
  final String messageId;

  MessageDeletedState(this.messageId);

  @override
  List<Object> get props => [messageId];
}


class MessageSendingState extends MessageState {
  final String message;

  MessageSendingState(this.message);
}
