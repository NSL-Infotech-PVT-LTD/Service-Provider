import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/NavMe.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';
import 'package:misson_tasker/utils/SharedStrings.dart';
import 'package:misson_tasker/utils/StringsPath.dart';
import 'package:misson_tasker/utils/local_data.dart';
import 'package:misson_tasker/view/Dashboard.dart';
// import 'package:misson_tasker/view/HomePage.dart';
import 'package:misson_tasker/view/JobDetailsScreen.dart';
import 'package:misson_tasker/view/startup_screens/LoginPage.dart';
SharedPref sharedPref= new SharedPref();
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String _auth=null;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    // clearedShared();

    Timer.periodic(Duration(seconds: 3), (timer) {
      print(timer.toString() + "!!!!");

      getString(sharedPref.userToken).then((value) => _auth=value).whenComplete(() {

        if(_auth!=null)
        {
          // NavMe().NavPushReplaceFadeIn(Dashboard());
          Get.off(()=> Dashboard(),
              transition: Transition.fadeIn, duration: Duration(milliseconds: 1500));
        }
        else
        {
          NavMe().NavPushReplaceFadeIn(LoginPage());
        }

      });



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
