import 'package:chatting_app/Futures/chat/presentation/widgets/person.dart';
import 'package:flutter/material.dart';

import '../widgets/chat_input_field.dart';
import '../widgets/message_box.dart';

class Chat extends StatelessWidget {
  final bool isOnline;
  const Chat({super.key, required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 16),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            Person(displayProfileImage: '', isOnline: isOnline, leftPos: 43, radius: 27.0, topPos: 41.0),
            const SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Person Name',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF000E08),
                  ),
                ),
                if (isOnline)
                  Text(
                    'Online',
                    style: TextStyle(fontSize: 12.0, color: Color(0xff797C7B)),
                  ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.phone_outlined), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.video_call_outlined),
            onPressed: () {},
          ),
        ],
        // Remove duplicate backgroundColor parameter
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              itemCount: 45, // Example count
              itemBuilder: (context, index) {
                bool isMe = index % 2 == 0;
                return Align(
                  alignment: isMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: MessageBox(
                    index: index,
                    isMe: isMe,
                  ), // Using the MessageBox widget
                );
              },
            ),
          ),
          const ChatInputField(),
        ],
      ),
    );
  }
}
