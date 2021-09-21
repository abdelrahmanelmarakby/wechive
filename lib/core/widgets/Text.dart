import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wechive/core/consts.dart';

class Txt extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight weight;
  final double size;
  const Txt(this.text,
      {this.color = KPink, this.weight = FontWeight.normal, this.size = 16});
  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: color,
        fontWeight: weight,
        fontSize: size,
      ),
    );
  }
}
