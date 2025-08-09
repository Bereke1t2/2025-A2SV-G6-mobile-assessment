import 'package:flutter/material.dart';
import 'person.dart';

class MyStory extends StatelessWidget {
  final String imageUrl;
  const MyStory({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Gradient border around the profile image
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Colors.purple,
                Colors.orange,
                Colors.yellow,
                Colors.red,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0), // Thickness of gradient border
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: ClipOval(
                child: Person(
                  displayProfileImage: imageUrl,
                ),
              ),
            ),
          ),
        ),
        // Small add button at bottom right
        Positioned(
          bottom: 4,
          right: 4, // Changed from left to right
          child: Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.lightBlueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 14,
            ),
          ),
        ),
        // Break in the gradient border (simulate with a white arc)
        Positioned(
          top: 0,
          left: 0,
          child: SizedBox(
            width: 70,
            height: 70,
            child: CustomPaint(
              painter: _BreakCirclePainter(),
            ),
          ),
        ),
      ],
    );
  }
}

// Custom painter to draw a break in the gradient circle
class _BreakCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw a small arc to simulate the break at bottom right
    // Start angle: 5.5 radians (~315 degrees, bottom right)
    // Sweep angle: 0.6 radians (~35 degrees)
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      5.5, // start angle (bottom right)
      0.6, // sweep angle (radians)
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}