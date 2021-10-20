import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wechive/core/consts.dart';

import '../controllers/bottom_nav_bar_controller.dart';

class BottomNavBarView extends GetView<BottomNavBarController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavBarController>(
      init: BottomNavBarController(),
      builder: (BottomNavBarController controller) {
        return Scaffold(
          body: controller.CurrentScreen,
          bottomNavigationBar: _bottomNavigationBar(controller),
        );
      },
    );
  }
}

_bottomNavigationBar(BottomNavBarController controller) {
  return Obx(
    () => FlashyTabBar(
        animationCurve: Curves.easeIn,
        animationDuration: Duration(milliseconds: 250),
        selectedIndex: controller.navIndex,
        items: [
          FlashyTabBarItem(
              inactiveColor: KShade,
              activeColor: KBlue,
              icon: Icon(
                Icons.explore_outlined,
                //  color: Colors.green,
              ),
              title: Text(
                "Explore",
                style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                ),
              )),
          FlashyTabBarItem(
              inactiveColor: KShade,
              activeColor: KBlue,
              icon: Icon(
                Ionicons.add_circle_outline,
              ),
              title: Text(
                "Add Room",
                style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                ),
              )),
          FlashyTabBarItem(
              inactiveColor: KShade,
              activeColor: KBlue,
              icon: Icon(
                Ionicons.person_circle_outline,
              ),
              title: Text(
                "Profile",
                style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                ),
              )),
        ],
        onItemSelected: (index) {
          controller.onSelected(index);
        }),
  );
}
