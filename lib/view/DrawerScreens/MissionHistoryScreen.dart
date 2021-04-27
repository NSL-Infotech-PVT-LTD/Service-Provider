import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:misson_tasker/model/ApiCaller.dart';
import 'package:misson_tasker/model/api_models/GetProfileDataModel.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/NavMe.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';
import 'package:misson_tasker/utils/StringsPath.dart';
import 'package:misson_tasker/utils/local_data.dart';
import 'package:misson_tasker/view/JobFlowScreen/MissionProcessScreen.dart';
import 'package:misson_tasker/view/ProfileView/BusinessDetails.dart';
import 'package:misson_tasker/view/ProfileView/NotificationScreen.dart';
import 'package:misson_tasker/view/ProfileView/SettingPage.dart';
import 'package:misson_tasker/view/ProfileView/SubscriptionScreen.dart';
import 'package:misson_tasker/view/ProfileView/UserProfile.dart';
import 'package:misson_tasker/view/startup_screens/SplashScreen.dart';

class MissionHistoryScreen extends StatefulWidget {
  @override
  _MissionHistoryScreenState createState() => _MissionHistoryScreenState();
}

class _MissionHistoryScreenState extends State<MissionHistoryScreen> {
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
        actions: [
          InkWell(
            onTap: () {
              NavMe().NavPushLeftToRight(NotificationScreen());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0, top: 30.0),
              child: Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset(bellIcon)),
            ),
          ),
        ],
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 30.0),
          child: Text(
            "Mission History",
            style: TextStyle(
                color: CColors.missonNormalGrey,
                fontSize: ScreenConfig.fontSizeXXlarge,
                fontWeight: FontWeight.w100,
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
      body: Container(
          margin: EdgeInsets.only(top: 10),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: ScreenConfig.screenWidth * 0.80,
                child: Column(
                  children: [
                    Text(
                      "You can check details of your past \n mission posted by you",
                      style: TextStyle(
                          color: CColors.missonNormalGrey,
                          fontSize: ScreenConfig.fontSizeMedium,
                          fontWeight: FontWeight.w100,
                          fontFamily: "Product"),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                    width: ScreenConfig.screenWidth,
                    // height: 600,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return customHistoryCard(
                            title: "Shop groceries for me",
                            onPress: () {
                              NavMe().NavPushLeftToRight(MissionProcessScreen(id: "30",));

                            },
                            subTitle: "#7621189");
                      },
                      itemCount: 5,
                    )),
              ),
            ],
          )),
    );
  }

  Widget customHistoryCard({String title, String subTitle, Function onPress}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "$subTitle",
                  style: TextStyle(
                      color: CColors.missonNormalGrey,
                      fontSize: ScreenConfig.fontSizeMedium,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Product"),
                  textAlign: TextAlign.center,
                ),
                Text(
                  " Job Reference number",
                  style: TextStyle(
                      color: CColors.missonMediumGrey,
                      fontSize: ScreenConfig.fontSizeMedium,
                      fontFamily: "Product"),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded( flex: 4,
                  child: Text(
                    "$title",
                    style: TextStyle(
                        color: CColors.missonNormalGrey,
                        fontSize: ScreenConfig.fontSizeXhlarge,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Product"),
                    textAlign: TextAlign.left,
                  ),
                ),
             
                Expanded( flex: 2,
                  child: Container(
                    width: 120,
                    // margin: EdgeInsets.only(top: 20),
                    height: 40,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: CColors.missonPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10)),
                            // side: BorderSide(color: Colors.)
                          ),
                        ),
                        onPressed: onPress,
                        child: Row(
                          children: [
                            Text(
                              "View More +",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Spacer()
                          ],
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
