import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:wechive/app/modules/auth/controllers/auth_controller.dart';
import 'package:wechive/core/consts.dart';
import 'package:wechive/core/widgets/Text.dart';
import 'package:wechive/core/widgets/TxtForm.dart';

class SignUp extends GetView<AuthController> {
  const SignUp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: KPink),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Txt(
                      "Please login or create an account ",
                      color: Colors.grey,
                      size: 16,
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
                  obscure: false,
                  editingController: controller.password,
                  validator: MinLengthValidator(6,
                      errorText: "Must be at least 6 digits long"),
                  inputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 12.0),
                TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: KBlue,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(KRaduis + KRaduis))),
                    onPressed: () async =>
                        controller.createAccountWithEmailAndPassword(
                            controller.email.text, controller.password.text),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Txt(
                          "SIGN UP",
                          color: Colors.white,
                          size: 18,
                          weight: FontWeight.bold,
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
