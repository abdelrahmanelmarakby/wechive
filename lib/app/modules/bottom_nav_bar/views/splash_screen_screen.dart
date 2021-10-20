import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wechive/app/modules/bottom_nav_bar/views/bottom_nav_bar_view.dart';
import 'package:wechive/core/consts.dart';
import 'package:wechive/core/widgets/Text.dart';

class SplashScreen1Sub extends StatefulWidget {
  @override
  _SplashScreen1SubState createState() => _SplashScreen1SubState();
}

class _SplashScreen1SubState extends State<SplashScreen1Sub>
    with TickerProviderStateMixin {
  double _fontSize = 2;
  double _containerSize = 1.5;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;

  late AnimationController _controller;
  late Animation<double> animation1;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    animation1 = Tween<double>(begin: 120, end: 20).animate(CurvedAnimation(
        parent: _controller, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });

    _controller.forward();

    Timer(Duration(seconds: 2), () {
      setState(() {
        _fontSize = 1.06;
      });
    });

    Timer(Duration(seconds: 2), () {
      setState(() {
        _containerSize = 2;
        _containerOpacity = 1;
      });
    });

    Timer(Duration(seconds: 4), () {
      setState(() {
        Navigator.pushReplacement(
            context, PageTransition1(SplashScreen1SubHome()));
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                AnimatedContainer(
                    duration: Duration(milliseconds: 700),
                    curve: Curves.easeInOutQuint,
                    height: _height / _fontSize),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 700),
                  opacity: _textOpacity,
                  child: Txt(
                    'Be better togather'.toUpperCase(),
                   weight: FontWeight.bold,
                   size: 24,
                    color: KPink,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 700),
              curve: Curves.fastLinearToSlowEaseIn,
              opacity: _containerOpacity,
              child: AnimatedContainer(
                  duration: Duration(milliseconds: 700),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: _width / _containerSize,
                  width: _width / _containerSize,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Image.asset(
                    'assets/images/logo.png',
                    color: KBlue,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

class PageTransition1 extends PageRouteBuilder {
  final Widget page;

  PageTransition1(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.easeIn,
              parent: animation,
            );
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}

class SplashScreen1SubHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavBarView();
  }
}
