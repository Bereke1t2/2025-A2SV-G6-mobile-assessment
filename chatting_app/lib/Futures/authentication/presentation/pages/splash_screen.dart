
import 'package:chatting_app/Futures/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/ecom_name_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
        BlocProvider.of<AuthenticationBloc>(context).add(CheckAuthStatusRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/splash.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Color(0xff3F51F3).withOpacity(0.75), // Semi-transparent overlay
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Ecom(
                  height: 115,
                  width: 264,
                  fontSize: 90,
                  radius: 31,
                ),
                SizedBox(height: 20),
                Text(
                  'ECOMMERCE APP',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500 , color: Colors.white , fontFamily: 'Poppins'),  
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}