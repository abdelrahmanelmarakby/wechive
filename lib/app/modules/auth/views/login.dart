import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:wechive/app/modules/auth/controllers/auth_controller.dart';
import 'package:wechive/app/modules/auth/views/signup.dart';
import 'package:wechive/core/consts.dart';
import 'package:wechive/core/widgets/Text.dart';
import 'package:wechive/core/widgets/TxtForm.dart';

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
          child: AutofillGroup(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30.0),
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
                      onTap: () => Get.to(SignUp()),
                      child: Txt(
                        "SIGNUP ",
                        color: KBlue,
                        size: 20,
                        weight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                TxtForm(
                  textFieldName: "User name",
                  editingController: controller.userName,
                  autofillHints: [
                    AutofillHints.nickname,
                    AutofillHints.username,
                    AutofillHints.familyName
                  ],
                  keyboardType: TextInputType.name,
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Must not be empty"),
                    MinLengthValidator(4,
                        errorText: "Must be more than 4 digits"),
                    PatternValidator(
                        r"^(?=.{4,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$",
                        errorText: "Must be a valid user name")
                  ]),
                  textFieldHint: "Your-name",
                ),
                const SizedBox(height: 8.0),
                TxtForm(
                  textFieldName: "Email",
                  editingController: controller.email,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: [
                    AutofillHints.email,
                  ],
                  validator: MultiValidator([
                    EmailValidator(errorText: "Must be a valid email address"),
                    RequiredValidator(errorText: "Can't be empty")
                  ]),
                  textFieldHint: "example@mail.com",
                ),
                const SizedBox(height: 8.0),
                TxtForm(
                  textFieldName: "Password",
                  obscure: true,
                  editingController: controller.password,
                  validator: MinLengthValidator(6,
                      errorText: "Must be at least 6 digits long"),
                  inputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Txt(
                        "OR",
                        size: 20,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
                TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: KBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(KRaduis + KRaduis))),
                    onPressed: () async => controller.signInWithGoogle(),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/g-logo.png",
                          height: 50,
                        ),
                        const SizedBox(width: 35.0),
                        Txt(
                          "Sign in with google",
                          weight: FontWeight.bold,
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
