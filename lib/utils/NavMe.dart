import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavMe {
  NavPushRightToLeft( page) {
    Get.to(page,
        transition: Transition.rightToLeftWithFade,
        duration: Duration(milliseconds: 500));
  }

  NavPushRepleaceRightToLeft( page) {
    Get.off(page,
        transition: Transition.rightToLeftWithFade,
        duration: Duration(milliseconds: 500));
  }

  NavPushLeftToRight(page) {
    Get.to(page,
        transition: Transition.leftToRightWithFade,
        duration: Duration(milliseconds: 400));
  }

  NavPushReplaceLeftToRight( page) {
    Get.off(page,
        transition: Transition.leftToRightWithFade,
        duration: Duration(milliseconds: 400));
  }

  NavPushFadeIn(page) {
    Get.to(page,
        transition: Transition.fadeIn, duration: Duration(milliseconds: 400));
  }

  NavPushReplaceFadeIn(page) {
    Get.off(page,
        transition: Transition.fadeIn, duration: Duration(milliseconds: 1000));
  }

  NavPushZoom( page) {
    Get.to(page,
        transition: Transition.zoom, duration: Duration(milliseconds: 400));
  }

  NavPushReplaceZoom( page) {
    Get.off(page,
        transition: Transition.zoom, duration: Duration(milliseconds: 400));
  }
}
