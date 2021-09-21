import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wechive/app/modules/home/views/home_view.dart';
import 'package:wechive/app/modules/profile/views/profile_view.dart';

class BottomNavBarController extends GetxController {
  Widget _currentScreen = HomeView();

  get CurrentScreen => _currentScreen;

  final RxInt _navIndex = 0.obs;
  get navIndex => _navIndex.value;
  onSelected(int index) {
    _navIndex.value = index;
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
