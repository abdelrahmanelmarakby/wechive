import 'package:get/get.dart';

import 'package:wechive/app/modules/add_room/bindings/add_room_binding.dart';
import 'package:wechive/app/modules/add_room/views/add_room_view.dart';
import 'package:wechive/app/modules/bottom_nav_bar/views/bottom_nav_bar_view.dart';
import 'package:wechive/app/modules/home/bindings/home_binding.dart';
import 'package:wechive/app/modules/home/views/home_view.dart';
import 'package:wechive/app/modules/profile/views/profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
    ),
    GetPage(
      name: _Paths.BOTTOM_NAV_BAR,
      page: () => BottomNavBarView(),
    ),
    GetPage(
      name: _Paths.ADD_ROOM,
      page: () => AddRoomView(),
      binding: AddRoomBinding(),
    ),
  ];
}
