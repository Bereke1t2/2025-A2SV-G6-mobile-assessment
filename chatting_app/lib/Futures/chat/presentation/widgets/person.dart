import 'package:flutter/material.dart';
import '../../../../core/ui/helper.dart';

class Person extends StatelessWidget {
  final String displayProfileImage;
  const Person({super.key, required this.displayProfileImage});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 24.0,
      backgroundColor: Color.fromARGB(
        getRandomNumber(244),
        getRandomNumber(244),
        getRandomNumber(244),
        getRandomNumber(244),
      ),
      child: Image.asset(displayProfileImage, fit: BoxFit.cover),
    );
  }
}
