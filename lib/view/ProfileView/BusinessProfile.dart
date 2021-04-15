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
import 'package:misson_tasker/view/ProfileView/UserProfile.dart';
import 'package:misson_tasker/view/startup_screens/SplashScreen.dart';

import 'editProfile.dart';

class BusinessProfile extends StatefulWidget {
  @override
  _BusinessProfileState createState() => _BusinessProfileState();
}

class _BusinessProfileState extends State<BusinessProfile> {
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
String auth="";
  GetProfileDataModel getProfileDataModel;
  bool isLoadingData=true;
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0, top: 30.0),
            child: Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset(bellIcon)),
          ),
        ],
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 30.0),
          child: Text(
            "Business profile",
            style: TextStyle(color: Colors.black),
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
      body: Container(
          margin: EdgeInsets.only(top: ScreenConfig.screenHeight * 0.05),
          color: Colors.white,
          child: Column(
            children: [
              Container(
                width: ScreenConfig.screenWidth * 0.70,
                child: Column(
                  children: [
                    Row(
                      children: [
                        // circleImageSha(), // Image.asset(ImagePath+"avatarSample.png"),
                        CircleAvatar(
                          backgroundColor: CColors.missonGrey,
                          radius: 47,
                          child: CircleAvatar(
                            backgroundImage: getProfileDataModel == null ||
                                getProfileDataModel.data == null ||
                                getProfileDataModel.data.user == null ||
                                getProfileDataModel.data.user.image == null
                                ? AssetImage(avatar1)
                                : NetworkImage(
                                "${getProfileDataModel.data.user.image}"),

                            radius: 45,
                          ),
                        ),
                        SizedBox(
                          width: ScreenConfig.screenWidth * 0.06,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _fullName,
                              style: TextStyle(color: Colors.black,fontSize: 20),
                            ),
                            SizedBox(
                              height: ScreenConfig.screenHeight * 0.01,
                            ),
                            InkWell(
                                onTap: () {
                                  NavMe().NavPushLeftToRight(EditProfile());
                                },
                                child: Text(
                                  "Edit profile",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                  ),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Profile Completed",
                      style: TextStyle(
                          color: CColors.missonGrey,
                          fontSize: ScreenConfig.fontSizeSmall),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 7,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                color: Colors.green,
                              )),
                          SizedBox(
                            width: 2.5,
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                color: Colors.green,
                              )),
                          SizedBox(
                            width: 2.5,
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                color: Colors.green,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(userIcon),
                  ),
                  title: InkWell(
                    onTap: () {
                      NavMe().NavPushLeftToRight(UserProfile());
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Personal details",
                          style: TextStyle(
                              fontSize: ScreenConfig.fontSizelarge,
                              color: CColors.missonPrimaryColor),
                        ),
                        Text(
                          "Edit Name, email, contact etc.",
                          style: TextStyle(
                              fontSize: ScreenConfig.fontSizeSmall,
                              color: CColors.missonMediumGrey),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      navbarHomeActive,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  title: InkWell(
                    onTap: (){
                      print("areewewe");
                      NavMe().NavPushLeftToRight(BusinessDetails());
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Business Details",
                          style: TextStyle(
                              fontSize: ScreenConfig.fontSizelarge,
                              color: CColors.missonPrimaryColor),
                        ),
                        Text(
                          "Add Category, Price etc.",
                          style: TextStyle(
                              fontSize: ScreenConfig.fontSizeSmall,
                              color: CColors.missonMediumGrey),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(user2TextFiledIcon),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Subscription",
                        style: TextStyle(
                            fontSize: ScreenConfig.fontSizelarge,
                            color: CColors.missonPrimaryColor),
                      ),
                      Text(
                        "30 day left for expiration ",
                        style: TextStyle(
                            fontSize: ScreenConfig.fontSizeSmall,
                            color: CColors.missonMediumGrey),
                      ),
                    ],
                  ),
                  trailing: SvgPicture.asset(
                    rightArrowIcon,
                    height: 15,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(walletIcon),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Payment",
                        style: TextStyle(
                            fontSize: ScreenConfig.fontSizelarge,
                            color: CColors.missonPrimaryColor),
                      ),
                      Text(
                        "Notifications, Change password, Help & support",
                        style: TextStyle(
                            fontSize: ScreenConfig.fontSizeSmall,
                            color: CColors.missonMediumGrey),
                      ),
                    ],
                  ),
                  trailing: SvgPicture.asset(
                    rightArrowIcon,
                    height: 15,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(settingIcon),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Settings",
                        style: TextStyle(
                            fontSize: ScreenConfig.fontSizelarge,
                            color: CColors.missonPrimaryColor),
                      ),
                      Text(
                        "Notifications, Change password, Help & support",
                        style: TextStyle(
                            fontSize: ScreenConfig.fontSizeSmall,
                            color: CColors.missonMediumGrey),
                      ),
                    ],
                  ),
                  trailing: SvgPicture.asset(
                    rightArrowIcon,
                    height: 15,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
