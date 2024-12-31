import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nepaliapp/UI/login_screen.dart';
import 'package:nepaliapp/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Utils().primaryColor),
        useMaterial3: true,
      ),
      home: const Login(),
    );
  }
}
