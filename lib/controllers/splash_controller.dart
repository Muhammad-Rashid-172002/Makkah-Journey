import 'dart:async';
import 'package:flutter/material.dart';
import 'package:makkahjourney/Auth_moduls/signupscreen.dart';

class SplashController {
  void startTimer(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SignupScreen()),
      );
    });
  }
}
