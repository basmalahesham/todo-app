import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/moduls/login/login_view.dart';
import 'package:untitled3/provider/settings_provider.dart';

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
    var provider = Provider.of<SettingsProvider>(context);
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Image.asset(
        provider.getMainSplash(),
        height: mediaQuery.height,
        width: mediaQuery.width,
        fit: BoxFit.fill,
      ),
    );
  }
}
