import 'package:chatting_app/Futures/chat/domain/entity/chat_entity.dart';
import 'package:chatting_app/Futures/chat/domain/entity/message_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';

import 'package:chatting_app/Futures/chat/presentation/bloc/chat_bloc.dart';
import 'package:chatting_app/Futures/chat/domain/usecase/delete_chat_usecase.dart';
import 'package:chatting_app/Futures/chat/domain/usecase/get_chat_usecase.dart';
import 'package:chatting_app/Futures/chat/domain/usecase/get_messages_usecase.dart';
import 'package:chatting_app/Futures/chat/domain/usecase/initiate_chat_usecase.dart';
import 'package:chatting_app/Futures/chat/domain/usecase/send_message_usecase.dart';


import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'chat_bloc_test.mocks.dart';
@GenerateMocks([
  DeleteChatUseCase,
  SendMessageUseCase,
  GetMessagesUseCase,
  InitiateChatUseCase,
  GetChatUseCase,
])
void main(){
  late ChatBloc chatBloc;
  late MockDeleteChatUseCase mockDeleteChatUseCase;
  late MockSendMessageUseCase mockSendMessageUseCase;
  late MockGetMessagesUseCase mockGetMessagesUseCase;
  late MockInitiateChatUseCase mockInitiateChatUseCase;
  late MockGetChatUseCase mockGetChatUseCase;

  setUp(() {
    mockDeleteChatUseCase = MockDeleteChatUseCase();
    mockSendMessageUseCase = MockSendMessageUseCase();
    mockGetMessagesUseCase = MockGetMessagesUseCase();
    mockInitiateChatUseCase = MockInitiateChatUseCase();
    mockGetChatUseCase = MockGetChatUseCase();

    chatBloc = ChatBloc(
      deleteChatUseCase: mockDeleteChatUseCase,
      sendMessageUseCase: mockSendMessageUseCase,
      getMessagesUseCase: mockGetMessagesUseCase,
      initiateChatUseCase: mockInitiateChatUseCase,
      getChatUseCase: mockGetChatUseCase,
    );
  });

  tearDown(() {
    chatBloc.close();
  });
  group('ChatBloc', () {
    test('initial state is ChatInitial', () {
      expect(chatBloc.state, ChatInitial());
    });
    blocTest<ChatBloc, ChatState>(
      'emits [ChatLoading, ChatLoaded] when LoadChatEvent is added',
      build: () {
        when(mockGetChatUseCase(any)).thenAnswer((_) async => Right(ChatEntity(
          id:'1',
          user1Id: 'user1',
          user2Id: 'user2',
          lastMessageId: 'lastMsgId',
        )));
        return chatBloc;
      },
      act: (bloc) => bloc.add(LoadChatEvent('1')),
      expect: () => [
        ChatLoading(),
        ChatLoaded([ChatEntity(id: '1', user1Id: 'user1', user2Id: 'user2', lastMessageId: 'lastMsgId')]),
      ],
      verify: (bloc) {
        verify(mockGetChatUseCase('1')).called(1);
      },

    );

    blocTest<ChatBloc, ChatState>(
      'emits [ChatLoading, MessageSent] when SendMessageEvent is added',
      build: () {
        when(mockSendMessageUseCase(any)).thenAnswer((_) async => Right(MessageEntity(
          id: 'msg1',
          senderId: 'user1',
          receiverId: 'user2',
          content: 'Hello',
          timestamp: DateTime.now(),
        )));
        return chatBloc;
      },
      act: (bloc) => bloc.add(SendMessageEvent('chat1', 'Hello', 'msg1', 'user1', 'user2', DateTime.now())),
      expect: () => [
        ChatLoading(),
        isA<MessageSentState>().having(
          (state) => state.message.id, 'id', 'msg1'
        ).having(
          (state) => state.message.senderId, 'senderId', 'user1'
        ).having(
          (state) => state.message.receiverId, 'receiverId', 'user2'
        ).having(
          (state) => state.message.content, 'content', 'Hello'
        ).having(
          (state) => state.message.timestamp, 'timestamp', isA<DateTime>()
        ),
      ],
      verify: (bloc) {
        verify(mockSendMessageUseCase(any)).called(1);
      },
    );
    blocTest<ChatBloc, ChatState>(
      'emits [ChatLoading, ChatDeleted] when DeleteChatEvent is added',
      build: () {
        when(mockDeleteChatUseCase(any)).thenAnswer((_) async => Right(null));
        return chatBloc;
      },
      act: (bloc) => bloc.add(DeleteChatEvent('chat1')),
      expect: () => [
        ChatLoading(),
        isA<ChatDeleted>().having((state) => state.chatId, 'chatId', 'chat1'),
      ],
      verify: (bloc) {
        verify(mockDeleteChatUseCase('chat1')).called(1);
      },
    );
    blocTest<ChatBloc, ChatState>(
      'emits [ChatLoading, MessagesLoaded] when GetMessagesEvent is added',
      build: () {
        when(mockGetMessagesUseCase(any)).thenAnswer((_) async => Right([
          MessageEntity(
            id: 'msg1',
            senderId: 'user1',
            receiverId: 'user2',
            content: 'Hello',
            timestamp: DateTime.now(),
          ),
        ]));
        return chatBloc;
      },
      act: (bloc) => bloc.add(GetMessagesEvent('chat1')),
      expect: () => [
        ChatLoading(),
        isA<MessagesLoadedState>().having(
          (state) => state.messages.length, 'length', 1
        ).having(
          (state) => state.messages.first.id, 'id', 'msg1'
        ),
      ],
      verify: (bloc) {
        verify(mockGetMessagesUseCase('chat1')).called(1);
      },
    );
    
  });
}