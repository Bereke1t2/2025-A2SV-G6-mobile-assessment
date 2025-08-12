import 'package:flutter/material.dart';

class MyStory extends StatelessWidget {
  final String imageUrl;
  final String label;
  final Color borderColor;

  MyStory({
    super.key,
    required this.imageUrl,
    this.label = "My status",
    Color? borderColor,
  }) : borderColor = borderColor ?? Color((0xFF000000 + (0x00FFFFFF * (imageUrl.hashCode % 1000) ~/ 1000)));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(3), // Border thickness
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: borderColor, width: 3),
              ),
              child: CircleAvatar(
                backgroundColor: Color((0xFF9daa90200 + (0x00FFFFFF * (imageUrl.hashCode % 1000) ~/ 1000))),
                radius: 30,
                backgroundImage: AssetImage(imageUrl),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.blue, width: 2),
                ),
                child: const Icon(
                  Icons.add,
                  size: 14,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}