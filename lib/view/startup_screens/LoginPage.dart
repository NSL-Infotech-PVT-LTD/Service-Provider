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

import '../../utils/CColors.dart';
import '../../utils/CColors.dart';
import '../../utils/NavMe.dart';
import '../../utils/ScreenConfig.dart';
import '../../utils/ScreenConfig.dart';
import '../../utils/StringsPath.dart';
import 'ForgetPassword.dart';
import 'SignUp.dart';
import 'SplashScreen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _auth = '';

  TextStyle _textStyle = TextStyle(
    color: Colors.grey,
  );
  TextEditingController _emailAddressFieldController = TextEditingController();
  TextEditingController _passwordFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String deviceTok = 'iu';
  var height = AppBar().preferredSize.height;
  LoginUserModel loginUserModel;
  var spinkit;
  bool isLoading = false;

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
    void login() async {
      ApiCaller()
          .loginUser(
              email: _emailAddressFieldController.text,
              password: _passwordFieldController.text,
              deviceType: "android",
              deviceToken: "asdfsdfgdsgds")
          .then((value) => loginUserModel = value)
          .whenComplete(() {
        if (loginUserModel != null &&
            loginUserModel.status == true &&
            loginUserModel.data != null &&
            loginUserModel.data.user != null) {
          setString(sharedPref.userEmail, loginUserModel.data.user.email);

          setString(sharedPref.userToken, loginUserModel.data.token);
          setString(sharedPref.userLocation, loginUserModel.data.user.location);
          setString(
              sharedPref.userPhoneNumber, loginUserModel.data.user.mobile);

          getString(sharedPref.userPhoneNumber)
              .then((value) => print("123 $value"));

          getString(sharedPref.userToken).then((value) => print("123 $value"));

          getString(sharedPref.userEmail).then((value) => print("123 $value"));

          getString(sharedPref.userLocation)
              .then((value) => print("123 $value")).whenComplete(()  {
          setState(() {
          isLoading = false;
          });
          NavMe().NavPushReplaceFadeIn(Dashboard());

          });
        } else if (loginUserModel != null && loginUserModel.code == 422) {
          setState(() {
            isLoading = false;
          });
          showCupertinoDialog(
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: Text('Alert'),
                content: Text('${loginUserModel.error}'),
                actions: [
                  CupertinoDialogAction(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        }

        // print("1234 ${loginUserModel.toJson().toString()}");
      }).whenComplete(() {


      });
    }

    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            toolbarHeight: ScreenConfig.screenHeight * 0.25,
            automaticallyImplyLeading: false,
            //leading: new Container(),
            backgroundColor: CColors.missonPrimaryColor,
            title: Center(
                child: SvgPicture.asset(
                    "assets/svg_assets/misson_logo_dark.svg"))),
        body: SingleChildScrollView(
          child: Container(
            height: ScreenConfig.screenHeight,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: ScreenConfig.screenHeight * 0.29),
                SizedBox(height: ScreenConfig.screenHeight * 0.03),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenConfig.fontSizeXXlarge,
                                // fontWeight: FontWeight.w500,
                                fontFamily: "  Raleway-ExtraBoldItalic.ttf"),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: ScreenConfig.screenHeight * 0.02,
                          ),
                          Text(
                            "Fill the below information for login",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                            textAlign: TextAlign.start,
                          )
                        ],
                      )),
                ),
                Padding(
                  padding: EdgeInsets.all(28),
                  child: Container(
                    height: ScreenConfig.screenHeight * 0.13,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(8.0) //  <--- border radius here
                          ),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(height: ScreenConfig.screenHeight * 0.00),
                        TextFormField(
                          controller: _emailAddressFieldController,
                          validator: (value) {
                            Pattern pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regex = new RegExp(pattern);
                            if (value == null || value.isEmpty) {
                              return 'Please enter email';
                            }
                            else if(!regex.hasMatch(value)){
                              return 'Enter Valid Email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintStyle: _textStyle,
                            isDense: true,
                            hintText: "Email",
                            prefixIconConstraints: BoxConstraints(
                                minHeight: ScreenConfig.screenHeight * 0.05,
                                minWidth: ScreenConfig.screenWidth * 0.04),
                            prefixIcon: Padding(
                              padding: EdgeInsets.fromLTRB(
                                8.0,
                                8.0,
                                8.0,
                                19,
                              ),
                              child: SvgPicture.asset(emailTextFiledIcon),
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: _passwordFieldController,
                          validator: (value) {



                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }
                            else if( value.length<5){
                              return 'Please enter password more than 5 character';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintStyle: _textStyle,
                            border: InputBorder.none,
                            isDense: true,
                            hintText: "Password",
                            prefixIconConstraints: BoxConstraints(
                                minHeight: ScreenConfig.screenHeight * 0.05,
                                minWidth: ScreenConfig.screenWidth * 0.04),
                            prefixIcon: Padding(
                              padding: EdgeInsets.fromLTRB(
                                8.0,
                                8.0,
                                8.0,
                                15,
                              ),
                              child: SvgPicture.asset(lockTextFiledIcon),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        print("PRINCE");
                        // NavMe().NavPushLeftToRight(ForgotPassword);
                        Get.to(ForgotPassword(),
                            transition: Transition.rightToLeft,
                            duration: Duration(milliseconds: 500));
                        // Navigator.push(context, MaterialPageRoute(
                        //   builder: (context)=>ForgotPassword()
                        // ));
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 28),
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                "Forgot password?",
                                style: TextStyle(color: CColors.missonGrey),
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenConfig.widgetPaddingXLarge,
                    ),
                    Container(
                      height: ScreenConfig.screenHeight * 0.08,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          color: Color(0xFF8A9EAD)))),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    15.0, 8.0, 8.0, 8.0),
                                child: InkWell(
                                  onTap: () =>isLoading==false?
                                      NavMe().NavPushReplaceFadeIn(SignUp()):null,
                                  // navigatorPushReplacedFun(context, SignUp()),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Spacer(),
                                      Text("Don’t have an account?",
                                          style: TextStyle(
                                              color: CColors.missonGrey)),
                                      Spacer(),
                                      Text(
                                        "SIGN UP",
                                        style: TextStyle(
                                            color: CColors.missonPrimaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap:isLoading == false ? (){
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  login();
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //     SnackBar(
                                  //         content: Text('Logging you back')));
                                } else {
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //     SnackBar(
                                  //         content: Text(
                                  //             'Please fill required fields')));
                                }
                              }:null,
                              child: Container(
                                width: ScreenConfig.screenWidth / 2,
                                color: CColors.missonButtonColor,
                                //   height: ScreenConfig.screenHeight * 0.50,
                                child: Align(
                                    alignment: Alignment.center,
                                    child: isLoading == false
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("SIGN IN",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  )),
                                              SizedBox(
                                                width:
                                                    ScreenConfig.screenWidth *
                                                        0.04,
                                              ),
                                              RotatedBox(
                                                  quarterTurns: 2,
                                                  child: SvgPicture.asset(
                                                      nextScreenArrow)),
                                            ],
                                          )
                                        : spinkit),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
      ),
    );
  }
}
