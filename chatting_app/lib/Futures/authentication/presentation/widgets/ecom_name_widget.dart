import 'package:flutter/material.dart';

class Ecom extends StatelessWidget {
  final double height;
  final double width;
  final double fontSize;
  final double radius;
  const Ecom({
    super.key,
    required this.height,
    required this.width,
    required this.fontSize,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff3F51F3)),
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
        color: Colors.white,
      ),
      child: Center(
        child: Text(
          'ECOM',
          style: TextStyle(
            fontSize: fontSize,
            color: Color(0xff3F51F3),
            fontWeight: FontWeight.w800,
            fontFamily: 'CaveatBrush',
          ),
        ),
      ),
    );
  }
}
