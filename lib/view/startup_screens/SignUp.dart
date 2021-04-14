import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:misson_tasker/model/ApiCaller.dart';
import 'package:misson_tasker/model/api_models/RegisterNewUserModel.dart';
import 'package:misson_tasker/utils/NavMe.dart';
import 'package:misson_tasker/utils/SharedStrings.dart';
import 'package:misson_tasker/utils/local_data.dart';
import 'package:misson_tasker/view/Dashboard.dart';
import 'package:misson_tasker/view/startup_screens/PackageScreen.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/CColors.dart';
import '../../utils/ScreenConfig.dart';
import '../../utils/StringsPath.dart';
import 'LoginPage.dart';
import 'SplashScreen.dart';

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
  TextEditingController _id_number = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _postalCodeController = TextEditingController();
  bool ispermanentDenied = false;

  final _formKey = GlobalKey<FormState>();
  String deviceTok = 'iu';
  bool _username = true;
  bool _pass = true;
  bool _repass = true;
  bool _mailer = true;
  bool _phone = true;
  bool _location = true;
  bool _id = true;
  // bool _postal = true;
  var height = AppBar().preferredSize.height;
  String _selectedRadioValue;
  String lat;
  String lang;
  String locationName;
  var addresses;
  bool isLoading = false;
  String postalCode;
  var spinkit;
  Position position;
  bool islocationAvailible = false;
  LocationPermission permission;
  bool serviceEnabled;
  bool isPasswordShown = false;
  bool isRePasswordShown = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<Position> _determinePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  Future<bool> checkPermisson() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();
    bool isallowed = false;

    if (permission == LocationPermission.always) {
      ispermanentDenied = false;

      callMe();
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        ispermanentDenied = true;
        print("EAWDASEFAF");
        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text('Please allow Permission'),
              content: Text(
                  'Go to the setting and allow the location permission to the app'),
              actions: [
                CupertinoDialogAction(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                    openAppSettings().then((value) {
                      isallowed = true;
                    }).whenComplete(() {
                      // callMe();
                    });
                    // openAppSettings();
                    // Navigator.pop(context);
                  },
                ),
                CupertinoDialogAction(
                  child: Text('cancel'),
                  onPressed: () {
                    Navigator.pop(context);

                    // openAppSettings();
                    // Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
        // Permissions are denied forever, handle appropriately.
        return Future.value().whenComplete(() {
          callMe();
        });
      }

      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.

        return Future.error('Location permissions are denied');
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    checkPermisson().whenComplete(() {
      if (permission == LocationPermission.deniedForever) {
        ispermanentDenied = false;

        callMe();
      }
    });
    super.initState();


    spinkit = SpinKitWave(
      size: 35,
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
    _selectedRadioValue = radioList.elementAt(0);

    // _determinePosition().then((value) {
    //   position = value;
    // }).whenComplete(() {
    //   if (position != null) {
    //     setString(sharedPref.userCurrentLat, position.latitude.toString());
    //     setString(sharedPref.userCurrentLang, position.longitude.toString());
    //     getString(SharedPref().userCurrentLat)
    //         .then((value) {
    //       lat=value;
    //
    //     })
    //         .whenComplete(() {
    //       getString(SharedPref().userCurrentLang)
    //           .then((value) {
    //             lang=value;
    //       })
    //           .whenComplete(() {
    //         getLocationName(Position(
    //             latitude: double.parse(lat), longitude: double.parse(lang)))
    //             .then((value) {
    //           setState(() {
    //             // _locationController.text = value.elementAt(0).addressLine;
    //             // value.forEach((element){print("QWER ${element.addressLine}");});
    //             print(value
    //                 .elementAt(0)
    //                 .addressLine);
    //             _locationController.text = value
    //                 .elementAt(0)
    //                 .addressLine;
    //             postalCode = value
    //                 .elementAt(0)
    //                 .postalCode;
    //           });
    //         }).whenComplete(() {
    //           setState(() {
    //             islocationAvailible = true;
    //           });
    //         });
    //       });
    //     });
    //   }
    // });

    // getString(SharedPref().userCurrentLat).then((value) => lat = value);
    // getString(SharedPref().userCurrentLang)
    //     .then((value) => lang = value)
    //     .whenComplete(() =>
    // {
    //   // getLocationName(Position(
    //   //         latitude: double.parse(lat),
    //   //         longitude: double.parse(lang)))
    //   //     .then((value) {
    //   //   setState(() {
    //   //     // _locationController.text = value.elementAt(0).addressLine;
    //   //     // value.forEach((element){print("QWER ${element.addressLine}");});
    //   //     print(value.elementAt(0).addressLine);
    //   //     _locationController.text = value.elementAt(0).addressLine;
    //   //     postalCode = value.elementAt(0).postalCode;
    //   //   });
    //   // })
    // });
  }

  Future<List<Address>> getLocationName(Position pos) async {
    return await Geocoder.local
        .findAddressesFromCoordinates(Coordinates(pos.latitude, pos.longitude));
  }

  RegisterNewUserModel registerNewUserModel;

  void registerUser() async {
    ApiCaller()
        .registerUser(
            fullName: _fullNameController.text,
            email: _emailAddressFieldController.text,
            password: _passwordFieldController.text,
            phonenumber: _phoneNumberController.text,
            location: _locationController.text,
            idName: _selectedRadioValue,
            idNumber: _id_number.text,
            lat: lat,
            lang: lang,
            deviceType: "android",
            deviceToken: "sdgdfgfgfdg",
            postalCode: postalCode)
        .then((value) {
      registerNewUserModel = value;
    }).whenComplete(() {
      if (registerNewUserModel != null &&
          registerNewUserModel.code == 201 &&
          registerNewUserModel.data != null &&
          registerNewUserModel.data.user != null) {
        setState(() {
          isLoading = false;
        });
        // setString(sharedPref.userEmail, registerNewUserModel.data.user.email);
        // setString(sharedPref.userName, registerNewUserModel.data.user.name);

        // setString(sharedPref.userToken, registerNewUserModel.data.token);
        // setString(
        //     sharedPref.userLocation, registerNewUserModel.data.user.location);
        // setString(
        //     sharedPref.userPhoneNumber, registerNewUserModel.data.user.mobile);

        // getString(sharedPref.userPhoneNumber)
        //     .then((value) => print("123 $value"));

        // getString(sharedPref.userToken).then((value) => print("123 $value"));

        // getString(sharedPref.userEmail).then((value) => print("123 $value"));

        // getString(sharedPref.userLocation).then((value) => print("123 $value"));
        // getString(sharedPref.userLocation).then((value) => print("123 $value"));

        Get.off(PackageScreen(), transition: Transition.rightToLeft);
      } else if (registerNewUserModel != null &&
          registerNewUserModel.code == 422) {
        setState(() {
          isLoading = false;
        });
        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text('Alert'),
              content: Text('${registerNewUserModel.error}'),
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

  void callMe() {
    _determinePosition().then((value) {
      position = value;
    }).whenComplete(() {
      if (position != null) {
        setString(sharedPref.userCurrentLat, position.latitude.toString());
        setString(sharedPref.userCurrentLang, position.longitude.toString());
        getString(SharedPref().userCurrentLat).then((value) {
          lat = value;
        }).whenComplete(() {
          getString(SharedPref().userCurrentLang).then((value) {
            lang = value;
          }).whenComplete(() {
            getLocationName(Position(
                    latitude: double.parse(lat), longitude: double.parse(lang)))
                .then((value) {
              setState(() {
                // _locationController.text = value.elementAt(0).addressLine;
                // value.forEach((element){print("QWER ${element.addressLine}");});
                print(value.elementAt(0).addressLine);
                _locationController.text = value.elementAt(0).addressLine;
                postalCode = value.elementAt(0).postalCode;
              });
            }).whenComplete(() {
              setState(() {
                islocationAvailible = true;
              });
            });
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                        padding: EdgeInsets.only(left: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Simple way to Sign up",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
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
                      )),
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
                        Padding(
                          padding: const EdgeInsets.only(left: 28.0),
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
                          ),
                        ),
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
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7.5),
                                  child: TextFormField(
                                    readOnly: isLoading == false ? false : true,
                                    keyboardType: TextInputType.name,
                                    inputFormatters: [
                                      new FilteringTextInputFormatter.allow(
                                          RegExp("[a-zA-Z]")),
                                    ],
                                    // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        _username = false;

                                        setState(() {});
                                        return null;
                                        if (value.length < 5) {
                                          _username = false;
                                          setState(() {});
                                          return null;
                                        }
                                      } else if (value.length < 2) {
                                        _username = false;
                                        return null;
                                        // return "A user name must have more that 1 word";
                                      } else {
                                        _username = true;
                                        setState(() {

                                        });
                                        return null;
                                      }
                                      // return null;
                                    },
                                    controller: _fullNameController,
                                    decoration: InputDecoration(
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: CColors
                                                  .missonGreyBorderColor),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: CColors
                                                  .missonGreyBorderColor),
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
                                                ScreenConfig.screenHeight *
                                                    0.05,
                                            minWidth: ScreenConfig.screenWidth *
                                                0.04),
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
                                ),

                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7.5),
                                  child: TextFormField(
                                    readOnly: isLoading == false ? false : true,
                                    validator: (value) {
                                      Pattern pattern =
                                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                      RegExp regex = new RegExp(pattern);
                                      if (value == null || value.isEmpty) {
                                        _mailer = false;
                                        // return "Please fill the email";
                                        setState(() {});

                                        return null;
                                      }  else if (!regex.hasMatch(value)) {
                                        _mailer = false;
                                        // return "Please fill the email";
                                        setState(() {});

                                        return null;
                                      } else {
                                        _mailer = true;
                                        setState(() {

                                        });
                                        return null;
                                      }
                                      return null;
                                    },
                                    controller: _emailAddressFieldController,
                                    decoration: InputDecoration(
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: CColors
                                                  .missonGreyBorderColor),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: CColors
                                                  .missonGreyBorderColor),
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
                                                ScreenConfig.screenHeight *
                                                    0.05,
                                            minWidth: ScreenConfig.screenWidth *
                                                0.04),
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
                                ),

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
                                        setState(() {

                                        });
                                        return null;
                                      }
                                      // return null;
                                    },
                                    obscureText: !isPasswordShown,
                                    controller: _passwordFieldController,
                                    decoration: InputDecoration(
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: CColors
                                                  .missonGreyBorderColor),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: CColors
                                                  .missonGreyBorderColor),
                                        ),
                                        suffixIcon: _pass
                                            ? InkWell(
                                          onTap: () {
                                            setState(() {
                                              isPasswordShown = !isPasswordShown;
                                            });
                                          },
                                          child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                16.0,
                                                8.0,
                                                16.0,
                                                15,
                                              ),
                                              child: isPasswordShown == true
                                                  ? SvgPicture.asset(
                                                "assets/svg_assets/eye_open.svg",
                                                height: 25,
                                              )
                                                  : SvgPicture.asset(
                                                "assets/svg_assets/eye_close.svg",height: 25,)),
                                        )
                                            : Icon(
                                                Icons.error_outlined,
                                                color: Colors.red,
                                              ),
                                        hintStyle: _textStyle,
                                        isDense: true,
                                        hintText: "Password",
                                        prefixIconConstraints: BoxConstraints(
                                            minHeight:
                                                ScreenConfig.screenHeight *
                                                    0.05,
                                            minWidth: ScreenConfig.screenWidth *
                                                0.04),
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
                                        _repass = false;
                                        setState(() {});
                                        return null;
                                      } else if (value.length < 5) {
                                        _repass = false;
                                        setState(() {});
                                        return null;
                                      } else {
                                        _repass = true;
                                        setState(() {

                                        });
                                        return null;
                                      }
                                      return null;
                                    },
                                    controller: _reEnterPasswordFieldController,
                                    obscureText: !isRePasswordShown,
                                    decoration: InputDecoration(
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: CColors
                                                  .missonGreyBorderColor),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: CColors
                                                  .missonGreyBorderColor),
                                        ),
                                        suffixIcon: _repass
                                            ?InkWell(
                                          onTap: () {
                                            setState(() {
                                              isRePasswordShown = !isRePasswordShown;
                                            });
                                          },
                                          child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                16.0,
                                                8.0,
                                                16.0,
                                                15,
                                              ),
                                              child: isRePasswordShown == true
                                                  ? SvgPicture.asset(
                                                "assets/svg_assets/eye_open.svg",
                                                height: 25,
                                              )
                                                  : SvgPicture.asset(
                                                "assets/svg_assets/eye_close.svg",height: 25,)),
                                        )
                                            : Icon(
                                                Icons.error_outlined,
                                                color: Colors.red,
                                              ),
                                        hintStyle: _textStyle,
                                        isDense: true,
                                        hintText: "Re-enter Password",
                                        prefixIconConstraints: BoxConstraints(
                                            minHeight:
                                                ScreenConfig.screenHeight *
                                                    0.05,
                                            minWidth: ScreenConfig.screenWidth *
                                                0.04),
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
                                    keyboardType: TextInputType.phone,
                                    controller: _phoneNumberController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        _phone = false;
                                        setState(() {});
                                        return null;
                                      } else if (value.length < 10) {
                                        // _phone = false;
                                        _phone = false;
                                        setState(() {});
                                        return null;


                                        // return null;
                                      } else if (value.length > 13) {
                                        // _phone = false;
                                        _phone = false;
                                        setState(() {});
                                        return null;


                                        // return null;
                                      } else {
                                        _phone = true;
                                        setState(() {});
                                        return null;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: CColors
                                                  .missonGreyBorderColor),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: CColors
                                                  .missonGreyBorderColor),
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
                                                ScreenConfig.screenHeight *
                                                    0.05,
                                            minWidth: ScreenConfig.screenWidth *
                                                0.04),
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
                                ),

                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        _locationController.text = "Loading......";
                                      });
                                      callMe();
                                    },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 7.5),
                                    child: TextFormField(
                                        readOnly: true,
                                        controller: _locationController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            // _pass = false;
                                            setState(() {
                                              _location=false;
                                            });

                                            return null;
                                          } else if (value == "Loading......") {
                                            // _pass = false;
                                            if (ispermanentDenied == true) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Please Enable Location from settings')));
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Please wait accept the location permission')));
                                            }
                                          } else {
                                            return null;
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(

                                          focusColor: CColors
                                              .missonGreyBorderColor,
                                          focusedBorder:UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: CColors
                                                    .missonGreyBorderColor),
                                          ) ,
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: CColors
                                                    .missonGreyBorderColor),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: CColors
                                                    .missonGreyBorderColor),
                                          ),
                                          suffixIcon: InkWell(
                                            onTap: () {
                                              setState(() {
                                                _locationController.text = "Loading......";
                                              });
                                              callMe();
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                16.0,
                                                8.0,
                                                16.0,
                                                15,
                                              ),
                                              child: SvgPicture.asset(
                                                  myLocationIcon),
                                            ),
                                          ),
                                          hintStyle: _textStyle,
                                          isDense: true,
                                          hintText: "Location",
                                          prefixIconConstraints: BoxConstraints(
                                              minHeight:
                                                  ScreenConfig.screenHeight *
                                                      0.05,
                                              minWidth:
                                                  ScreenConfig.screenWidth *
                                                      0.04),
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                              16.0,
                                              8.0,
                                              16.0,
                                              15,
                                            ),
                                            child: SvgPicture.asset(
                                                compassTextFiledIcon),
                                          ),
                                        )),
                                  ),
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
                                  readOnly: isLoading == false ? false : true,
                                  controller: _id_number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      _id = false;
                                      setState(() {});
                                      return null;
                                    }
                                    _id = true;
                                    setState(() {

                                    });
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      suffixIcon: _id
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
                      child: InkWell(
                        onTap: isLoading == false
                            ? () =>
                                NavMe().NavPushReplaceLeftToRight(LoginPage())
                            : null,
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
                                        color: CColors.missonPrimaryColor,
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
                                _mailer == true &&
                                _pass == true &&
                                _repass == true &&
                                _id == true &&
                                _phone == true
                              ){
                              isConnectedToInternet().then((internet) {
                                if (internet != null && internet) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  registerUser();
                                }
                                else {
                                  return showCupertinoDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CupertinoAlertDialog(
                                        title: Text('Alert'),
                                        content: Text(
                                            'Please Check internet connection'),
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
                            }


                              // setState(() {
                              //   isLoading = true;
                              // });


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
                              child: isLoading == false
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("SIGN UP",
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
                                    )
                                  : spinkit),
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
