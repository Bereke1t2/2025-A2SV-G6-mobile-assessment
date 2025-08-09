import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String validate(String value, String fieldName , {TextEditingController? confirmPassword}) {
  if (value.isEmpty) {
    return '$fieldName cannot be empty';
  }
  if (fieldName == 'Email' && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
    return 'Invalid email format';
  }
  if (fieldName == 'Password' && value.length < 6 ) {
    return 'Password must be at least 6 characters long';
  }
  if (fieldName == 'Confirm Password' && value != confirmPassword?.text) {
    return 'Passwords do not match';
  }
  return '';
}

class Validate {
  final TextEditingController? name;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController? confirmPassword;
  final bool agree;

  Validate(this.name, this.email, this.password, this.confirmPassword, this.agree);

  bool isValid(BuildContext context) {
    String nameError = name != null ? validate(name!.text, 'Name') : '';
    String emailError = validate(email.text, 'Email');
    String passwordError = validate(password.text, 'Password');
    String confirmPasswordError = confirmPassword != null
        ? validate(confirmPassword!.text, 'Confirm Password', confirmPassword: password)
        : '';

    void showError(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    }
    if (nameError.isNotEmpty) {
      showError(nameError);
      return false;
    }
    if (emailError.isNotEmpty) {
      showError(emailError);
      return false;
    }
    if (passwordError.isNotEmpty) {
      showError(passwordError);
      return false;
    }
    if (confirmPasswordError.isNotEmpty) {
      showError(confirmPasswordError);
      return false;
    }
    if (!agree) {
      showError('You must agree to the terms and conditions');
      return false;
    }
    return true;
  }
}
