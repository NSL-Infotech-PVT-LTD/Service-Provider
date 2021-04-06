import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavMe {
  NavPushRightToLeft(dynamic page) {
    Get.to(page,
        transition: Transition.rightToLeftWithFade,
        duration: Duration(milliseconds: 500));
  }

  NavPushRepleaceRightToLeft(dynamic page) {
    Get.off(page,
        transition: Transition.rightToLeftWithFade,
        duration: Duration(milliseconds: 500));
  }

  NavPushLeftToRight(dynamic page) {
    Get.to(page,
        transition: Transition.leftToRightWithFade,
        duration: Duration(milliseconds: 400));
  }

  NavPushReplaceLeftToRight(dynamic page) {
    Get.off(page,
        transition: Transition.leftToRightWithFade,
        duration: Duration(milliseconds: 400));
  }

  NavPushFadeIn(dynamic page) {
    Get.to(page,
        transition: Transition.fadeIn, duration: Duration(milliseconds: 400));
  }

  NavPushReplaceFadeIn(dynamic page) {
    Get.off(page,
        transition: Transition.fadeIn, duration: Duration(milliseconds: 1000));
  }

  NavPushZoom(dynamic page) {
    Get.to(page,
        transition: Transition.zoom, duration: Duration(milliseconds: 400));
  }

  NavPushReplaceZoom(dynamic page) {
    Get.off(page,
        transition: Transition.zoom, duration: Duration(milliseconds: 400));
  }
}
