import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_task/pages/home_page.dart';
import 'package:home_task/pages/register_page.dart';
import 'package:home_task/services/language_translate.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyAccount extends StatefulWidget {
  final String phoneNumber;
  const VerifyAccount({super.key, required this.phoneNumber});

  @override
  State<VerifyAccount> createState() => _VerifyAccountState();
}

TextEditingController otp = TextEditingController();

class _VerifyAccountState extends State<VerifyAccount> {
  bool isSnackBarShown = false;
  bool isDialogShown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("${widget.phoneNumber}ga tasdiqlash kodi yuborildi".tr),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            child: PinCodeTextField(
              controller: otp,
              obscureText: true,
              keyboardType: TextInputType.number,
              appContext: context,
              length: 6,
              cursorHeight: 90,
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              pinTheme: PinTheme(
                selectedColor: Colors.amber,
                activeColor: Colors.green,
                shape: PinCodeFieldShape.box,
                borderWidth: 1,
                fieldWidth: 40,
                fieldHeight: 50,
                inactiveColor: Colors.indigoAccent,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: Colors.green,
            ),
            onPressed: () async {
              debugPrint(otp.text);
              if (await myauth.verifyOTP(otp: otp.text) == true) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("invalid OTP".tr),
                ));
              }
            },
            child: Text(
              "confirm".tr,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void showCustomAlert(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
