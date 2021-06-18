import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:misson_tasker/model/ApiCaller.dart';
import 'package:misson_tasker/model/api_models/GetProfileDataModel.dart';
import 'package:misson_tasker/model/api_models/NotificationToggle.dart';
import 'package:misson_tasker/utils/AnimatorUtil.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/NavMe.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';
import 'package:misson_tasker/utils/StringsPath.dart';
import 'package:misson_tasker/utils/local_data.dart';

import 'package:misson_tasker/view/startup_screens/SplashScreen.dart';

import 'editProfile.dart';

class ChangeNoticationScreen extends StatefulWidget {
  @override
  _ChangeNoticationScreenState createState() => _ChangeNoticationScreenState();
}

class _ChangeNoticationScreenState extends State<ChangeNoticationScreen> {
  bool isLoading = false;

  String auth = "";
  GetProfileDataModel getProfileDataModel;
  bool isLoadingData = true;

  bool isNotificationOn = true;
  NotificationToggleModel notificationToggleModel;

  @override
  void initState() {
    // registerUser();


    getString(sharedPref.userToken).then((value) {
      auth = value;

      print("123 $value");
    }).whenComplete(() {
      ApiCaller()
          .getProfileData(auth: auth)
          .then((value) => getProfileDataModel = value)
          .whenComplete(() {
        setState(() {
          isLoadingData = false;
          isNotificationOn =
              getProfileDataModel.data.user.isNotify == "1" ? true : false;
        });
      });
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: false,
          title: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Text(
              "Notifications",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenConfig.fontSizelarge,
                  fontFamily: "Product"),
            ),
          ),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 30.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 24.0,
                ),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: isLoadingData == true
            ? Center(child: spinkit)
            : TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: AnimatorUtil.animationSpeedTimeFast,
          builder: (BuildContext context, double val, Widget child) {

            return
              Opacity(
                opacity: val,
                child: Padding(
                  padding: EdgeInsets.only(top: val*30),
                  child: child,
                ),
              );
          },
              child: Stack(
                  children: [
                    Container(
                        // margin: EdgeInsets.only(
                        //     top: ScreenConfig.screenHeight * 0.05),
                        color: Colors.white,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: ListTile(
                                  title: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isNotificationOn = true;
                                      });
                                    },
                                    child: Text(
                                      "On",
                                      style: TextStyle(
                                          fontSize: ScreenConfig.fontSizelarge,
                                          color: isNotificationOn
                                              ? CColors.missonPrimaryColor
                                              : CColors.missonMediumGrey,
                                          fontFamily: "Product"),
                                    ),
                                  ),
                                  trailing: Visibility(
                                    child: SvgPicture.asset(
                                      checkLogo,
                                      height: 15,
                                    ),
                                    visible: isNotificationOn,
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: ListTile(
                                  title: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isNotificationOn = false;
                                      });
                                    },
                                    child: Text(
                                      "Off",
                                      style: TextStyle(
                                          fontSize: ScreenConfig.fontSizelarge,
                                          color: !isNotificationOn
                                              ? CColors.missonPrimaryColor
                                              : CColors.missonMediumGrey,
                                          fontFamily: "Product"),
                                    ),
                                  ),
                                  trailing: Visibility(
                                    child: SvgPicture.asset(
                                      checkLogo,
                                      height: 15,
                                    ),
                                    visible: !isNotificationOn,
                                  )),
                            ),
                          ],
                        )),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 20),
                        child: SizedBox(
                          height: ScreenConfig.screenHeight * 0.06,
                          width: ScreenConfig.screenWidth * 0.70,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isLoading=true;
                              });
                              ApiCaller()
                                  .doNotificationToggle(
                                      auth: auth,
                                      value: isNotificationOn == true ? "1" : "0")
                                  .then(
                                      (value) => notificationToggleModel = value)
                                  .whenComplete(() {

                                    setState(() {
                                      isLoading=false;
                                    });

                                    return showCupertinoDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CupertinoAlertDialog(
                                          title: Text('Info'),
                                          content: Text('${notificationToggleModel.data.message}'),
                                          actions: [
                                            CupertinoDialogAction(
                                              child: Text('OK'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                // NavMe().NavPushReplaceFadeIn(LoginPage());
                                                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> LoginPage()));
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );

                              });
                              // if (_formKey.currentState.validate()) {
                              //   setState(() {
                              //     isLoading = true;
                              //
                              //
                              //
                              //
                              //   });
                              //
                              // } else {}
                            },
                            child: isLoading == true
                                ? spinkit
                                : Text("Save",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                            style: ElevatedButton.styleFrom(
                              primary: CColors.missonButtonColor2, // background
                              onPrimary: CColors.missonButtonColor2, // fo
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(06.0),
                                  side: BorderSide(
                                      color:
                                          CColors.missonButtonColor2) // reground,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ));
  }
}
