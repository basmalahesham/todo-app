import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled3/moduls/login/login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  static const String routeName = "splash";

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(
        const Duration(
          seconds: 2,
        ), () {
      Navigator.of(context).pushReplacementNamed(LoginView.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Image.asset(
        'assets/images/splash.png',
        height: mediaQuery.height,
        width: mediaQuery.width,
        fit: BoxFit.fill,
      ),
    );
  }
}
