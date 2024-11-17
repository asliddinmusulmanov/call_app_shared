import 'package:flutter/material.dart';
import 'package:home_task/pages/register_page.dart';
import 'package:home_task/services/language_translate.dart';

import '../services/language_service.dart';
import '../setup.dart';
import 'login_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String? til = service.read("til");

  Future<void> dropCall(String? selectValue) async {
    if (selectValue is String) {
      setState(() {
        til = selectValue;
        service.store("til", selectValue);
      });
    }
    LanguageService.switchLanguage(til!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          DropdownButton(
            value: til,
            items: const [
              DropdownMenuItem(
                value: "1",
                child: Row(
                  children: [
                    Text("🇺🇿 O'zbek"),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: "2",
                child: Row(
                  children: [
                    Text(" 🇬🇧 England"),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: "3",
                child: Row(
                  children: [
                    Text(" 🇷🇺 Rus"),
                  ],
                ),
              ),
            ],
            onChanged: dropCall,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 550),
              WOutlineButton(
                text: 'login'.tr,
                colors: Colors.black,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              WOutlineButton(
                text: 'register'.tr,
                colors: Colors.white,
                textColor: Colors.black,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 60, left: 150),
        child: Text(
          "continue as a guest".tr,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xff35C2C1),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class WOutlineButton extends StatelessWidget {
  final String text;
  final Color colors;
  final Color textColor;
  final Function()? onPressed;

  const WOutlineButton({
    super.key,
    required this.text,
    required this.colors,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: colors,
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
