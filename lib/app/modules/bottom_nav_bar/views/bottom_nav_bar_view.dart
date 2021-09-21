import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wechive/core/consts.dart';

import '../controllers/bottom_nav_bar_controller.dart';

class BottomNavBarView extends GetView<BottomNavBarController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }
}

_bottomNavigationBar() {
  return GetBuilder<BottomNavBarController>(
    init: BottomNavBarController(),
    builder: (controller) => FlashyTabBar(
        showElevation: false,
        animationDuration: Duration(milliseconds: 250),
        backgroundColor: Colors.green.shade50,
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
                "explore",
              )),
          FlashyTabBarItem(
              inactiveColor: KShade,
              activeColor: Colors.black,
              icon: Icon(
                Icons.shopping_basket_outlined,
                //color: Colors.green,
              ),
              title: Text("cart")),
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
