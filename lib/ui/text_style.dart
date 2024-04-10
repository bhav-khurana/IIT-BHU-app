import 'package:flutter/material.dart';

class Style {
  static final boldHeadingStyle = TextStyle(
      fontSize: 28.0,
      color: Colors.black,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.0);
  static final headingStyle = TextStyle(
      fontSize: 28.0,
      color: Color(0xffF3F9FF),
      fontWeight: FontWeight.bold,
      letterSpacing: 1.0);
  static final baseTextStyle = const TextStyle(fontFamily: 'Gilroy');
  static final smallTextStyle = commonTextStyle.copyWith(fontSize: 9.0);
  static final mediumTextStyle = commonTextStyle.copyWith(fontSize: 12.0);
  static final commonTextStyle = baseTextStyle.copyWith(
    color: const Color.fromRGBO(23, 110, 222, 0.75),
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  );
  static final titleTextStyle = baseTextStyle.copyWith(
      color: Color(0xff176EDE), fontSize: 18.0, fontWeight: FontWeight.w600);
  static final headerTextStyle = baseTextStyle.copyWith(
      color: Color(0xff176EDE), fontSize: 24.0, fontWeight: FontWeight.w700);
}
