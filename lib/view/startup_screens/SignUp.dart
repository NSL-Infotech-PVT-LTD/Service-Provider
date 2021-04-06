import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:misson_tasker/utils/NavMe.dart';

import '../../utils/CColors.dart';
import '../../utils/ScreenConfig.dart';
import '../../utils/StringsPath.dart';
import 'LoginPage.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _auth = '';
  List<String> radioList = ["Saudi ID", "Iqama ID"];
  TextStyle _textStyle = TextStyle(
    color: Colors.grey,
  );
  TextEditingController _emailAddressFieldController = TextEditingController();
  TextEditingController _passwordFieldController = TextEditingController();
  TextEditingController _reEnterPasswordFieldController =
      TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _postalCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String deviceTok = 'iu';
  bool _username = true;
  bool _pass = true;
  bool _repass = true;
  bool _mailer = true;
  bool _phone = true;
  bool _postal = true;
  var height = AppBar().preferredSize.height;
  String _selectedRadioValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedRadioValue = radioList.elementAt(0);
  }

  @override
  Widget build(BuildContext context) {
    void registerUser() async {}

    return Form(
      key: _formKey,
      child: Scaffold(
          // appBar: AppBar(
          //   elevation: 0,
          //   toolbarHeight: ScreenConfig.screenHeight * 0.25,
          //   automaticallyImplyLeading: false,
          //   //leading: new Container(),
          //   backgroundColor: CColors.missonPrimaryColor,
          //   title:
          // ),
          body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: ScreenConfig.screenHeight * 0.22,
                    width: ScreenConfig.screenWidth,
                    color: CColors.missonPrimaryColor,
                    child: Padding(
                      padding:  EdgeInsets.only(left:16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Simple way to Sign up",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          SizedBox(
                            height: ScreenConfig.screenHeight * 0.03,
                          ),
                          Text("Please register to mission app for services.",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                    )
                  ),
                  Container(
                    height: ScreenConfig.screenHeight,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(height: ScreenConfig.screenHeight * 0.29),
                        Align(
                            alignment: Alignment(-0.7, 0),
                            child: SvgPicture.asset(cut)),
                        SizedBox(height: ScreenConfig.screenHeight * 0.03),
                        Align(
                            alignment: Alignment(-0.2, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Text(Login,style: TextStyle(color: Colors.black,fontSize: 28,fontWeight: FontWeight.w300,),textAlign: TextAlign.start,),
                                SizedBox(
                                  height: ScreenConfig.screenHeight * 0.005,
                                ),
                                Text(
                                  "Fill the below information for Sign Up",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300),
                                  textAlign: TextAlign.start,
                                )
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.all(28),
                          child: Container(
                            //  height: ScreenConfig.screenHeight * 0.13,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(
                                      8.0) //  <--- border radius here
                                  ),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              // mainAxisSize:MainAxisSize.max,
                              children: [
                                SizedBox(height: 15),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      _username = false;
                                      setState(() {});
                                      if (value.length < 5) {
                                        _username = false;
                                        setState(() {});
                                        return null;
                                      }
                                    } else {
                                      return null;
                                    }
                                    return null;
                                  },
                                  controller: _fullNameController,
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                CColors.missonGreyBorderColor),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                CColors.missonGreyBorderColor),
                                      ),
                                      suffixIcon: _username
                                          ? null
                                          : Icon(
                                              Icons.error_outlined,
                                              color: Colors.red,
                                            ),
                                      hintStyle: _textStyle,
                                      isDense: true,
                                      hintText: "Full Name",
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
                                          user3TextFiledIcon,
                                          height: 18,
                                        ),
                                      )),
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      _mailer = false;
                                      setState(() {});
                                      if (value.length < 5) {
                                        _mailer = false;
                                        setState(() {});
                                        return null;
                                      }
                                    } else {
                                      return null;
                                    }
                                    return null;
                                  },
                                  controller: _emailAddressFieldController,
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                CColors.missonGreyBorderColor),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                CColors.missonGreyBorderColor),
                                      ),
                                      suffixIcon: _mailer
                                          ? null
                                          : Icon(
                                              Icons.error_outlined,
                                              color: Colors.red,
                                            ),
                                      hintStyle: _textStyle,
                                      isDense: true,
                                      hintText: "Email Address",
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
                                          19,
                                        ),
                                        child: SvgPicture.asset(
                                          emailTextFiledIcon,
                                          height: 15,
                                        ),
                                      )),
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      _pass = false;
                                      setState(() {});
                                      if (value.length < 5) {
                                        _pass = false;
                                        setState(() {});
                                        return null;
                                      }
                                    } else {
                                      return null;
                                    }
                                    return null;
                                  },
                                  controller: _passwordFieldController,
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                CColors.missonGreyBorderColor),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                CColors.missonGreyBorderColor),
                                      ),
                                      suffixIcon: _pass
                                          ? null
                                          : Icon(
                                              Icons.error_outlined,
                                              color: Colors.red,
                                            ),
                                      hintStyle: _textStyle,
                                      isDense: true,
                                      hintText: "Password",
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
                                SizedBox(height: 15),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      _repass = false;
                                      setState(() {});
                                      if (value.length < 5) {
                                        _repass = false;
                                        setState(() {});
                                        return null;
                                      }
                                    } else {
                                      return null;
                                    }
                                    return null;
                                  },
                                  controller: _reEnterPasswordFieldController,
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                CColors.missonGreyBorderColor),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                CColors.missonGreyBorderColor),
                                      ),
                                      suffixIcon: _repass
                                          ? null
                                          : Icon(
                                              Icons.error_outlined,
                                              color: Colors.red,
                                            ),
                                      hintStyle: _textStyle,
                                      isDense: true,
                                      hintText: "Re-enter Password",
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
                                SizedBox(height: 15),
                                TextFormField(
                                  controller: _phoneNumberController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      _phone = false;
                                      setState(() {});
                                      if (value.length < 5) {
                                        _phone = false;
                                        setState(() {});
                                        return null;
                                      }
                                    } else {
                                      return null;
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                CColors.missonGreyBorderColor),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                CColors.missonGreyBorderColor),
                                      ),
                                      suffixIcon: _phone
                                          ? null
                                          : Icon(
                                              Icons.error_outlined,
                                              color: Colors.red,
                                            ),
                                      hintStyle: _textStyle,
                                      isDense: true,
                                      hintText: "Phone",
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
                                          phoneTextFiledIcon,
                                          height: 15,
                                        ),
                                      )),
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      _pass = false;
                                      setState(() {});
                                      if (value.length < 5) {
                                        _pass = false;
                                        setState(() {});
                                        return null;
                                      }
                                    } else {
                                      return null;
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                CColors.missonGreyBorderColor),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                CColors.missonGreyBorderColor),
                                      ),
                                      suffixIcon: _repass
                                          ? Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                16.0,
                                                8.0,
                                                16.0,
                                                15,
                                              ),
                                              child: SvgPicture.asset(
                                                  myLocationIcon),
                                            )
                                          : Icon(
                                              Icons.error_outlined,
                                              color: Colors.red,
                                            ),
                                      hintStyle: _textStyle,
                                      isDense: true,
                                      hintText: "Location",
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
                                            compassTextFiledIcon),
                                      )),
                                ),
                                // SizedBox(height: 15),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 7.5),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: CColors.missonGreyBorderColor),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        child: SvgPicture.asset(
                                          user2TextFiledIcon,
                                          height: 18,
                                        ),
                                        margin: EdgeInsets.fromLTRB(
                                          16.0,
                                          0.0,
                                          0.0,
                                          0.0,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Radio<String>(
                                            value: radioList.elementAt(0),
                                            groupValue: _selectedRadioValue,
                                            onChanged: (value) {
                                              setState(() {
                                                print("43243254 $value");
                                                _selectedRadioValue = value;
                                              });
                                            },
                                          ),
                                          Text('Saudi ID'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Radio<String>(
                                            value: radioList.elementAt(1),
                                            groupValue: _selectedRadioValue,
                                            onChanged: (value) {
                                              setState(() {
                                                _selectedRadioValue = value;
                                              });
                                            },
                                          ),
                                          Text('Iqama ID')
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                TextFormField(
                                  controller: _phoneNumberController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      _phone = false;
                                      setState(() {});
                                      if (value.length < 5) {
                                        _phone = false;
                                        setState(() {});
                                        return null;
                                      }
                                    } else {
                                      return null;
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      suffixIcon: _phone
                                          ? null
                                          : Icon(
                                              Icons.error_outlined,
                                              color: Colors.red,
                                            ),
                                      hintStyle: _textStyle,
                                      isDense: true,
                                      hintText:
                                          "Type $_selectedRadioValue number",
                                      prefixIconConstraints: BoxConstraints(
                                          minHeight:
                                              ScreenConfig.screenHeight * 0.03,
                                          minWidth:
                                              ScreenConfig.screenWidth * 0.04),
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                          25.0,
                                          8.0,
                                          16.0,
                                          8.0,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              child: Container(
                height: ScreenConfig.screenHeight * 0.1,
                color: CColors.missonNormalWhiteColor,
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell( onTap: ()=>  NavMe().NavPushReplaceFadeIn(LoginPage()),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(color: Color(0xFF8A9EAD)))),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                              15.0,
                              8.0,
                              8.0,
                              8.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Spacer(),
                                Text("Already have an account?",
                                    style: TextStyle(
                                        color: CColors.missonGrey,
                                        fontSize: ScreenConfig.fontSizeSmall)),
                                Spacer(),
                                // Text("SIGN",
                                //     style: TextStyle(
                                //       color: CColors.missonGrey,
                                //     )),


                                   Text(
                                      "SIGN IN",
                                      style: TextStyle(
                                          color: CColors.missonGrey,
                                          fontSize: ScreenConfig.fontSizelarge),
                                    ),
                                Spacer()
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            if (_username == true &&
                                _pass == true &&
                                _repass == true &&
                                _mailer == true &&
                                _phone == true &&
                                _postal == true) registerUser();
                            // ScaffoldMessenger.of(context)
                            //     .showSnackBar(SnackBar(content: Text('Processing Data 1')));
                          } else {
                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Processing Data 2')));
                          }
                        },
                        child: Container(
                          width: ScreenConfig.screenWidth / 2,
                          color: CColors.missonSignUpButtonColor,
                          //   height: ScreenConfig.screenHeight * 0.50,

                          child: Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("SIGN UP",
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                  SizedBox(
                                    width: ScreenConfig.screenWidth * 0.04,
                                  ),
                                  RotatedBox(
                                      quarterTurns: 2,
                                      child: SvgPicture.asset(nextScreenArrow)),
                                ],
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              alignment: Alignment.bottomCenter,
            )
          ],
        ),
      )
          // extendBodyBehindAppBar: true,
          ),
    );
  }
}
