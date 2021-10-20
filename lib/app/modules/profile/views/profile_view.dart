import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wechive/core/consts.dart';
import 'package:wechive/core/widgets/Text.dart';
import 'package:wechive/data/firestore_data.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    //  print(user);
    return Scaffold(
      body: FutureBuilder(
        future: FirebaseData.getProfile(authUserID),
        builder: (context, snapshot) {
          var data = snapshot.data;
          return Center(child: Txt(data.toString()));
        },
      ),
    );
  }
}
