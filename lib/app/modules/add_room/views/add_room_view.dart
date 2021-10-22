import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_room_controller.dart';

class AddRoomView extends GetView<AddRoomController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AddRoomView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AddRoomView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
