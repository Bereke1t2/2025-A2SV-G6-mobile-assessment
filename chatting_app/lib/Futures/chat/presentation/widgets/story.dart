import 'package:flutter/material.dart';


class StoryWidget extends StatelessWidget {
  final String imageUrl;
  final String label;
  final Color borderColor;

  StoryWidget({
    super.key,
    required this.imageUrl,
    required this.label,
    Color? borderColor,
  })  : borderColor = borderColor ?? HSLColor.fromAHSL(
          1.0,
          (imageUrl.hashCode % 360).toDouble(),
          0.7,
          0.55,
        ).toColor();

  @override
  Widget build(BuildContext context) {
    return Column(
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
