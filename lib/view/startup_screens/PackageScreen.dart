import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:misson_tasker/model/ApiCaller.dart';
import 'package:misson_tasker/model/api_models/LoginUserModel.dart';
import 'package:misson_tasker/utils/local_data.dart';
import 'package:misson_tasker/view/Dashboard.dart';
import 'package:misson_tasker/view/startup_screens/LoginPage.dart';

import '../../utils/CColors.dart';
import '../../utils/CColors.dart';
import '../../utils/NavMe.dart';
import '../../utils/ScreenConfig.dart';
import '../../utils/ScreenConfig.dart';
import '../../utils/StringsPath.dart';
import 'ForgetPassword.dart';
import 'SignUp.dart';
import 'SplashScreen.dart';

class PackageScreen extends StatefulWidget {
  @override
  _PackageScreenState createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  TextStyle _textStyle = TextStyle(
    color: Colors.grey,
  );
  List subsciptionPlan = [
    {"time": "1 week subscription", "price": "20 SAR"},
    {"time": "2 weeks subscription", "price": "35 SAR"},
    {"time": "A month subscription", "price": "60 SAR"},
    {"time": "3 months subscription", "price": "150 SAR"},
    {"time": "6 months subscription", "price": "280 SAR"},
    {"time": "A year subscription", "price": "490 SAR"},
  ];
  final _formKey = GlobalKey<FormState>();
  String deviceTok = 'iu';
  var height = AppBar().preferredSize.height;
  LoginUserModel loginUserModel;
  var spinkit;
  bool isLoading = false;
  bool isShown = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spinkit = SpinKitWave(
      size: 40,
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven
                ? CColors.missonPrimaryColor
                : CColors.missonMediumGrey,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: ScreenConfig.screenHeight * 0.18,
          automaticallyImplyLeading: false,
          //leading: new Container(),
          backgroundColor: CColors.missonPrimaryColor,
          title: Container(
              height: ScreenConfig.screenHeight * 0.20,
              width: ScreenConfig.screenWidth,
              color: CColors.missonPrimaryColor,
              child: Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Upgrade Packages",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    SizedBox(
                      height: ScreenConfig.screenHeight * 0.03,
                    ),
                    Text("Upgrade and appear into the top of the list.",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              )),
        ),
        body: SingleChildScrollView(
          child: Container(
              height: ScreenConfig.screenHeight,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    height: ScreenConfig.screenHeight * 0.75,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 4),
                          child: Card(
                            elevation: 3,
                            child: ListTile(
                              leading: Radio(
                                value: "43",
                                groupValue: "1",
                              ),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                      flex: 3,
                                      child: Text(
                                          "${subsciptionPlan.elementAt(index)["time"]}",style: TextStyle(fontSize: ScreenConfig.fontSizeMedium),)),
                                  Spacer(),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "${subsciptionPlan.elementAt(index)["price"]}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: CColors.missonPrimaryColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: subsciptionPlan.length,
                    ),
                  ),
                  Container(
                    height: ScreenConfig.screenHeight * 0.2,
                    child: Column(
                      children: [
                        Container( width: ScreenConfig.screenWidth*0.8,
                          margin: EdgeInsets.only(top:20),
                          height: 60,
                          child: ElevatedButton(
                            // style: ElevatedButton.styleFrom(primary: CColors.b),
                            //   onPressed: () {},
                              child: Row(
                                children: [
                                  Text(
                                    "Swipe to pay >>",
                                    textAlign: TextAlign.left,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  Spacer()
                                ],
                              )),
                        ),

                        Spacer(),
                        InkWell(onTap: (){
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>LoginPage()), (route) => false);

                        }, child: Text("Do it later",textAlign: TextAlign.center,style: TextStyle(fontSize: ScreenConfig.fontSizelarge),))
                       , Spacer(),     ],
                    ),
                  )
                ],
              )),
        ),
        extendBodyBehindAppBar: true,
      ),
    );
  }
}
