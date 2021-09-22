import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wechive/core/consts.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SafeArea(
              child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                child: Image.network(user!.photoUrl),
              ),
            )
          ],
        ),
      ))),
    );
  }
}
