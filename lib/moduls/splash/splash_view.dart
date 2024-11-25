import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled3/layout/home_layout.dart';

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
      Navigator.of(context).pushReplacementNamed(HomeLayoutView.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/splash.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
