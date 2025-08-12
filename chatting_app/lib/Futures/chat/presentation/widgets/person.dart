import 'package:flutter/material.dart';
import '../../../../core/ui/helper.dart';

class Person extends StatelessWidget {
  final String displayProfileImage;
  final bool isOnline;
  final double radius;
  final double leftPos;
  final double topPos;
  const Person({
    super.key,
    required this.displayProfileImage,
    required this.isOnline,
    required this.leftPos,
    required this.radius,
    required this.topPos,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundImage: AssetImage('assets/images/1.png'),
          backgroundColor: Color.fromARGB(
            getRandomNumber(244),
            getRandomNumber(244),
            getRandomNumber(244),
            getRandomNumber(244),
          ),
        ),
        if (isOnline) ...[
          Positioned(
            left: leftPos,
            top: topPos,
            child: CircleAvatar(backgroundColor: Colors.green, radius: 5.0),
          ),
        ],
      ],
    );
  }
}
