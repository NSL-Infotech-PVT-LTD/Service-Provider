import 'package:flutter/widgets.dart';

class ScreenConfig {
  static var screenHeight;
  static var screenWidth;
  static double widgetPaddingXLarge;
  static double widgetPaddingLarge;
  static double widgetPaddingMedium;
  static double widgetPaddingSmall;
  static double widgetPaddingXSmall;

  void init(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    widgetPaddingXLarge = 50;
    widgetPaddingLarge = 25;
    widgetPaddingMedium = 10;
    widgetPaddingSmall = 5;
    widgetPaddingXSmall = 2.5;
  }
}
