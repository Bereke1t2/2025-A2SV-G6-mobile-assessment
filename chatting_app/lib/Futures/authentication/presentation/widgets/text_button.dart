import 'package:flutter/material.dart';
import '../bloc/authentication_state.dart';

class TextButtonWidget extends StatelessWidget {
  final AuthenticationState state;
  final String text;
  final VoidCallback onPressed;

  const TextButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLoading =
        state is LoginLoadingState || state is RegisterLoadingState;

    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: 288,
        height: 42,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff3F51F3)),
          borderRadius: BorderRadius.circular(8),
          color: isLoading ? Colors.white : const Color(0xff3F51F3),
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Color(0xff3F51F3),
                  ),
                )
              : Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
        ),
      ),
    );
  }
}
