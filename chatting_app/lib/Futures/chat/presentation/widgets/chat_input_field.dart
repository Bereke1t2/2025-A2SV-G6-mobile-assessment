import 'package:flutter/material.dart';

class ChatInputField extends StatefulWidget {
  const ChatInputField({super.key});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left:14 , right: 14 ,  top:8.0 , bottom: 8.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
        color: Colors.black12,
        blurRadius: 4.0,
        offset: Offset(0, -2), // Only on the top
          ),
        ],
      ),
      child: Row(children: [
        
        Icon(Icons.attach_file, color: Colors.black),
        const SizedBox(width: 8.0),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Type a message...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              hintStyle: TextStyle(color: Color(0xFF797C7B)),
              fillColor: Color(0xFFF3F6F6),
              filled: true,
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Icon(Icons.camera_alt_outlined, color: Color(0xff000E08)),
        const SizedBox(width: 14.0),
        Icon(Icons.mic_outlined, color: Color(0xff000E08)),
      ],),
    );
  }
}