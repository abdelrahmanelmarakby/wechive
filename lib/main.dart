import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:wechive/app/modules/auth/views/complete_profile.dart';
import 'package:wechive/app/modules/auth/views/login.dart';
import 'package:wechive/app/modules/bottom_nav_bar/views/splash_screen_screen.dart';
import 'package:wechive/app/modules/home/views/home_view.dart';
import 'package:wechive/core/app_services/bindings.dart';
import 'package:wechive/core/app_services/theme.dart';
import 'package:wechive/core/consts.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    GetMaterialApp(
      initialBinding: Binding(),
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.resize(600, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.resize(1200, name: DESKTOP),
        ],
      ),
      title: "Wechive",
      home: InitializerWidget(),
      getPages: AppPages.routes,
      defaultTransition: Transition.size,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
    ),
  );
}

class InitializerWidget extends StatefulWidget {
  @override
  _InitializerWidgetState createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends State<InitializerWidget> {
  late FirebaseAuth _auth;
//
  User? _user;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      if (_user == null) {
        return Login();
      } else {
        authUserID = _user!.uid;
        return SplashScreen1Sub();
      }
    }
  }
}
