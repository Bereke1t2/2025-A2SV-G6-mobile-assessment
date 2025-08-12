import 'package:flutter/material.dart';

class BottomLink extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final String buttonText;
  const BottomLink({super.key, required this.text, required this.onPressed, required this.buttonText });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xff888888),
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: TextStyle(
              color: Color(0xff3F51F3),
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ],
    );
  }
}
