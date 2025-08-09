import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/authentication_bloc.dart';
import '../bloc/authentication_state.dart';

class TextButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final AuthenticationState? state;
  const TextButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 288,
      height: 42,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff3F51F3)),
        borderRadius: BorderRadius.circular(8),
        color: Color(0xff3F51F3), // Semi-transparent background
      ),
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is LoginLoadingState || state is RegisterLoadingState) {
            return Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }
          return Center(
            child: GestureDetector(
              onTap: onPressed,
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
