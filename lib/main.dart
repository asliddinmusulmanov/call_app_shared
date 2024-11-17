import 'package:flutter/material.dart';
import 'package:home_task/pages/home_page.dart';
import 'package:home_task/pages/welcome_page.dart';
import 'package:home_task/setup.dart';

void main() async {
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool logout = token.get("token") ?? false;
    return MaterialApp(
      // home: VerifyAccount(phoneNumber: emailController.text),
      home: logout ? const HomePage() : const WelcomePage(),
    );
  }
}
