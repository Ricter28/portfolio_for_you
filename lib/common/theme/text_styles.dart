import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppStyles {
  AppStyles._();
  static const _medium = FontWeight.w400;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;
  static const double _spacing = 02;
  //Heading
  static TextStyle heading4 = GoogleFonts.mulish(
    fontWeight: _bold,
    fontSize: 32.0,
    height: 42 / 32,
  );

  static TextStyle heading6 = GoogleFonts.rubik(
    fontWeight: _bold,
    fontSize: 20.0,
    letterSpacing: _spacing,
  );

  //Body

  static TextStyle body1 = GoogleFonts.mulish(
    fontWeight: _medium,
    fontSize: 16.0,
  );

  static TextStyle body2 = GoogleFonts.mulish(
    fontWeight: _medium,
    fontSize: 14.0,
  );

  //Button
  static TextStyle button = GoogleFonts.mulish(
    fontWeight: _semiBold,
    fontSize: 14.0,
    height: 1,
  );

  static TextStyle button2 = GoogleFonts.mulish(
    fontWeight: _semiBold,
    fontSize: 16.0,
    height: 1,
  );
  
  //Subtitle
  static TextStyle subtitle1 = GoogleFonts.mulish(
    fontWeight: _semiBold,
    fontSize: 16.0,
    height: 20 / 16,
    letterSpacing: _spacing,
  );

  static TextStyle subtitle2 = GoogleFonts.mulish(
    fontWeight: _bold,
    fontSize: 14.0,
    height: 20 / 16,
  );
}
