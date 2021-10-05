import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wechive/app/modules/auth/controllers/auth_controller.dart';
import 'package:wechive/core/consts.dart';
import 'package:wechive/core/widgets/Text.dart';

class Login extends GetView<AuthController> {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Txt(
                "Welcome ,",
                color: KBlue,
                size: 28,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Txt(
                    "Please login or create an account ",
                    color: Colors.grey,
                    size: 16,
                  ),
                  GestureDetector(
                    child: Txt(
                      "SIGNUP ",
                      color: KBlue,
                      size: 20,
                      weight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
