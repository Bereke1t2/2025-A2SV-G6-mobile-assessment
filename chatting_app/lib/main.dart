import 'package:chatting_app/Futures/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:chatting_app/Futures/authentication/presentation/pages/login_page.dart';
import 'package:chatting_app/Futures/authentication/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Futures/authentication/presentation/bloc/authentication_state.dart';
import 'Futures/authentication/presentation/pages/home_page.dart';
import 'Futures/authentication/presentation/pages/splash_screen.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  final AuthenticationBloc authenticationBloc = di.sl<AuthenticationBloc>();

  runApp(
    BlocProvider<AuthenticationBloc>.value(
      value: authenticationBloc,
      child: MaterialApp(
        // home: const ChatHomePage(),
        routes: {
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignupPage(),
          '/splash': (context) => SplashScreen(),
  
          '/home': (context) => HomePage(),
        },
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationInitial) {
              return SplashScreen();
            } else if (state is LoginState) {
              return LoginPage();
            } else if (state is AuthenticationErrorState) {
              return LoginPage();
            } else if (state is RegisterState) {
              return SignupPage();
            } else if (state is AuthorizedState) {
              return HomePage(); 
            } else if (state is UnAuthorizedState) {
              return LoginPage(); 
            }
            // Default widget if no state matches
            return SplashScreen();
          },
        ),//end
      ),
    ),
  );
}
