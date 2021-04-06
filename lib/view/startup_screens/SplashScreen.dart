import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/NavMe.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';
import 'package:misson_tasker/utils/StringsPath.dart';
// import 'package:misson_tasker/view/HomePage.dart';
import 'package:misson_tasker/view/JobDetailsScreen.dart';
import 'package:misson_tasker/view/startup_screens/LoginPage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 3), (timer) {
      print(timer.toString() + "!!!!");

      NavMe().NavPushReplaceFadeIn(LoginPage());
      // Get.off(JobDetailsScreen(),
      //     transition: Transition.zoom, duration: Duration(milliseconds: 1000));
      timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Center(
            child: SvgPicture.asset(SplashScreenLogo),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                width: ScreenConfig.screenWidth,
                child: Image.asset(SplashBottomAsset,
                    fit: BoxFit.fill, color: CColors.missonGrey)),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
                margin: EdgeInsets.only(top: 30),
                child: Image.asset(SplashTopAsset, color: CColors.missonGrey)),
          )
        ],
      )),
    );
  }
}
