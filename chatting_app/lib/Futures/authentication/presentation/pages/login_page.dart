import 'package:chatting_app/Futures/authentication/presentation/widgets/buttom_link.dart';
import 'package:chatting_app/Futures/authentication/presentation/widgets/ecom_name_widget.dart';
import 'package:chatting_app/Futures/authentication/presentation/widgets/input_box.dart';
import 'package:chatting_app/core/ui/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../bloc/authentication_bloc.dart';
import '../bloc/authentication_state.dart';
import '../widgets/bold_text.dart';
import '../widgets/text_button.dart' as custom;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onSignIn(BuildContext context) {
    if (!Validate(
      null,
      emailController,
      passwordController,
      null,
      true,
    ).isValid(context)) {
      return;
    }

    context.read<AuthenticationBloc>().add(
      LoginRequested(
        LoginParams(
          email: emailController.text,
          password: passwordController.text,
        ),
      ),
    );
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Ecom(height: 65, width: 148, fontSize: 48, radius: 22),
                const SizedBox(height: 80),
                const BoldText(text: 'Sign into your account', fontSize: 24),
                const SizedBox(height: 30),
                InputBox(
                  lebel: 'Email',
                  placeholder: 'ex: jon.smith@email.com',
                  controller: emailController,
                ),
                const SizedBox(height: 15),
                InputBox(
                  lebel: 'Password',
                  placeholder: '**********',
                  controller: passwordController,
                ),
                const SizedBox(height: 20),

                // BlocListener for side effects (snackbars, navigation)
                BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if (state is LoginErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          duration: const Duration(seconds: 30),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          content: Text(state.message),
                        ),
                      );
                    } else if (state is LoginSuccessState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          content: Text("Login successful!"),
                        ),
                      );
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                  },
                  child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      if (state is LoginLoadingState) {
                        return custom.TextButtonWidget(
                          state: state,
                          text: 'Signing In...',
                          onPressed: () {},
                        );
                      }
                      return custom.TextButtonWidget(
                        state: state,
                        text: 'SIGN IN',
                        onPressed: () => _onSignIn(context),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 100),
                BottomLink(
                  text: 'Don’t have an account?',
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/signup');
                  },
                  buttonText: "SIGN UP",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
