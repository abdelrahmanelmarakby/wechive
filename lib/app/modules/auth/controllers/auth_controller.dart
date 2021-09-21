import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:wechive/app/routes/app_pages.dart';
import 'package:wechive/core/consts.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var verId = '';
  var authStatus = ''.obs;
  bool isPhoneOk = false;
  final phone = TextEditingController();
  final otp = TextEditingController();
  var auth = FirebaseAuth.instance;
  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  StreamController<ErrorAnimationType>? errorController;

  RxBool hasError = false.obs;
  RxString currentText = "".obs;

  verifyPhone(String phone) async {
    isLoading.value = true;
    await auth.verifyPhoneNumber(
        timeout: Duration(seconds: 70),
        phoneNumber: phone,
        verificationCompleted: (AuthCredential authCredential) {
          print("Login Successfully");
          if (auth.currentUser != null) {
            isLoading.value = false;
            authStatus.value = "login successfully";
          }
        },
        verificationFailed: (authException) {
          Get.snackbar("sms code info", "otp code hasn't been sent!!");
        },
        codeSent: (String id, [int? forceResent]) {
          print("Code Sent $id");

          isLoading.value = false;
          this.verId = id;
          authStatus.value = "login successfully";
        },
        codeAutoRetrievalTimeout: (String id) {
          this.verId = id;
        });
  }

  /////////
  Future<bool> otpVerify(String otp) async {
    isLoading.value = true;
    try {
      print("trying to verify");

      UserCredential userCredential = await auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: this.verId, smsCode: otp));
      if (userCredential.user != null) {
        isLoading.value = false;
        Get.offAllNamed(Routes.HOME);
        user!.displayname = auth.currentUser!.displayName.toString();
        user!.email = auth.currentUser!.email.toString();
        user!.phoneNumber = auth.currentUser!.phoneNumber.toString();
        user!.photoUrl = auth.currentUser!.photoURL.toString();
      }
    } on Exception catch (e) {
      Get.snackbar("otp info", " ${e.toString()}");
    }
    return false;
  }

  @override
  void onInit() {
    errorController = StreamController<ErrorAnimationType>();
    super.onInit();
  }
}
