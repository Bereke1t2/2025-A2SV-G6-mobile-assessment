import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  final String lebel;
  final String placeholder;
  final TextEditingController? controller;

  const InputBox({super.key, required this.lebel, required this.placeholder, this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lebel,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF6F6F6F),
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F3F3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            obscureText: false,
            autofocus: false,
            enableSuggestions: true,
            autocorrect: true,
            cursorColor: const Color(0xFF3F51F3),
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: const TextStyle(color: Color(0xFF888888) , fontSize: 14 , fontFamily: 'Poppins'),
              border: InputBorder.none,
            ),
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
    
  }
}
