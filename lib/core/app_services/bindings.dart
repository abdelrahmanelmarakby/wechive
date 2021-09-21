import 'package:get/get.dart';
import 'package:wechive/app/modules/auth/controllers/auth_controller.dart';
import 'package:wechive/app/modules/bottom_nav_bar/controllers/bottom_nav_bar_controller.dart';
import 'package:wechive/app/modules/home/controllers/home_controller.dart';
import 'package:wechive/app/modules/profile/controllers/profile_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => BottomNavBarController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
  }
}
