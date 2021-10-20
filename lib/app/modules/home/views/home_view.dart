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
      body: FutureBuilder<List>(
        future: FirebaseData.getAllRooms(),
        builder: (context, snapshot) {
          List data = snapshot.data as List;
          if (snapshot.hasData)
            return SingleChildScrollView(
              child: Column(
                children: List.generate(
                    data.length,
                    (index) => Card(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .2,
                            child: Column(
                              children: [
                                Txt(
                                  data[index]['name'],
                                  size: 20,
                                  weight: FontWeight.bold,
                                ),
                                Txt(data[index]['interests'].toString()),
                                Txt(data[index]['tasks'].toString()),
                                Txt(data[index]['goals'].toString()),
                                Txt(data[index]['desc']),
                              ],
                            ),
                          ),
                        )),
              ),
            );
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
