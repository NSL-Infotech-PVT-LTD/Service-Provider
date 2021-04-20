import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:misson_tasker/model/ApiCaller.dart';
import 'package:misson_tasker/model/api_models/GetProfileDataModel.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/NavMe.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';
import 'package:misson_tasker/utils/StringsPath.dart';
import 'package:misson_tasker/utils/local_data.dart';
import 'package:misson_tasker/view/ProfileView/BusinessDetails.dart';
import 'package:misson_tasker/view/ProfileView/ChangeNotificationScreen.dart';
import 'package:misson_tasker/view/ProfileView/ChangePassword.dart';
import 'package:misson_tasker/view/ProfileView/ConfigurationScreen.dart';
import 'package:misson_tasker/view/ProfileView/UserProfile.dart';
import 'package:misson_tasker/view/startup_screens/LoginPage.dart';
import 'package:misson_tasker/view/startup_screens/SplashScreen.dart';

import 'editProfile.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isLoading = true;
  String _fullName = "Loading....";
  String _email = "Loading..";
  String _number = "Loading..";
  String _location = "Loading..";
  String _postal = "Loading..";

  // void registerUser() async {
  //   isConnectedToInternet().then((internet) {
  //     if (internet != null && internet) {
  //       // showProgress(context, "Please wait.....");
  //       //print('Device Token $deviceTok');
  //       // Map<String, String> parms ={
  //       //   name:_fullNameController.text,
  //       //   email:_emailAddressFieldController.text,
  //       //   password:_passwordFieldController.text,
  //       //   device_type:"ios",
  //       //   deviceToken:"test",
  //       //   mobile:_phoneNumberController.text,
  //       //   gender:"male",
  //       //   //image:
  //       //   postalCode:_postalCodeController.text,
  //       // };
  //       //  print("$parms");
  //
  //       getString(userAuth).then((value) {
  //
  //         getProfile(value).then((response) {
  //
  //           if (response.status) {
  //             print(response.status.toString());
  //             setState(() {
  //               _fullName = response.data.user.name != null
  //                   ? response.data.user.name
  //                   : "No data found";
  //               _email = response.data.user.email != null
  //                   ? response.data.user.email
  //                   : "No data found";
  //               _number = response.data.user.mobile != null
  //                   ? response.data.user.mobile
  //                   : "No data found";
  //               _location = response.data.user.location != null
  //                   ? response.data.user.location
  //                   : "No data found";
  //               _postal = "12345";
  //               isLoading = false;
  //             });
  //             //setString(userAuth, "Bearer " + response.data.token);
  //             // pushAndRemoveUntilFun(context,MainScreen());
  //           } else {
  //
  //             setState(() {
  //               isLoading = false;
  //             });
  //
  //             if (!response.status) {
  //               print(response.error.toString());
  //
  //             }
  //           }
  //         });
  //       });
  //     } else {
  //       //  showDialogBox(context, internetError, pleaseCheckInternet);
  //       // dismissDialog(context);
  //     }
  //   });
  // }
  String auth = "";
  GetProfileDataModel getProfileDataModel;
  bool isLoadingData = true;

  @override
  void initState() {
    // registerUser();

    getString(sharedPref.userToken).then((value) {
      auth = value;

      print("123 $value");
    }).whenComplete(() {
      ApiCaller().getProfileData(auth: auth).then((value) {
        getProfileDataModel = value;
      }).whenComplete(() {
        setState(() {
          isLoadingData = false;

          _fullName = getProfileDataModel.data.user.name;
          _email = getProfileDataModel.data.user.email;
          _number = getProfileDataModel.data.user.mobile;
          _location = getProfileDataModel.data.user.location;
          _postal = getProfileDataModel.data.user.postalCode;
        });
      });
    });
    super.initState();
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
            "Settings",
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
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(top: ScreenConfig.screenHeight * 0.05),
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 10),
                  child: ListTile(
                    title: InkWell(
                      onTap: () {
                        NavMe().NavPushLeftToRight(ChangePassword());
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Change Password",
                            style: TextStyle(
                                fontSize: ScreenConfig.fontSizelarge,
                                color: CColors.missonPrimaryColor,
                                fontFamily: "Product"),
                          ),
                          Text(
                            "Change Password",
                            style: TextStyle(
                                fontSize: ScreenConfig.fontSizeSmall,
                                color: CColors.missonMediumGrey,
                                fontFamily: "Product"),
                          ),
                        ],
                      ),
                    ),
                    trailing: SvgPicture.asset(
                      rightArrowIcon,
                      height: 15,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 10),
                  child: ListTile(
                    title: InkWell(
                      onTap: () {
                        print("areewewe");
                        NavMe().NavPushLeftToRight(ChangeNoticationScreen());
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Notifications",
                            style: TextStyle(
                                fontSize: ScreenConfig.fontSizelarge,
                                color: CColors.missonPrimaryColor,
                                fontFamily: "Product"),
                          ),
                          Text(
                            "On/Off",
                            style: TextStyle(
                                fontSize: ScreenConfig.fontSizeSmall,
                                color: CColors.missonMediumGrey,
                                fontFamily: "Product"),
                          ),
                        ],
                      ),
                    ),
                    trailing: SvgPicture.asset(
                      rightArrowIcon,
                      height: 15,
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //       vertical: 16.0, horizontal: 10),
                //   child: ListTile(
                //     title: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           "Help & Support",
                //           style: TextStyle(
                //               fontSize: ScreenConfig.fontSizelarge,
                //               color: CColors.missonPrimaryColor,
                //               fontFamily: "Product"),
                //         ),
                //         Text(
                //           "Help center and legal terms ",
                //           style: TextStyle(
                //               fontSize: ScreenConfig.fontSizeSmall,
                //               color: CColors.missonMediumGrey,
                //               fontFamily: "Product"),
                //         ),
                //       ],
                //     ),
                //     trailing: SvgPicture.asset(
                //       rightArrowIcon,
                //       height: 15,
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 10),
                  child: InkWell(
                    onTap: () {

                        NavMe().NavPushLeftToRight(ConfigurationScreen(
                          apiName: "Privacy Policy",
                        ));

                    },
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Privacy Policy",
                            style: TextStyle(
                                fontSize: ScreenConfig.fontSizelarge,
                                color: CColors.missonPrimaryColor,
                                fontFamily: "Product"),
                          ),
                          Text(
                            "Help center and legal terms",
                            style: TextStyle(
                                fontSize: ScreenConfig.fontSizeSmall,
                                color: CColors.missonMediumGrey,
                                fontFamily: "Product"),
                          ),
                        ],
                      ),
                      trailing: SvgPicture.asset(
                        rightArrowIcon,
                        height: 15,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 10),
                  child: InkWell(
                    onTap: () {
                      NavMe().NavPushLeftToRight(ConfigurationScreen(
                        apiName: "Terms & Conditions",
                      ));
                    },
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Terms & Conditions",
                            style: TextStyle(
                                fontSize: ScreenConfig.fontSizelarge,
                                color: CColors.missonPrimaryColor,
                                fontFamily: "Product"),
                          ),
                          Text(
                            "Mission terms",
                            style: TextStyle(
                                fontSize: ScreenConfig.fontSizeSmall,
                                color: CColors.missonMediumGrey,
                                fontFamily: "Product"),
                          ),
                        ],
                      ),
                      trailing: SvgPicture.asset(
                        rightArrowIcon,
                        height: 15,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 10),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Contact us",
                          style: TextStyle(
                              fontSize: ScreenConfig.fontSizelarge,
                              color: CColors.missonPrimaryColor,
                              fontFamily: "Product"),
                        ),
                        Text(
                          "Question? Need help?",
                          style: TextStyle(
                              fontSize: ScreenConfig.fontSizeSmall,
                              color: CColors.missonMediumGrey,
                              fontFamily: "Product"),
                        ),
                      ],
                    ),
                    trailing: SvgPicture.asset(
                      rightArrowIcon,
                      height: 15,
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //       vertical: 16.0, horizontal: 10),
                //   child: ListTile(
                //     title: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           "FAQ",
                //           style: TextStyle(
                //               fontSize: ScreenConfig.fontSizelarge,
                //               color: CColors.missonPrimaryColor,
                //               fontFamily: "Product"),
                //         ),
                //         Text(
                //           "Frequently asked questions",
                //           style: TextStyle(
                //               fontSize: ScreenConfig.fontSizeSmall,
                //               color: CColors.missonMediumGrey,
                //               fontFamily: "Product"),
                //         ),
                //       ],
                //     ),
                //     trailing: SvgPicture.asset(
                //       rightArrowIcon,
                //       height: 15,
                //     ),
                //   ),
                // ),
                InkWell(onTap: (){

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


                },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 10),
                    child: ListTile(
                      title: Text(
                        "Logout",
                        style: TextStyle(
                            fontSize: ScreenConfig.fontSizelarge,
                            color: CColors.missonPrimaryColor,
                            fontFamily: "Product"),
                      ),
                      trailing: SvgPicture.asset(
                        logoutLogo,
                        height: 20,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
