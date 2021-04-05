import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  @override
  Widget build(BuildContext context) {
    void registerUser() async {}

    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: ScreenConfig.screenHeight * 0.25,
          automaticallyImplyLeading: false,
          //leading: new Container(),
          backgroundColor: CColors.missonPrimaryColor,
          title: Container(
            width: ScreenConfig.screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: ScreenConfig.screenHeight,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: ScreenConfig.screenHeight * 0.29),
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
                          height: ScreenConfig.screenHeight * 0.02,
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
                      borderRadius: BorderRadius.all(
                          Radius.circular(8.0) //  <--- border radius here
                          ),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // mainAxisSize:MainAxisSize.max,
                      children: [
                        SizedBox(height: ScreenConfig.screenHeight * 0.00),
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
                                  minHeight: ScreenConfig.screenHeight * 0.05,
                                  minWidth: ScreenConfig.screenWidth * 0.04),
                              prefixIcon: Padding(
                                padding: EdgeInsets.fromLTRB(
                                  8.0,
                                  8.0,
                                  8.0,
                                  15,
                                ),
                                child: SvgPicture.asset(user3TextFiledIcon),
                              )),
                        ),
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
                              )),
                        ),
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
                              )),
                        ),
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
                          controller: _reEnterPasswordFieldController,
                          decoration: InputDecoration(
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
                              )),
                        ),
                        TextFormField(
                          controller: _phoneNumberController,
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
                          decoration: InputDecoration(
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
                                  minHeight: ScreenConfig.screenHeight * 0.05,
                                  minWidth: ScreenConfig.screenWidth * 0.04),
                              prefixIcon: Padding(
                                padding: EdgeInsets.fromLTRB(
                                  8.0,
                                  8.0,
                                  8.0,
                                  15,
                                ),
                                child: SvgPicture.asset(phoneTextFiledIcon),
                              )),
                        ),
                        // TextFormField(
                        //   controller: _locationController,
                        //   // validator: (value) {
                        //   //   if (value == null || value.isEmpty || value.length < 9) {
                        //   //     _phone = false;
                        //   //     setState(() {});
                        //   //     return null;
                        //   //   }
                        //   //   return null;
                        //   // },
                        //   decoration: InputDecoration(hintStyle: _textStyle,isDense: true,hintText: "Location",prefixIconConstraints:BoxConstraints(minHeight: ScreenConfig.screenHeight * 0.05,minWidth: ScreenConfig.screenWidth * 0.04),prefixIcon:  Padding(
                        //     padding: EdgeInsets.fromLTRB(8.0,8.0,8.0,15,),
                        //     child: SvgPicture.asset(compassTextFiledIcon),),
                        //       suffixIcon: Padding(
                        //         padding: EdgeInsets.fromLTRB(8.0,8.0,8.0,15,),
                        //         child: SvgPicture.asset(IconsPathSign+"pincode.svg"),
                        //       ),
                        //       suffixIconConstraints:BoxConstraints(minHeight: ScreenConfig.screenHeight * 0.05,minWidth: ScreenConfig.screenWidth * 0.04)
                        //   ),
                        // ),
                        // TextFormField(
                        //   controller: _postalCodeController,
                        //   validator: (value) {
                        //     if(value == null || value.isEmpty){
                        //       _postal = false;
                        //       setState(() {});
                        //       if (value.length < 5) {
                        //         _postal = false;
                        //         setState(() {});
                        //         return null;
                        //       }}else{
                        //       return null;
                        //     }
                        //     return null;
                        //   },
                        //   decoration: InputDecoration(suffixIcon:_postal?null:Padding(
                        //     padding: const EdgeInsets.only(right:10.0),
                        //     child: Icon(Icons.error_outlined,color: Colors.red,),
                        //   ),hintStyle: _textStyle,border: InputBorder.none,isDense: true,hintText: "Postal code",prefixIconConstraints:BoxConstraints(minHeight: ScreenConfig.screenHeight * 0.05,minWidth: ScreenConfig.screenWidth * 0.04),prefixIcon:  Padding(
                        //     padding: EdgeInsets.fromLTRB(8.0,8.0,8.0,15,),
                        //     child: SvgPicture.asset(IconsPathSign+"postbox.svg"),
                        //   ),
                        //       // suffixIcon: Padding(
                        //       //   padding: EdgeInsets.fromLTRB(8.0,8.0,8.0,0,),
                        //       //   child: SvgPicture.asset(IconsPathSign+"pincode.svg"),
                        //       // ),
                        //       suffixIconConstraints:BoxConstraints(minHeight: ScreenConfig.screenHeight * 0.05,minWidth: ScreenConfig.screenWidth * 0.04)
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  height: ScreenConfig.screenHeight * 0.1,
                  child: Row(
                    children: [
                      Expanded(
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

                                Text("Already have an account?",
                                    style: TextStyle(
                                      color: CColors.missonGrey,
                                    )),

                                Text("SIGN",
                                    style: TextStyle(
                                      color: CColors.missonGrey,
                                    )),
                                // InkWell(onTap:()=> navigatorPushReplacedFun(context,LoginPage()),child: Text("SIGN IN",style: TextStyle(color:CColor.PRIMARYCOLOR,fontFamily: Product_Sans_Regular),)),
                              ],
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
                            color: CColors.missonButtonColor,
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
                                        child:
                                            SvgPicture.asset(nextScreenArrow)),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
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

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:mission_user/Controller/navigate_class.dart';
// import 'package:mission_user/Methods/Methods.dart';
// import 'package:mission_user/Value/CColor.dart';
// import 'package:mission_user/Value/ScreenConfig.dart';
// import 'package:mission_user/Value/Strings.dart';
// import 'package:mission_user/apis/api.dart';
//
// import 'Dashboard.dart';
// import 'SpalshScreen.dart';
//
//
// class SignUp extends StatefulWidget {
//   @override
//   _SignUpState createState() => _SignUpState();
// }
//
// class _SignUpState extends State<SignUp> {
//   void registerUser() async {
//     isConnectedToInternet().then((internet) {
//       if (internet != null && internet) {
//         showProgress(context, "Please wait.....");
//         //print('Device Token $deviceTok');
//         Map<String, String> parms ={
//           name:_fullNameController.text,
//           email:_emailAddressFieldController.text,
//           password:_passwordFieldController.text,
//           device_type:"ios",
//           deviceToken:"test",
//           mobile:_phoneNumberController.text,
//           gender:"male",
//           //image:
//           postalCode:_postalCodeController.text,
//         };
//         print("$parms");
//         register(parms).then((response) {
//           dismissDialog(context);
//           if (response.status) {
//
//             setString(userAuth, "Bearer " + response.data.token);
//             pushAndRemoveUntilFun(context,MainScreen());
//           } else {
//             dismissDialog(context);
//             if (!response.status)
//
//               print(response.error.toString());
//             showDialogBox(context, "Alert!", response.error.toString());
//           }
//         });
//       } else {
//         showDialogBox(context, internetError, pleaseCheckInternet);
//         dismissDialog(context);
//       }
//     });
//   }
//   TextEditingController _emailAddressFieldController = TextEditingController();
//   TextEditingController _passwordFieldController = TextEditingController();
//   TextEditingController _reEnterPasswordFieldController = TextEditingController();
//   TextEditingController _phoneNumberController = TextEditingController();
//   TextEditingController _locationController = TextEditingController();
//   TextEditingController _fullNameController = TextEditingController();
//   TextEditingController _postalCodeController = TextEditingController();
//
//   TextStyle _textStyle = TextStyle(
//     color: Colors.grey,
//     );
//   final _formKey = GlobalKey<FormState>();
//   var height = AppBar().preferredSize.height;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         elevation: 0,
//         toolbarHeight: ScreenConfig.screenHeight * 0.20,
//         automaticallyImplyLeading: false,
//         //leading: new Container(),
//         backgroundColor: CColor.PRIMARYCOLOR,title: Container(
//         width: ScreenConfig.screenWidth,
//         child: Column(children: [
//           Text(Simple_way,style: TextStyle(color: Colors.white,fontFamily: Product_Sans_Regular,fontSize: 28),),
//           SizedBox(height: ScreenConfig.screenHeight * 0.02,),
//           Text(Please_register,style: TextStyle(color: Colors.white,fontFamily: Product_Sans_Regular,fontSize: 16,fontWeight: FontWeight.w200)),
//
//         ],),
//       ),),
//       body:
//       Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           child: Container(
//             height: ScreenConfig.screenHeight,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(height: ScreenConfig.screenHeight * 0.24),
//                 Align(alignment: Alignment(-0.7,0),child: SvgPicture.asset(ImagePath + cut)),
//                 SizedBox(height: ScreenConfig.screenHeight * 0.03),
//                 Text(Fill_the,style: TextStyle(color: Colors.black,fontFamily: Product_Sans_Regular,fontSize: 16,fontWeight: FontWeight.w300)),
//
//                 Padding(
//                   padding: EdgeInsets.all(30),
//                   child: Container(
//               //     height: ScreenConfig.screenHeight * 0.38,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(
//                           Radius.circular(8.0) //                 <--- border radius here
//                       ),
//              border: Border.all(color: Colors.black),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         mainAxisSize:MainAxisSize.max,
//                       children: [
//                     TextFormField(
//               validator: (value) {
//                   if (value == null || value.isEmpty) {
//                   return 'Please enter full name';
//                   }
//                   return null;
//                   },
//                       controller: _fullNameController,
//                        decoration: InputDecoration(hintStyle: _textStyle,isDense: true,hintText: "Full Name",prefixIconConstraints:BoxConstraints(minHeight: ScreenConfig.screenHeight * 0.05,minWidth: ScreenConfig.screenWidth * 0.04),prefixIcon:  Padding(
//                          padding: EdgeInsets.fromLTRB(8.0,8.0,8.0,15,),
//                          child: SvgPicture.asset(IconsPathSign+"user.svg"),
//                        )),
//                     ),
//                         TextFormField(
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter email address';
//                             }
//                             return null;
//                           },
//                           controller: _emailAddressFieldController,
//                           decoration: InputDecoration(hintStyle: _textStyle,isDense: true,hintText: "Email Address",prefixIconConstraints:BoxConstraints(minHeight: ScreenConfig.screenHeight * 0.05,minWidth: ScreenConfig.screenWidth * 0.04),prefixIcon:  Padding(
//                             padding: EdgeInsets.fromLTRB(8.0,8.0,8.0,15,),
//                             child: SvgPicture.asset(IconsPathSign+"message.svg"),
//                           )),
//                         ),
//                         TextFormField(
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter password';
//                             }
//                             return null;
//                           },
//                           controller: _passwordFieldController,
//                           decoration: InputDecoration(hintStyle: _textStyle,isDense: true,hintText: "Password",prefixIconConstraints:BoxConstraints(minHeight: ScreenConfig.screenHeight * 0.05,minWidth: ScreenConfig.screenWidth * 0.04),prefixIcon:  Padding(
//                             padding: EdgeInsets.fromLTRB(8.0,8.0,8.0,15,),
//                             child: SvgPicture.asset(IconsPathSign+"password.svg"),
//                           )),
//                         ),  TextFormField(
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please re-enter password';
//                             }
//                             return null;
//                           },
//                           controller: _reEnterPasswordFieldController,
//                           decoration: InputDecoration(hintStyle: _textStyle,isDense: true,hintText: "Re-enter Password",prefixIconConstraints:BoxConstraints(minHeight: ScreenConfig.screenHeight * 0.05,minWidth: ScreenConfig.screenWidth * 0.04),prefixIcon:  Padding(
//                             padding: EdgeInsets.fromLTRB(8.0,8.0,8.0,15,),
//                             child: SvgPicture.asset(IconsPathSign+"password.svg"),
//                           )),
//                         ),
//                         TextFormField(
//                           controller: _phoneNumberController,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter phone number';
//                             }
//                             return null;
//                           },
//                           decoration: InputDecoration(hintStyle: _textStyle,isDense: true,hintText: "Phone Number",prefixIconConstraints:BoxConstraints(minHeight: ScreenConfig.screenHeight * 0.05,minWidth: ScreenConfig.screenWidth * 0.04),prefixIcon:  Padding(
//                             padding: EdgeInsets.fromLTRB(8.0,8.0,8.0,15,),
//                             child: SvgPicture.asset(IconsPathSign+"phone.svg"),
//                           )),
//                         ),
//                         TextFormField(
//                           controller: _locationController,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter location';
//                             }
//                             return null;
//                           },
//                           decoration: InputDecoration(hintStyle: _textStyle,isDense: true,hintText: "Location",prefixIconConstraints:BoxConstraints(minHeight: ScreenConfig.screenHeight * 0.05,minWidth: ScreenConfig.screenWidth * 0.04),prefixIcon:  Padding(
//                             padding: EdgeInsets.fromLTRB(8.0,8.0,8.0,0,),
//                             child: SvgPicture.asset(IconsPathSign+"location.svg"),
//                           ),
//                             suffixIcon: Padding(
//                               padding: EdgeInsets.fromLTRB(8.0,8.0,8.0,0,),
//                               child: SvgPicture.asset(IconsPathSign+"pincode.svg"),
//                             ),
//                               suffixIconConstraints:BoxConstraints(minHeight: ScreenConfig.screenHeight * 0.05,minWidth: ScreenConfig.screenWidth * 0.04)
//                           ),
//                         ),
//                         TextFormField(
//                           controller: _postalCodeController,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter location';
//                             }
//                             return null;
//                           },
//                           decoration: InputDecoration(hintStyle: _textStyle,border: InputBorder.none,isDense: true,hintText: "Postal code",prefixIconConstraints:BoxConstraints(minHeight: ScreenConfig.screenHeight * 0.05,minWidth: ScreenConfig.screenWidth * 0.04),prefixIcon:  Padding(
//                             padding: EdgeInsets.fromLTRB(8.0,8.0,8.0,0,),
//                             child: SvgPicture.asset(IconsPathSign+"postbox.svg"),
//                           ),
//                             // suffixIcon: Padding(
//                             //   padding: EdgeInsets.fromLTRB(8.0,8.0,8.0,0,),
//                             //   child: SvgPicture.asset(IconsPathSign+"pincode.svg"),
//                             // ),
//                               suffixIconConstraints:BoxConstraints(minHeight: ScreenConfig.screenHeight * 0.05,minWidth: ScreenConfig.screenWidth * 0.04)
//                           ),
//                         ),
//                   ],),),
//                 ),
//
//                 Spacer(),
//                 Row(
//                   children:[
//                     Expanded(
//                       child: Container(
//                           height: ScreenConfig.screenHeight * 0.08,
//                         decoration: BoxDecoration(
//                           border: Border(
//                             top: BorderSide(
//                               color: Color(0xFF8A9EAD)
//                             )
//                           )
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.fromLTRB(15.0,8.0,8.0,8.0,),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text("Already have an account?",style: TextStyle(color: CColor.grayOut,fontFamily: Product_Sans_Regular,)),
//                               Text("SIGN IN",style: TextStyle(color:CColor.PRIMARYCOLOR,fontFamily: Product_Sans_Regular),),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: InkWell(
//                         onTap: (){
//
//                           if (_formKey.currentState.validate()) {
//                             registerUser();
//                             // ScaffoldMessenger.of(context)
//                             //     .showSnackBar(SnackBar(content: Text('Processing Data 1')));
//                           }else{
//                             // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Processing Data 2')));
//                           }
//
//                         },
//                         child: Container(
//                           width: ScreenConfig.screenWidth /2,
//                           color: CColor.buttonColor,
//                       height: ScreenConfig.screenHeight * 0.08,
//                           child:Align(alignment: Alignment.center,child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text("SIGN UP",style: TextStyle(color: Colors.white,fontFamily: Product_Sans_Regular)),
//                                SizedBox(width: ScreenConfig.screenWidth * 0.04,),
//                               RotatedBox(
//                                   quarterTurns: 2,
//                                   child: SvgPicture.asset(IconsPathSign + signForword)),
//                             ],
//                           )),
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//         extendBodyBehindAppBar: true,
//     );
//   }
// }
