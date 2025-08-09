import 'package:chatting_app/Futures/authentication/presentation/widgets/bold_text.dart';
import 'package:chatting_app/Futures/authentication/presentation/widgets/ecom_name_widget.dart';
import 'package:chatting_app/Futures/authentication/presentation/widgets/input_box.dart';
import 'package:chatting_app/core/ui/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../bloc/authentication_bloc.dart';
import '../bloc/authentication_state.dart';
import '../widgets/text_button.dart';
import '../widgets/buttom_link.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool agree = false;

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  void _clear() {
    name.clear();
    email.clear();
    password.clear();
    confirmPassword.clear();
    changeAgree(false);
  }

  void changeAgree(bool value) {
    setState(() {
      agree = value;
    });
  }

  void _signup(BuildContext context) {
    if (!Validate(
      name,
      email,
      password,
      confirmPassword,
      agree,
    ).isValid(context)) {
      return;
    }

    context.read<AuthenticationBloc>().add(
      RegisterRequested(
        SignupParams(
          name: name.text,
          email: email.text,
          password: password.text,
        ),
      ),
    );
    _clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: const EdgeInsets.only(left: 40.0),
          color: const Color(0xff3F51F3),
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: Ecom(height: 33, width: 60, fontSize: 23.3, radius: 12),
          ),
        ],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const BoldText(text: 'Create Your Account', fontSize: 24),
                const SizedBox(height: 30),
                InputBox(
                  lebel: 'Name',
                  placeholder: "ex: jon smith",
                  controller: name,
                ),
                const SizedBox(height: 15),
                InputBox(
                  lebel: 'Email',
                  placeholder: 'ex: jon.smith@email.com',
                  controller: email,
                ),
                const SizedBox(height: 15),
                InputBox(
                  lebel: 'Password',
                  placeholder: '**********',
                  controller: password,
                ),
                const SizedBox(height: 15),
                InputBox(
                  lebel: 'Confirm Password',
                  placeholder: '**********',
                  controller: confirmPassword,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Checkbox(
                      value: agree,
                      onChanged: (value) {
                        changeAgree(value ?? false);
                      },
                    ),
                    const Text(
                      'I understood the',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const Text(
                      ' terms & policy',
                      style: TextStyle(
                        color: Color(0xff3F51F3),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),

                // BlocListener for success/error handling
                BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if (state is RegisterErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          duration: const Duration(seconds: 12),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          content: Text(state.message),
                        ),
                      );
                    } else if (state is RegisterSuccessState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          content: Text("Registration successful!"),
                        ),
                      );
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                  },
                  child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      if (state is RegisterLoadingState) {
                        return TextButtonWidget(
                          state: state,
                          onPressed: () {},
                          text: 'Signing Up...',
                        );
                      }
                      return TextButtonWidget(
                        state: state,
                        onPressed: () => _signup(context),
                        text: 'Sign Up',
                      );
                    },
                  ),
                ),

                const SizedBox(height: 70),
                BottomLink(
                  text: 'Have an account? ',
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  buttonText: 'SIGN IN',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
