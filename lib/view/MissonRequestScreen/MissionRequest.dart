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
import 'package:misson_tasker/view/ProfileView/NotificationScreen.dart';
import 'package:misson_tasker/view/ProfileView/SettingPage.dart';
import 'package:misson_tasker/view/ProfileView/SubscriptionScreen.dart';
import 'package:misson_tasker/view/ProfileView/UserProfile.dart';
import 'package:misson_tasker/view/startup_screens/SplashScreen.dart';

class MissionRequest extends StatefulWidget {
  @override
  _MissionRequestState createState() => _MissionRequestState();
}

class _MissionRequestState extends State<MissionRequest> {
  bool isLoading = true;
  String _fullName = "Loading....";

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
          InkWell(
            onTap: () {
              NavMe().NavPushLeftToRight(NotificationScreen());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 18.0, top: 30.0),
              child: Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset(optionLogo)),
            ),
          ),
        ],
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 30.0),
          child: Text(
            "Mission Request",
            style: TextStyle(
                color: Colors.black,
                fontFamily: "Product",
                fontWeight: FontWeight.w200,
                fontSize: ScreenConfig.fontSizeXlarge),
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
                Container(
                  width: ScreenConfig.screenWidth * 0.80,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Shop groceries for me",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenConfig.fontSizeXXlarge,
                                fontFamily: "Product"),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: ScreenConfig.screenHeight * 0.01,
                          ),
                          Text(
                            "Posted on 18/04/2021 , 02:34 PM",
                            style: TextStyle(
                              color: CColors.missonMediumGrey,
                              fontSize: ScreenConfig.fontSizeSmall,
                            ),
                          ),
                          SizedBox(
                            height: ScreenConfig.screenHeight * 0.02,
                          ),
                          Text(
                            "Job Reference number",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: ScreenConfig.fontSizeSmall,
                            ),
                          ),
                          SizedBox(
                            height: ScreenConfig.screenHeight * 0.02,
                          ),
                          Text(
                            "#7621189",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenConfig.fontSizeXlarge,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        "Mission details",
                        style: TextStyle(
                            fontSize: ScreenConfig.fontSizelarge,
                            fontWeight: FontWeight.w300,
                            color: CColors.missonPrimaryColor),
                      ),
                    ),
                    Spacer()
                  ],
                ),
                Divider(
                  color: CColors.missonMediumGrey,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 8.0),
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(personTextFiledIcon),
                      ),
                      suffixIcon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Text(
                              "Tasker Required",
                              style: TextStyle(
                                  fontSize: ScreenConfig.fontSizelarge,
                                  fontWeight: FontWeight.w300,
                                  color: CColors.missonMediumGrey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 8.0),
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(locationTextFiledIcon),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 8.0),
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(calanderTextFiledIcon),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 8.0),
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(timeTextFiledIcon),
                      ),
                      suffixIcon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Text(
                              "Hrs",
                              style: TextStyle(
                                  fontSize: ScreenConfig.fontSizelarge,
                                  fontWeight: FontWeight.w300,
                                  color: CColors.missonMediumGrey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 8.0),
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(locationTextFiledIcon),
                      ),
                      suffixIcon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Text(
                              "\$/hr",
                              style: TextStyle(
                                  fontSize: ScreenConfig.fontSizelarge,
                                  fontWeight: FontWeight.w300,
                                  color: CColors.missonMediumGrey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8.0),
                      child: Text(
                        "Description",
                        style: TextStyle(
                            fontSize: ScreenConfig.fontSizeXlarge,
                            fontWeight: FontWeight.w300,
                            color: CColors.missonPrimaryColor),
                      ),
                    ),
                    Spacer()
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 8.0),
                  child: Container(
                    child: TextFormField(
                      readOnly: true,
                      keyboardType: TextInputType.multiline,
                      maxLines: 8,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: CColors.missonMediumGrey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10, left: 30),
                        height: 60,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: CColors.missonNormalWhiteColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                        color: CColors.missonRed, width: 1))),

                            // style: ElevatedButton.styleFrom(primary: CColors.b),
                            onPressed: () {},
                            child: Text(
                              "Decline",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: CColors.missonRed),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        height: 60,
                        margin: EdgeInsets.only(top: 10, bottom: 10, right: 30),
                        child: ElevatedButton(
                            // style: ElevatedButton.styleFrom(primary: CColors.b),
                            //   onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                primary: CColors.missonGreen,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                        color: CColors.missonGreen, width: 1))),

                            // style: ElevatedButton.styleFrom(primary: CColors.b),
                            onPressed: () {},
                            child: Text(
                          "Accept",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )),
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 30,),
              ],
            )),
      ),
    );
  }
}
