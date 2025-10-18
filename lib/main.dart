import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:makkahjourney/aniamation.dart';
import 'package:makkahjourney/animation2.dart';
import 'package:makkahjourney/animation3.dart';
import 'package:makkahjourney/views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize Hive first
  await Hive.initFlutter();
  await Hive.openBox('checklistBox');

  // ✅ Initialize Firebase before runApp
  await Firebase.initializeApp();

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Makkah Journey',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: LungsAnimationScreen(),
    );
  }
}
