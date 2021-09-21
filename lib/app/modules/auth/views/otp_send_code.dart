import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wechive/app/modules/auth/views/otp_verify_code.dart';
import 'package:wechive/core/consts.dart';
import 'package:wechive/core/widgets/Text.dart';

import '../controllers/auth_controller.dart';

class OtpLoginSend extends GetView<AuthController> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: controller.isLoading(false)
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .1,
                          ),
                          Container(
                            child: login,
                            width: MediaQuery.of(context).size.width * .5,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .1,
                          ),
                          Form(
                              child: Column(
                            children: [
                              Container(
                                child: TextFormField(
                                  autofillHints: [
                                    AutofillHints.telephoneNumber
                                  ],
                                  autovalidateMode: AutovalidateMode.always,
                                  controller: controller.phone,
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    String pattern = r'^01[0-2,5]{1}[0-9]{8}$';
                                    RegExp regExp = RegExp(pattern);
                                    if (value!.length == 0) {
                                      return 'Please enter mobile number';
                                    } else if (!regExp.hasMatch(value)) {
                                      return 'Please enter valid mobile number';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      labelText: "Phone number".tr,
                                      focusedBorder: UnderlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          borderSide:
                                              BorderSide(color: Colors.green)),
                                      fillColor:
                                          Colors.grey.shade50.withOpacity(.5),
                                      filled: true,
                                      border: UnderlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6))),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 40, bottom: 5),
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        KRaduis)),
                                            backgroundColor: KBlue,
                                            minimumSize: Size(
                                                MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                KButtonHeight)),
                                        onPressed: () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            controller.verifyPhone(
                                                "+20" + controller.phone.text);
                                            Get.to(OtpLoginVerify());
                                          } else {
                                            Get.snackbar("Phone not valid",
                                                "Please enter a valid Egyptian phone number",
                                                icon: Icon(Icons.error,
                                                    color: Colors.red),
                                                colorText: Colors.red);
                                          }
                                        },
                                        child: Txt(
                                          "Send verification code",
                                          color: Colors.white,
                                          size: 16,
                                          weight: FontWeight.bold,
                                        ),
                                      ))),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * .2,
                              ),
                            ],
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
              ));
  }
}
