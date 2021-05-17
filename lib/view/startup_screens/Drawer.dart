import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:misson_tasker/TokenMonitor.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/NavMe.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';
import 'package:misson_tasker/utils/StringsPath.dart';
import 'package:misson_tasker/utils/local_data.dart';
import 'package:misson_tasker/view/DrawerScreens/MissionHistoryScreen.dart';
import 'package:misson_tasker/view/ProfileView/SettingPage.dart';
import 'package:misson_tasker/view/ProfileView/editProfile.dart';
import 'package:misson_tasker/view/startup_screens/LoginPage.dart';
import 'package:misson_tasker/view/startup_screens/SplashScreen.dart';

class MyDrawer extends StatefulWidget {
  String username;
  String ImageUrl;

  MyDrawer({@required this.username, this.ImageUrl});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  // static String username = "";
  var data;




  getSharedPref(widget) {
    getString(sharedPref.userNetworkImage).then((value) {
      widget.ImageUrl = value;

      print("123 $value");
    });
    getString(sharedPref.userName).then((value) {
      widget.username = value;

      print("123 $value");
    }).whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CColors.missonPrimaryColor,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,

        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: CircleAvatar(
                        backgroundImage: widget.ImageUrl == null
                            ? AssetImage(avatar1)
                            : NetworkImage(widget.ImageUrl),
                        radius: 45,
                      )),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text("${widget.username}",
                              style: TextStyle(
                                  color: CColors.missonNormalWhiteColor,
                                  fontSize: ScreenConfig.fontSizeXlarge),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            "Tasker",
                            style: TextStyle(
                                color: CColors.missonSignUpButtonColor),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            // NavMe().NavPushLeftToRight(EditProfile());

                            Get.to(EditProfile(),
                                    transition: Transition.leftToRightWithFade,
                                    duration: Duration(milliseconds: 400))
                                .then((value) {
                              getSharedPref(widget);
                            });
                          },
                          child: Text(
                            "Edit Profile",
                            style: TextStyle(color: CColors.missonSkyBlue),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: CColors.missonPrimaryColor,
            ),
          ),
          Divider(
            color: CColors.missonDividerGrey,
          ),
          Column(
            children: [
              SizedBox(
                height: ScreenConfig.screenHeight * 0.07,
              ),
              ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dashboard',
                      style: TextStyle(
                          color: CColors.missonNormalWhiteColor,
                          fontSize: ScreenConfig.fontSizeXlarge),
                    ),
                    Container(
                      width: ScreenConfig.screenWidth * 0.4,
                      child: Divider(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the MyDrawer
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: ScreenConfig.widgetPaddingLarge,
              ),
              ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Missions History',
                      style: TextStyle(
                          color: CColors.missonNormalWhiteColor,
                          fontSize: ScreenConfig.fontSizeXlarge),
                    ),
                    Container(
                      width: ScreenConfig.screenWidth * 0.4,
                      child: Divider(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the MyDrawer
                  // Navigator.pop(context);
                  NavMe().NavPushLeftToRight(MissionHistoryScreen());
                },
              ),
              SizedBox(
                height: ScreenConfig.widgetPaddingLarge,
              ),
              ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Missions Review',
                      style: TextStyle(
                          color: CColors.missonNormalWhiteColor,
                          fontSize: ScreenConfig.fontSizeXlarge),
                    ),
                    Container(
                      width: ScreenConfig.screenWidth * 0.4,
                      child: Divider(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the MyDrawer
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: ScreenConfig.widgetPaddingLarge,
              ),
              ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment History',
                      style: TextStyle(
                          color: CColors.missonNormalWhiteColor,
                          fontSize: ScreenConfig.fontSizeXlarge),
                    ),
                    Container(
                      width: ScreenConfig.screenWidth * 0.4,
                      child: Divider(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the MyDrawer
               //   getFcmToken();

                  // Navigator.pop(context);
                },
              ),
              SizedBox(
                height: ScreenConfig.widgetPaddingLarge,
              ),
              ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Settings',
                      style: TextStyle(
                          color: CColors.missonNormalWhiteColor,
                          fontSize: ScreenConfig.fontSizeXlarge),
                    ),
                    Container(
                      width: ScreenConfig.screenWidth * 0.4,
                      child: Divider(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the MyDrawer
                  NavMe().NavPushLeftToRight(SettingPage());
                },
              ),
              SizedBox(
                height: ScreenConfig.widgetPaddingLarge,
              ),
              ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Logout',
                      style: TextStyle(
                          color: CColors.missonNormalWhiteColor,
                          fontSize: ScreenConfig.fontSizeXlarge),
                    ),
                    Container(
                      width: ScreenConfig.screenWidth * 0.4,
                      child: Divider(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                onTap: () {
                  return showCupertinoDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoAlertDialog(
                        title: Text('Alert'),
                        content: Text('Are you sure to logout?'),
                        actions: [
                          CupertinoDialogAction(
                            child: Text('Yes'),
                            onPressed: () {
                              clearedShared();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => LoginPage()),
                                  (route) => false);
                              // NavMe().NavPushReplaceFadeIn(LoginPage());
                            },
                          ),
                          CupertinoDialogAction(
                            child: Text('No'),
                            onPressed: () {
                              clearedShared();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );

                  // Update the state of the app
                  // ...
                  // Then close the MyDrawer
                  clearedShared();
                  NavMe().NavPushReplaceFadeIn(LoginPage());
                },
              ),
            ],
          ),

        ],
      ),
    );
  }
}
