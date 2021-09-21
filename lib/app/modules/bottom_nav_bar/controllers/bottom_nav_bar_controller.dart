import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wechive/app/modules/home/views/home_view.dart';
import 'package:wechive/app/modules/profile/views/profile_view.dart';

class BottomNavBarController extends GetxController {
  Widget _currentScreen = HomeView();

  get CurrentScreen => _currentScreen;

  int _navIndex = 0;
  get navIndex => _navIndex;
  onSelected(int index) {
    _navIndex = index;
    switch (index) {
      case 0:
        {
          _currentScreen = HomeView();
          break;
        }
      case 1:
        {
          _currentScreen = ProfileView();
          break;
        }
    }
    update();
  }
}
