


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BoldText extends StatelessWidget {
  const BoldText({super.key, required this.text , this.fontSize = 16});

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ),
    );
  }
}