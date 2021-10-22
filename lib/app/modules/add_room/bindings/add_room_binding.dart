import 'package:get/get.dart';

import '../controllers/add_room_controller.dart';

class AddRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddRoomController>(
      () => AddRoomController(),
    );
  }
}
