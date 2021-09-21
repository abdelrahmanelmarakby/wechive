import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
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
        height: 75,
   
        showElevation: true,
        animationCurve: Curves.easeIn,
        animationDuration: Duration(milliseconds: 250),
        backgroundColor: Colors.  blue.shade100,
        selectedIndex: controller.navIndex,
        items: [
          FlashyTabBarItem(
              inactiveColor: KShade,
              activeColor: Colors.black,
              icon: Icon(
                Icons.explore_outlined,
                //  color: Colors.green,
              ),
              title: Text(
                "Home",
              )),
          FlashyTabBarItem(
              inactiveColor: KShade,
              activeColor: Colors.black,
              icon: Icon(
                Icons.account_circle_outlined,
              ),
              title: Text("profile")),
        ],
        onItemSelected: (index) {
          controller.onSelected(index);
        }),
  );
}
