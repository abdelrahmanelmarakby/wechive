import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wechive/core/consts.dart';

class Txt extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight weight;
  final double size;
  final TextAlign textAlign;
  const Txt(this.text,
      {this.color = KBlue,
      this.weight = FontWeight.normal,
      this.size = 16,
      this.textAlign = TextAlign.center});
  @override
  Widget build(BuildContext context) {
    return Text(
      text.toString(),
      overflow: TextOverflow.visible,
      softWrap: true,
      textAlign: textAlign,
      style: GoogleFonts.cairo(
        color: color,
        fontWeight: weight,
        fontSize: size,
      ),
    );
  }
}
