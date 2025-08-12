import 'package:bloc/bloc.dart';
import 'package:chatting_app/Futures/chat/domain/usecase/delete_chat_usecase.dart';
import 'package:chatting_app/Futures/chat/domain/usecase/get_chat_usecase.dart';
import 'package:chatting_app/Futures/chat/domain/usecase/get_messages_usecase.dart';
import 'package:chatting_app/Futures/chat/domain/usecase/initiate_chat_usecase.dart';
import 'package:chatting_app/Futures/chat/domain/usecase/send_message_usecase.dart';
import 'package:equatable/equatable.dart';


import '../../domain/entity/chat_entity.dart';
import '../../domain/entity/message_entity.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final DeleteChatUseCase deleteChatUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final GetMessagesUseCase getMessagesUseCase;
  final InitiateChatUseCase initiateChatUseCase;
  final GetChatUseCase getChatUseCase;
  

  ChatBloc({
    required this.deleteChatUseCase,
    required this.sendMessageUseCase,
    required this.getMessagesUseCase,
    required this.initiateChatUseCase,
    required this.getChatUseCase,
  }) : super(ChatInitial()) {
    on<LoadChatEvent>(_loadChat);
    on<SendMessageEvent>(_sendMessage);
    on<DeleteChatEvent>(_deleteChat);
    on<GetMessagesEvent>(_getMessages);
  }

  Future<void> _loadChat(LoadChatEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    final result = await getChatUseCase(event.chatId);
    result.fold(
      (failure) => emit(ChatError(failure.message)),
      (chat) => emit(ChatLoaded([chat])),
    );
  }

  Future<void> _sendMessage(SendMessageEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    final result = await sendMessageUseCase(MessageEntity(id: event.id, senderId: event.senderId, receiverId: event.receiverId, content: event.content, timestamp: event.timestamp));
    result.fold(
      (failure) => emit(ChatError(failure.message)),
      (message) => emit(MessageSentState(message)),
    );
  }

  Future<void> _deleteChat(DeleteChatEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    final result = await deleteChatUseCase(event.chatId);
    result.fold(
      (failure) => emit(ChatError(failure.message)),
      (_) => emit(ChatDeleted(event.chatId)),
    );
  }

  Future<void> _getMessages(GetMessagesEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    final result = await getMessagesUseCase(event.chatId);
    result.fold(
      (failure) => emit(ChatError(failure.message)),
      (messages) => emit(MessagesLoadedState(event.chatId, messages)),
    );
  }
}
