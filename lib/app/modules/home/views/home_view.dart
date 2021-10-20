import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wechive/app/modules/auth/views/complete_profile.dart';
import 'package:wechive/core/consts.dart';
import 'package:wechive/core/widgets/Text.dart';
import 'package:wechive/data/firestore_data.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FirebaseData.getAllRooms(),
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (snapshot.hasData)
            return Center(child: Txt(data.toString()));
          else
            return Center(
              child: CircularProgressIndicator(
                color: KBlue,
              ),
            );
        },
      ),
    );
  }
}
