import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:misson_tasker/model/ApiCaller.dart';
import 'package:misson_tasker/model/api_models/ChangePasswordModel.dart';
import 'package:misson_tasker/model/api_models/GetProfileDataModel.dart';
import 'package:misson_tasker/utils/AnimatorUtil.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/NavMe.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';
import 'package:misson_tasker/utils/StringsPath.dart';
import 'package:misson_tasker/utils/local_data.dart';
import 'package:misson_tasker/view/ProfileView/BusinessDetails.dart';
import 'package:misson_tasker/view/ProfileView/ChangePassword.dart';
import 'package:misson_tasker/view/ProfileView/UserProfile.dart';
import 'package:misson_tasker/view/startup_screens/SplashScreen.dart';

import 'editProfile.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  bool _pass = true;
  bool _newPass = true;
  bool _reNewpass = true;
  String _fullName = "Loading....";
  String _email = "Loading..";
  String _number = "Loading..";
  String _location = "Loading..";
  String _postal = "Loading..";
  TextStyle _textStyle = TextStyle(
    color: Colors.grey,
  );

  String auth = "";
  GetProfileDataModel getProfileDataModel;
  bool isLoadingData = true;
  bool isOldPasswordShown = false;
  bool isReNewPasswordShown = false;
  bool isNewPasswordShown = false;
  TextEditingController _oldPasswordFieldController = TextEditingController();
  TextEditingController _newPasswordFieldController = TextEditingController();
  TextEditingController _reNewPasswordFieldController = TextEditingController();

  ChangePasswordModel changePasswordModel;

  @override
  void initState() {
    // registerUser();


    getString(sharedPref.userToken).then((value) {
      auth = value;

      print("123 $value");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Text(
            "Change Password",
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
      body: TweenAnimationBuilder(
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
                // margin: EdgeInsets.only(top: ScreenConfig.screenHeight * 0.05),
                color: Colors.white,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(28),
                        child: Container(
                          //  height: ScreenConfig.screenHeight * 0.13,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(8.0) //  <--- border radius here
                                ),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // mainAxisSize:MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7.5),
                                child: TextFormField(
                                  readOnly: isLoading == false ? false : true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      _pass = false;
                                      setState(() {});
                                      // return "Please fill the password";
                                      return null;
                                    } else if (value.length < 5) {
                                      // _pass = false;
                                      _pass = false;
                                      setState(() {});
                                      // return "Please fill the password";
                                      return null;
                                    } else {
                                      _pass = true;
                                      setState(() {});
                                      return null;
                                    }
                                    // return null;
                                  },
                                  obscureText: !isOldPasswordShown,
                                  controller: _oldPasswordFieldController,
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: CColors.missonGreyBorderColor),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: CColors.missonGreyBorderColor),
                                      ),
                                      suffixIcon: _pass
                                          ? InkWell(
                                              onTap: () {
                                                setState(() {
                                                  isOldPasswordShown =
                                                      !isOldPasswordShown;
                                                });
                                              },
                                              child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                    16.0,
                                                    8.0,
                                                    16.0,
                                                    15,
                                                  ),
                                                  child:
                                                      isOldPasswordShown == true
                                                          ? SvgPicture.asset(
                                                              "assets/svg_assets/eye_open.svg",
                                                              height: 25,
                                                            )
                                                          : SvgPicture.asset(
                                                              "assets/svg_assets/eye_close.svg",
                                                              height: 25,
                                                            )),
                                            )
                                          : Icon(
                                              Icons.error_outlined,
                                              color: Colors.red,
                                            ),
                                      hintStyle: _textStyle,
                                      isDense: true,
                                      hintText: "Old Password",
                                      prefixIconConstraints: BoxConstraints(
                                          minHeight:
                                              ScreenConfig.screenHeight * 0.05,
                                          minWidth:
                                              ScreenConfig.screenWidth * 0.04),
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                          16.0,
                                          8.0,
                                          16.0,
                                          15,
                                        ),
                                        child: SvgPicture.asset(
                                          lockTextFiledIcon,
                                          height: 15,
                                        ),
                                      )),
                                ),
                              ),

                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7.5),
                                child: TextFormField(
                                  readOnly: isLoading == false ? false : true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      _newPass = false;
                                      setState(() {});
                                      return null;
                                    } else if (value.length < 5) {
                                      _newPass = false;
                                      setState(() {});
                                      return null;
                                    } else {
                                      _newPass = true;
                                      setState(() {});
                                      return null;
                                    }
                                    return null;
                                  },
                                  controller: _newPasswordFieldController,
                                  obscureText: !isNewPasswordShown,
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: CColors.missonGreyBorderColor),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: CColors.missonGreyBorderColor),
                                      ),
                                      suffixIcon: _newPass
                                          ? InkWell(
                                              onTap: () {
                                                setState(() {
                                                  isNewPasswordShown =
                                                      !isNewPasswordShown;
                                                });
                                              },
                                              child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                    16.0,
                                                    8.0,
                                                    16.0,
                                                    15,
                                                  ),
                                                  child:
                                                      isNewPasswordShown == true
                                                          ? SvgPicture.asset(
                                                              "assets/svg_assets/eye_open.svg",
                                                              height: 25,
                                                            )
                                                          : SvgPicture.asset(
                                                              "assets/svg_assets/eye_close.svg",
                                                              height: 25,
                                                            )),
                                            )
                                          : Icon(
                                              Icons.error_outlined,
                                              color: Colors.red,
                                            ),
                                      hintStyle: _textStyle,
                                      isDense: true,
                                      hintText: "New Password",
                                      prefixIconConstraints: BoxConstraints(
                                          minHeight:
                                              ScreenConfig.screenHeight * 0.05,
                                          minWidth:
                                              ScreenConfig.screenWidth * 0.04),
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                          16.0,
                                          8.0,
                                          16.0,
                                          15,
                                        ),
                                        child: SvgPicture.asset(
                                          lockTextFiledIcon,
                                          height: 15,
                                        ),
                                      )),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7.5),
                                child: TextFormField(
                                  readOnly: isLoading == false ? false : true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      _reNewpass = false;
                                      setState(() {});
                                      return null;
                                    } else if (value.length < 5) {
                                      _reNewpass = false;
                                      setState(() {});
                                      return null;
                                    } else {
                                      _reNewpass = true;
                                      setState(() {});
                                      return null;
                                    }
                                    return null;
                                  },
                                  controller: _reNewPasswordFieldController,
                                  obscureText: !isReNewPasswordShown,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      suffixIcon: _reNewpass
                                          ? InkWell(
                                              onTap: () {
                                                setState(() {
                                                  isReNewPasswordShown =
                                                      !isReNewPasswordShown;
                                                });
                                              },
                                              child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                    16.0,
                                                    8.0,
                                                    16.0,
                                                    15,
                                                  ),
                                                  child:
                                                      isReNewPasswordShown == true
                                                          ? SvgPicture.asset(
                                                              "assets/svg_assets/eye_open.svg",
                                                              height: 25,
                                                            )
                                                          : SvgPicture.asset(
                                                              "assets/svg_assets/eye_close.svg",
                                                              height: 25,
                                                            )),
                                            )
                                          : Icon(
                                              Icons.error_outlined,
                                              color: Colors.red,
                                            ),
                                      hintStyle: _textStyle,
                                      isDense: true,
                                      hintText: "Re-enter new Password",
                                      prefixIconConstraints: BoxConstraints(
                                          minHeight:
                                              ScreenConfig.screenHeight * 0.06,
                                          minWidth:
                                              ScreenConfig.screenWidth * 0.04),
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                          16.0,
                                          8.0,
                                          16.0,
                                          15,
                                        ),
                                        child: SvgPicture.asset(
                                          lockTextFiledIcon,
                                          height: 15,
                                        ),
                                      )),
                                ),
                              ),

                              // SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: ScreenConfig.screenHeight * 0.06,
                  width: ScreenConfig.screenWidth * 0.70,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        if (_reNewpass == true &&
                            _newPass == true &&
                            _pass == true

                        ){
                          setState(() {
                            isLoading = true;

                          });

                          ApiCaller()
                              .changePasswordApi(
                              oldPassword: _oldPasswordFieldController.text,
                              newPassword: _newPasswordFieldController.text,
                              reNewPassword:
                              _reNewPasswordFieldController.text,
                              auth: auth)
                              .then((value) => changePasswordModel = value)
                              .whenComplete(() {
                            setState(() {
                              isLoading = false;
                              showCupertinoDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CupertinoAlertDialog(
                                    title: Text('Info'),
                                    content: changePasswordModel.status == true
                                        ? Text(
                                        '${changePasswordModel.data.message}')
                                        : Text('${changePasswordModel.error}'),
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
                          });
                        }


                        // if (_newPasswordFieldController.text !=
                        //     _reNewPasswordFieldController.text) {
                        //   _reNewpass = false;
                        //   _newPass = false;
                        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //       content: Text(
                        //           "new Password doesn't match with re-enter new password ")));
                        // }
                        //
                        // else {


                        // }

                        // updateUser();
                        // ScaffoldMessenger.of(context)
                        //     .showSnackBar(SnackBar(content: Text('Processing Data 1')));
                      } else {
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Processing Data 2')));
                      }
                    },
                    child: isLoading == true
                        ? spinkit
                        : Text("Save",
                            style: TextStyle(color: Colors.white, fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      primary: CColors.missonButtonColor2, // background
                      onPrimary: CColors.missonButtonColor2, // fo
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(06.0),
                          side: BorderSide(
                              color: CColors.missonButtonColor2) // reground,
                          ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
