import 'package:flutter/material.dart';

class AnimatorUtil {
  static var animationSpeedTimeNormal;
  static var animationSpeedTimeFast;
  static var animationSpeedTimeXFast;
  static var animationSpeedTimeXXFast;
  static var animationSpeedTimeXXXFast;
  static var animationSpeedTime4XFast;
  static var animationSpeedTime5XFast;
  static var animationSpeedTimeSlow;
  static var animationSpeedTimeXSlow;
  static var animationSpeedTimeXXSlow;
  static var animationSpeedTimeXXXSlow;
  static var animationSpeedTime4XSlow;
  static var animationSpeedTime5XSlow;

  void init(BuildContext context) {
    animationSpeedTimeNormal = Duration(milliseconds: 700);
    animationSpeedTimeFast = Duration(milliseconds: 600);
    animationSpeedTimeXFast = Duration(milliseconds: 500);
    animationSpeedTimeXXFast = Duration(milliseconds: 400);
    animationSpeedTimeXXXFast = Duration(milliseconds: 300);
    animationSpeedTime4XFast = Duration(milliseconds: 200);
    animationSpeedTime5XFast = Duration(milliseconds: 100);
    animationSpeedTimeSlow = Duration(milliseconds: 800);
    animationSpeedTimeXSlow = Duration(milliseconds: 900);
    animationSpeedTimeXXSlow = Duration(milliseconds: 1000);
    animationSpeedTimeXXXSlow = Duration(milliseconds: 1100);
    animationSpeedTime4XSlow = Duration(milliseconds: 1200);
    animationSpeedTime5XSlow = Duration(milliseconds: 1300);
  }
}
