import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:home_task/models/model.dart';
import 'package:home_task/pages/otp_page.dart';
import 'package:home_task/services/language_translate.dart';
import 'package:home_task/setup.dart';

import '../services/language_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

TextEditingController userNameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmpasswordController = TextEditingController();
EmailOTP myauth = EmailOTP();

class _RegisterPageState extends State<RegisterPage> {
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
                  const SizedBox(height: 30),
                  Text(
                    "welcome back! glad to see you, again".tr,
                    style: const TextStyle(
                      color: Color(0xff1E232C),
                      fontWeight: FontWeight.w700,
                      fontSize: 35,
                    ),
                  ),
                  const SizedBox(height: 60),
                  TextFormField(
                    controller: userNameController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      label: Text("username".tr),
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
                      if (value != null && userNameController.text.isNotEmpty) {
                        return null;
                      } else {
                        return "please enter your username".tr;
                      }
                    },
                    onChanged: (value) {
                      if (globalKey.currentState!.validate()) {
                        setState(() {});
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      counterStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      label: Text("email".tr),
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
                      if (value != null && value.contains("@gmail.com")) {
                        return null;
                      } else {
                        return 'please enter your email address Example => (example@gmail.com)'
                            .tr;
                      }
                    },
                    onChanged: (value) {
                      if (globalKey.currentState!.validate()) {
                        setState(() {});
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      counterStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      labelText: "password".tr,
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
                      RegExp regex = RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
                      if (value != null && value.contains(regex)) {
                        return null;
                      } else {
                        return 'must be 8 or more characters  and contain at least 1 number or special character'
                            .tr;
                      }
                    },
                    onChanged: (value) {
                      if (globalKey.currentState!.validate()) {
                        setState(() {});
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: confirmpasswordController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_open),
                      counterStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      labelText: "confirm password".tr,
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
                      if (value == passwordController.text) {
                        return null;
                      } else {
                        return "the verification password is incorrect".tr;
                      }
                    },
                    onChanged: (value) {
                      if (globalKey.currentState!.validate()) {
                        setState(() {});
                      }
                    },
                  ),
                  const SizedBox(height: 60),
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
                          if (result) {
                            token.put("token", true);
                            AuthModel authModel = AuthModel(
                                firstName: emailController.text,
                                lastName: passwordController.text);
                            box.add(authModel);
                            debugPrint(
                                'Natija :${box.values.toList().toString()}');
                            myauth.setConfig(
                                appEmail: "me@rohitchouhan.com",
                                appName: "Email OTP",
                                userEmail: emailController.text,
                                otpLength: 6,
                                otpType: OTPType.digitsOnly);
                            if (await myauth.sendOTP() == true) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("OTP has been sent"),
                              ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Oops, OTP send failed"),
                              ));
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VerifyAccount(
                                      phoneNumber: emailController.text)),
                            );
                          } else {}
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60),
                          child: Text(
                            "register".tr,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
