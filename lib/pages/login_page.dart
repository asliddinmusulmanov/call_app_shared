import 'package:flutter/material.dart';
import 'package:home_task/models/model.dart';
import 'package:home_task/pages/home_page.dart';
import 'package:home_task/pages/register_page.dart';
import 'package:home_task/services/language_translate.dart';
import 'package:home_task/setup.dart';

import '../services/language_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

TextEditingController loginEmailController = TextEditingController();
TextEditingController loginPasswordController = TextEditingController();

bool isnima = true;

class _LoginPageState extends State<LoginPage> {
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

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Form(
              key: globalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 70),
                  Text(
                    "welcome back! gladto see you, again".tr,
                    style: const TextStyle(
                      color: Color(0xff214E9E),
                      fontWeight: FontWeight.w700,
                      fontSize: 35,
                    ),
                  ),
                  const SizedBox(height: 60),
                  TextFormField(
                    controller: loginEmailController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      label: Text("enter your email".tr),
                      hintStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value != null &&
                          loginEmailController.text.isNotEmpty) {
                        return null;
                      } else {
                        return "please enter your email".tr;
                      }
                    },
                    onChanged: (value) {
                      if (globalKey.currentState!.validate()) {
                        setState(() {});
                      }
                    },
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: loginPasswordController,
                    obscureText: isnima,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      counterStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      // prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          isnima = !isnima;
                          setState(() {});
                        },
                        icon: isnima
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                      label: Text("enter your password".tr),
                      hintStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value != null &&
                          loginPasswordController.text.isNotEmpty) {
                        return null;
                      } else {
                        return "please enter your password".tr;
                      }
                    },
                    onChanged: (value) {
                      if (globalKey.currentState!.validate()) {
                        setState(() {});
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "forgot Password?".tr,
                        style: const TextStyle(
                          color: Color(0xff6A707C),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  IconButton(
                    onPressed: () {},
                    icon: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: Colors.black,
                        ),
                        onPressed: () async {
                          var result = globalKey.currentState!.validate();
                          bool natija = false;
                          List<AuthModel> model = box.values.toList();
                          for (var o in model) {
                            debugPrint('$model');
                            if (o.firstName == loginEmailController.text &&
                                o.lastName == loginPasswordController.text) {
                              natija = true;
                            }
                          }
                          if (result && natija) {
                            token.put("token", true);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "email or password error please try again"
                                        .tr),
                              ),
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60),
                          child: Text(
                            "login".tr,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Stack(
                    children: [
                      const Divider(
                        height: 22,
                        color: Colors.grey,
                        endIndent: 240,
                      ),
                      Align(
                        child: Text(
                          "or login with".tr,
                        ),
                      ),
                      const Divider(
                        height: 22,
                        indent: 240,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "don’t have an account?".tr,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ),
                          );
                        },
                        child: Text(
                          "register now".tr,
                          style: const TextStyle(
                              color: Colors.teal, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
