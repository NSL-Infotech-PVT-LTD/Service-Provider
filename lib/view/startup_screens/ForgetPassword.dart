import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:misson_tasker/model/ApiCaller.dart';
import 'package:misson_tasker/model/api_models/ForgetPasswordModel.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/NavMe.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';
import 'package:misson_tasker/view/startup_screens/SplashScreen.dart';

import '../Dashboard.dart';
import 'LoginPage.dart';

final _formKey = GlobalKey<FormState>();

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emailAddressFieldController = TextEditingController();
  ForgetPasswordModel forgetPasswordobj;
  bool isLoading =false;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  void forgotPassApi() async {
    ApiCaller()
        .forgetMyPassword(email: _emailAddressFieldController.text)
        .then((value) => forgetPasswordobj = value)
        .whenComplete(() {
      setState(() {
        isLoading = false;
      });
      // print(forgetPasswordobj.toJson());
if(forgetPasswordobj!=null  && forgetPasswordobj.code==201)
  {

    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Info'),
          content: Text('${forgetPasswordobj.data.message}'),
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
    ).whenComplete(() {
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> LoginPage()));
      NavMe().NavPushReplaceFadeIn(LoginPage());

    });
  }
else
  if(forgetPasswordobj!=null && forgetPasswordobj.code==422)
    {

      return showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Info'),
            content: Text('${forgetPasswordobj.error}'),
            actions: [
              CupertinoDialogAction(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);

                  // NavMe().NavPushReplaceFadeIn(LoginPage());
                },
              ),
            ],
          );
        },
      );
    }
      return showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Info'),
            content: Text('${forgetPasswordobj.data.message}'),
            actions: [
              CupertinoDialogAction(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                  // NavMe().NavPushReplaceFadeIn(LoginPage());
                },
              ),
            ],
          );
        },
      );
    }).timeout(Duration(minutes: 1), onTimeout: () {
      setState(() {
        isLoading = false;
      });
      return showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Info'),
            content: Text('Something Went Wrong Please Try Again Later'),
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: ScreenConfig.screenHeight * 0.08,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: ScreenConfig.screenHeight * 0.20,
                ),
                TextFormField(
                  controller: _emailAddressFieldController,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.fromLTRB(
                        14.0,
                        14.0,
                        14.0,
                        10,
                      ),
                      child: SvgPicture.asset("assets/svg_assets/misson_textfield_message_icon.svg"),
                    ),
                    labelText: "Email Address",
                    fillColor: Colors.black,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 2.0,
                      ),
                    ),
                    focusColor:Colors.black,
                    labelStyle: TextStyle(color: Colors.black),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 2.0,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                  validator: (value) {
                    Pattern pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regex = new RegExp(pattern);
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    } else if (!regex.hasMatch(value)) {
                      return 'Enter Valid Email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: ScreenConfig.screenHeight * 0.04,
                ),
                SizedBox(
                  height: ScreenConfig.screenHeight * 0.08,
                  width: ScreenConfig.screenWidth * 0.70,
                  child: isLoading == false
                      ? ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {

                              isConnectedToInternet()
                                  .then((internet) {
                                if (internet != null && internet) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  forgotPassApi();
                                }
                                else {


                                  showCupertinoDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CupertinoAlertDialog(
                                        title: Text('Alert'),
                                        content: Text('Please Check internet connection'),
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
                              });




                              setState(() {
                                isLoading = true;
                              });

                              // ScaffoldMessenger.of(context)
                              //     .showSnackBar(SnackBar(content: Text('Processing Data 1')));
                            } else {
                              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Processing Data 2')));
                            }
                          },
                          child: Text("Send mail",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                          style: ElevatedButton.styleFrom(
                            primary: CColors.missonButtonColor2, // background
                            onPrimary: CColors.missonButtonColor2, // fo
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                                side: BorderSide(
                                    color:
                                        CColors.missonPrimaryColor) // reground,
                                ),
                          ),
                        )
                      : spinkit,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
