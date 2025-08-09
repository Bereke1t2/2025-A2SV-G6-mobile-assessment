

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ErrorPage extends StatelessWidget {
  final String errorMessage;
  const ErrorPage({super.key, required this.errorMessage });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pushReplacementNamed('/login'),
        ),
        title: const Text('Error'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          errorMessage,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}