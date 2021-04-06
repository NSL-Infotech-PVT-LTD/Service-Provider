import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:misson_tasker/view/Dashboard.dart';

import '../../utils/CColors.dart';
import '../../utils/CColors.dart';
import '../../utils/NavMe.dart';
import '../../utils/ScreenConfig.dart';
import '../../utils/ScreenConfig.dart';
import '../../utils/StringsPath.dart';
import 'SignUp.dart';

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

  @override
  Widget build(BuildContext context) {
    void login() async {
      NavMe().NavPushReplaceFadeIn(Dashboard());
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
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
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
                              return 'Please enter some text';
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
                      onTap: () => () {},
                      child: Padding(
                        padding: const EdgeInsets.only(right: 28),
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              "Forgot password ?",
                              style: TextStyle(color: CColors.missonGrey),
                            )),
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
                                  onTap: () =>
                                      {NavMe().NavPushReplaceFadeIn(SignUp())},
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
                              onTap: () {
                                // if (_formKey.currentState.validate()) {
                                  login();
                                  // ScaffoldMessenger.of(context)
                                  //     .showSnackBar(SnackBar(content: Text('Processing Data 1')));
                                // } else {
                                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Processing Data 2')));
                                // }
                              },
                              child: Container(
                                width: ScreenConfig.screenWidth / 2,
                                color: CColors.missonButtonColor,
                                //   height: ScreenConfig.screenHeight * 0.50,
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("SIGN IN",
                                            style: TextStyle(
                                              color: Colors.white,
                                            )),
                                        SizedBox(
                                          width:
                                              ScreenConfig.screenWidth * 0.04,
                                        ),
                                        RotatedBox(
                                            quarterTurns: 2,
                                            child: SvgPicture.asset(
                                                nextScreenArrow)),
                                      ],
                                    )),
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
