import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:misson_tasker/model/ApiCaller.dart';
import 'package:misson_tasker/model/api_models/GetProfileDataModel.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/NavMe.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';
import 'package:misson_tasker/utils/SharedStrings.dart';
import 'package:misson_tasker/utils/StringsPath.dart';
import 'package:misson_tasker/utils/local_data.dart';
import 'package:misson_tasker/view/startup_screens/SplashScreen.dart';

import 'editProfile.dart';

class Subscription extends StatefulWidget {
  @override
  _SubscriptionState createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  bool isLoading = true;

  GetProfileDataModel getProfileDataModel;
  String auth;
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
        });
      });
    });
// getString(sharedPref.userToken).then((value) => auth=value).whenComplete(() {
//   print(" QWE$auth");
//
//   ApiCaller().getProfileData(auth: auth).then((value) {
//     getProfileDataModel=value;
//   }).whenComplete(() {
//     setState(() {
//       isLoadingData=false;
//
//       _fullName=getProfileDataModel.data.user.name;
//      _email =getProfileDataModel.data.user.email;
//        _number = getProfileDataModel.data.user.mobile;
//        _location = getProfileDataModel.data.user.location;
//        _postal = "1234";
//     });
//
//   });
// });

    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 12.0, top: 30.0),
        //     child: Align(
        //         alignment: Alignment.topRight, child: SvgPicture.asset("")),
        //   ),
        // ],
        centerTitle: true,
        toolbarHeight: ScreenConfig.screenWidth * 0.2,
        title: Padding(
          padding: const EdgeInsets.only(right: 12.0, top: 30.0),
          child: Padding(
            padding: EdgeInsets.only(bottom: ScreenConfig.screenHeight * 0.03),
            child: Text(
              "Subscription",
              style: TextStyle(color: Colors.black, fontFamily: "Product"),
            ),
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
        color: CColors.missonNormalWhiteColor,
        child: Column(
          children: [
            Container(
                color: CColors.missonPrimaryColor,
                width: ScreenConfig.screenWidth,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        subscritpionLogo,
                        height: 150,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Tasker need to pay monthly fee \n to use the app service.",
                        style: TextStyle(
                            color: CColors.missonNormalWhiteColor,
                            fontFamily: "Product",
                            fontSize: ScreenConfig.fontSizeXlarge),
                      )
                    ],
                  ),
                )),
            Container(
                color: CColors.missonNormalWhiteColor,
                width: ScreenConfig.screenWidth,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Column(
                          children: [
                            Text(
                              "Subscription Price",
                              style: TextStyle(
                                  fontFamily: "Product",
                                  fontSize: ScreenConfig.fontSizelarge),
                            ),
                            Text(
                              "SAR 20.00",
                              style: TextStyle(
                                  fontFamily: "Product",
                                  fontSize: ScreenConfig.fontSizeMedium),
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                      SizedBox(height: 20,),
                      ListTile(
                        title: Column(
                          children: [
                            Text(
                              "Date of expiration",
                              style: TextStyle(
                                  fontFamily: "Product",
                                  fontSize: ScreenConfig.fontSizelarge),
                            ),

                            Row(
                              children: [
                                Text(
                                  "25/April/2021",
                                  style: TextStyle(
                                      fontFamily: "Product",
                                      fontSize: ScreenConfig.fontSizeMedium),
                                ),
                                Spacer(),
                                Text(
                                  "30 days left",
                                  style: TextStyle(
                                      fontSize: ScreenConfig.fontSizeSmall,
                                      fontFamily: "Product", color: CColors.missonMediumGrey),
                                )
                              ],
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Tasker need to pay monthly fee \n to use the app service.",
                        style: TextStyle(
                            color: CColors.missonNormalWhiteColor,
                            fontFamily: "Product",
                            fontSize: ScreenConfig.fontSizeXlarge),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
