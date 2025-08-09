import 'package:flutter/material.dart';
import 'person.dart';

import 'dart:math';

class Story extends StatelessWidget {
  final String? imageUrl;
  final List<Color>? storyColors;

  const Story({
    super.key,
    this.imageUrl,
    this.storyColors,
  });

  List<Color> _getRandomColors() {
    final List<List<Color>> colorOptions = [
      [Colors.purple, Colors.orange, Colors.red],
      [Colors.blue, Colors.green, Colors.yellow],
      [Colors.teal, Colors.indigo, Colors.pink],
      [Colors.deepOrange, Colors.amber, Colors.brown],
      [Colors.cyan, Colors.lime, Colors.deepPurple],
    ];
    final random = Random();
    return colorOptions[random.nextInt(colorOptions.length)];
  }

  @override
  Widget build(BuildContext context) {
    final colors = storyColors ?? _getRandomColors();
    return Container(
      width: 60,
      height: 60,
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 6.0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(3.0),
        child: ClipOval(
          child: Person(displayProfileImage: imageUrl ?? ''),
        ),
      ),
    );
  }
}