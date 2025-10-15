import 'dart:async';
import 'package:flutter/material.dart';
import 'package:makkahjourney/views/home_screen.dart';

class SplashController {
  void startTimer(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    });
  }
}
