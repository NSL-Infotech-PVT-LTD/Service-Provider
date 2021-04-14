import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:misson_tasker/model/ApiCaller.dart';
import 'package:misson_tasker/model/api_models/GetProfileDataModel.dart';
import 'package:misson_tasker/model/api_models/UpdateProfileDataModel.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';
import 'package:misson_tasker/utils/StringsPath.dart';
import 'package:misson_tasker/utils/local_data.dart';
import 'package:misson_tasker/view/startup_screens/SplashScreen.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File file;
  var image = "";
  String pickedFile;
  final picker = ImagePicker();
  bool imageLoader = false;
  String lat;
  String lang;
  UpdateProfileDataModel _profileDataModel;

  // Future getImage(int type) async {
  //   Navigator.of(context).pop();
  //   if (type == 1) {
  //     var pickedFile = await picker.getImage(
  //         source: ImageSource.camera, imageQuality: 50);
  //     setState(() {
  //       if (pickedFile != null) {
  //         file = File(pickedFile.path);
  //       }
  //     });
  //   } else {
  //     var pickedFile = await picker.getImage(
  //         source: ImageSource.gallery, imageQuality: 50);
  //     setState(() {
  //       if (pickedFile != null) {
  //         file = File(pickedFile.path);
  //       }
  //     });
  //   }
  // }

  Widget circleImage() {
    if (file == null) {
      if (pickedFile == null && image == "") {
        return SvgPicture.asset(avatar1);
      } else {
        //    setString(userImage, pickedFile);
        // print(forImage + pickedFile);
        return CircleAvatar(
          child: image != null
              ? CircleAvatar(
                  radius: 52.0,
                  backgroundImage: NetworkImage(image),
                  backgroundColor: Colors.transparent,
                )
              : SvgPicture.asset(avatar1),
          radius: 52.0,
          //  backgroundImage:NetworkImage(image),
          backgroundColor: Colors.transparent,
        );
      }
    } else {
      return ClipOval(child: Image.file(file));
    }
  }

  bool isLoading = true;
  TextEditingController _fullName = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _number = TextEditingController();
  TextEditingController _location = TextEditingController();
  TextEditingController _postal = TextEditingController();

  // void registerUser() async {
  //   isConnectedToInternet().then((internet) {
  //     if (internet != null && internet) {
  //       showProgress(context, "Please wait.....");
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
  //       getString(userAuth).then((value) {
  //         print("Now user profile api hit "+userAuth.toString());
  //         getProfile(value).then((response) {
  //          dismissDialog(context);
  //           if (response.status) {
  //             print(response.status.toString());
  //             setState(() {
  //               _fullName.text = response.data.user.name != null?response.data.user.name:"No data found";
  //               _email.text = response.data.user.email != null?response.data.user.email:"No data found";
  //               _number.text = response.data.user.mobile!= null?response.data.user.mobile:"No data found";
  //               _location.text = response.data.user.location!= null?response.data.user.location:"No data found";
  //       //        image = response.data.user.location!= null?response.data.user.location:"No data found";
  //               _postal.text = "12345";
  //               image = response.data.user.image!= null?response.data.user.image:null;
  //               isLoading = false;
  //             });
  //             //setString(userAuth, "Bearer " + response.data.token);
  //             // pushAndRemoveUntilFun(context,MainScreen());
  //           } else {
  //             showDialogBox(context, "Alert!", response.error.toString());
  //             setState(() {
  //               isLoading = false;
  //             });
  //            dismissDialog(context);
  //             if (!response.status){
  //               print(response.error.toString());
  //               showDialogBox(context, "Alert!", response.error.toString());
  //             }
  //           }
  //         });
  //       });
  //     } else {
  //       showDialogBox(context, internetError, pleaseCheckInternet);
  //      dismissDialog(context);
  //     }
  //   });
  // }

  // getCurrentLocation()async{
  //   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //   print(position.toString());
  // }

  // void updateUser() async {
  //   isConnectedToInternet().then((internet) {
  //     if (internet != null && internet) {
  //
  //       //print('Device Token $deviceTok');
  //       Map<String, String> parms ={
  //         name:_fullName.text,
  //         email:_email.text,
  //         "status": "1",
  //        // "image": "dummy",
  //         "role": "[]",
  //         //password:_passwordFieldController.text,
  //         device_type:"ios",
  //         deviceToken:"test",
  //        // mobile:_phoneNumberController.text,
  //         gender:"male",
  //     //    image:if(file)
  //       //  postalCode:_postalCodeController.text,
  //       };
  //       //  print("$parms");
  //       getString(userAuth).then((value) {
  //         print("Now user update api hit "+userAuth.toString());
  //         updateUserApi(file,value,parms).then((response) {
  //          dismissDialog(context);
  //           if (response.status) {
  //             setString(profilePic,response.data.user.image);
  //             setString(name,response.data.user.name);
  //             pushAndRemoveUntilFun(context,DashBoard());
  //             print(response.status.toString());
  //             setState(() {
  //               circleImage();
  //               showDialogBox(context, "Submit", response.data.message.toString());
  //               isLoading = false;
  //             });
  //             //setString(userAuth, "Bearer " + response.data.token);
  //             // pushAndRemoveUntilFun(context,MainScreen());
  //           } else {
  //             showDialogBox(context, "Alert!", response.error.toString());
  //             setState(() {
  //               isLoading = false;
  //             });
  //            dismissDialog(context);
  //             if (!response.status){
  //               print(response.error.toString());
  //               showDialogBox(context, "Alert!", response.error.toString());
  //             }
  //           }
  //         });
  //       });
  //     } else {
  //       showDialogBox(context, internetError, pleaseCheckInternet);
  //      dismissDialog(context);
  //     }
  //   });
  // }

  updateUser() async {
    getString(sharedPref.userToken).then((value) {
      auth = value;

      print("123 $value");
    }).whenComplete(() {
      ApiCaller()
          .updateUserApi(auth: auth, file: file, params: {
            "name": "${_fullName.text}",
            "location": "${_location.text}",
            "lattitude": "$lat",
            "longitude": "$lang",
            "mobile": "${_number.text}",
            "postal_code": "${_postal.text}",
          })
          .then((value) => _profileDataModel = value)
          .whenComplete(() {
            setState(() {
              isLoadingApi = false;

              _fullName.text = _profileDataModel.data.user.name;
              _email.text = _profileDataModel.data.user.email;
              _number.text = _profileDataModel.data.user.mobile;
              _location.text = _profileDataModel.data.user.location;
              _postal.text = _profileDataModel.data.user.postalCode;
            });
          })
          .whenComplete(() {
            showCupertinoDialog(
              context: context,
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  title: Text('Alert'),
                  content: Text('${_profileDataModel.data.message}'),
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

  bool isLoadingData = true;
  bool isLoadingApi = false;
  String auth;
  var spinkit;
  GetProfileDataModel getProfileDataModel;

  @override
  void initState() {
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

          _fullName.text = getProfileDataModel.data.user.name;
          _email.text = getProfileDataModel.data.user.email;
          _number.text = getProfileDataModel.data.user.mobile;
          _location.text = getProfileDataModel.data.user.location;
          _postal.text = getProfileDataModel.data.user.postalCode;
          lat = getProfileDataModel.data.user.latitude;
          lang = getProfileDataModel.data.user.longitude;
        });
      });
    });
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
                title: Text('Select Options'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () async {
                          imageLoader = true;
                          await picker
                              .getImage(source: ImageSource.camera)
                              .then((value) {
                            if (value != null) {
                              Navigator.of(context).pop();
                              imageLoader = false;
                              setState(() {
                                file = File(value.path);
                                //  Navigator.of(context).pop();
                              });
                              print("file Select " + file.path.toString());
                            }
                          });
                        },
                        child: const Text('Camera',
                            style: TextStyle(fontSize: 15)),
                      ),
                      RaisedButton(
                        onPressed: () async {
                          imageLoader = true;
                          await picker
                              .getImage(source: ImageSource.gallery)
                              .then((value) {
                            if (value != null) {
                              Navigator.of(context).pop();
                              imageLoader = false;
                              setState(() {
                                file = File(value.path);
                                //  Navigator.of(context).pop();
                              });
                              print("file Select " + file.path.toString());
                            }
                          });
                        },
                        child: const Text('Gallery',
                            style: TextStyle(fontSize: 15)),
                      ),
                      imageLoader
                          ? Center(
                              child: CircularProgressIndicator(
                              backgroundColor: Colors.black,
                            ))
                          : Container(),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ]);
          });
    }

    TextStyle _textStyle = TextStyle(
      color: Colors.grey,
    );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        //    centerTitle: true,
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),

        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24.0,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        //   toolbarHeight: ScreenConfig.screenHeight * 0.25,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: ScreenConfig.screenHeight * 0.88,
          child: Stack(
            children: [
              Container(
                color: Colors.white,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          _showMyDialog();
                        },
                        child: Container(
                          height: ScreenConfig.screenHeight * 0.15,
                          child: CircleAvatar(
                            backgroundColor: CColors.missonGrey,
                            radius: 47,
                            child: CircleAvatar(
                              backgroundImage: file == null
                                  ? getProfileDataModel == null ||
                                          getProfileDataModel.data == null ||
                                          getProfileDataModel.data.user ==
                                              null ||
                                          getProfileDataModel.data.user.image ==
                                              null
                                      ? AssetImage(avatar1)
                                      : NetworkImage(
                                          "${getProfileDataModel.data.user.image}")
                                  : FileImage(file),
                              child: Opacity(
                                  opacity: 0.5,
                                  child: CircleAvatar(
                                    child: Center(
                                        child: SvgPicture.asset(
                                      cameraLogo,
                                      height: 75,
                                    )),
                                    backgroundColor: Colors.black,
                                    radius: 45,
                                  )),
                              radius: 45,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 20.0, left: 30, right: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Full name",
                              style: TextStyle(
                                  fontSize: 12, color: CColors.textColor),
                            ),
                            TextFormField(
                              controller: _fullName,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintStyle: _textStyle,
                                  isDense: true,
                                  hintText: "Full name",
                                  prefixIconConstraints: BoxConstraints(
                                      minHeight:
                                          ScreenConfig.screenHeight * 0.05,
                                      minWidth:
                                          ScreenConfig.screenWidth * 0.04),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                      8.0,
                                      8.0,
                                      8.0,
                                      15,
                                    ),
                                    child: SvgPicture.asset(userIcon),
                                  )),
                            ),
                            SizedBox(height: ScreenConfig.screenHeight * 0.02),
                            Text(
                              "Message",
                              style: TextStyle(
                                  fontSize: 12, color: CColors.textColor),
                            ),
                            TextFormField(
                              readOnly: true,
                              controller: _email,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintStyle: _textStyle,
                                  isDense: true,
                                  hintText: "Message",
                                  prefixIconConstraints: BoxConstraints(
                                      minHeight:
                                          ScreenConfig.screenHeight * 0.05,
                                      minWidth:
                                          ScreenConfig.screenWidth * 0.04),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                      8.0,
                                      8.0,
                                      8.0,
                                      15,
                                    ),
                                    child: SvgPicture.asset(messageIcon),
                                  )),
                            ),
                            SizedBox(height: ScreenConfig.screenHeight * 0.02),
                            Text(
                              "Contact Number",
                              style: TextStyle(
                                  fontSize: 12, color: CColors.textColor),
                            ),
                            TextFormField(
                              readOnly: true,
                              controller: _number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintStyle: _textStyle,
                                  isDense: true,
                                  hintText: "Contact Number",
                                  prefixIconConstraints: BoxConstraints(
                                      minHeight:
                                          ScreenConfig.screenHeight * 0.05,
                                      minWidth:
                                          ScreenConfig.screenWidth * 0.04),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                      8.0,
                                      8.0,
                                      8.0,
                                      15,
                                    ),
                                    child: SvgPicture.asset(PhoneIcon),
                                  )),
                            ),
                            SizedBox(height: ScreenConfig.screenHeight * 0.02),
                            Text(
                              "Location",
                              style: TextStyle(
                                  fontSize: 12, color: CColors.textColor),
                            ),
                            TextFormField(
                              readOnly: true,
                              controller: _location,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _location.text = "Loading......";
                                        _postal.text = "Loading......";
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
                                      child: SvgPicture.asset(myLocationIcon),
                                    ),
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
                                      8.0,
                                      8.0,
                                      8.0,
                                      15,
                                    ),
                                    child: SvgPicture.asset(compassIcon),
                                  )),
                            ),
                            SizedBox(height: ScreenConfig.screenHeight * 0.02),
                            Text(
                              "postal code",
                              style: TextStyle(
                                  fontSize: 12, color: CColors.textColor),
                            ),
                            TextFormField(
                              readOnly: true,
                              controller: _postal,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintStyle: _textStyle,
                                  isDense: true,
                                  hintText: "postal code",
                                  prefixIconConstraints: BoxConstraints(
                                      minHeight:
                                          ScreenConfig.screenHeight * 0.05,
                                      minWidth:
                                          ScreenConfig.screenWidth * 0.04),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                      8.0,
                                      8.0,
                                      8.0,
                                      15,
                                    ),
                                    child: SvgPicture.asset(postboxIcon),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: ScreenConfig.screenHeight * 0.08,
                      // ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: ScreenConfig.screenHeight * 0.06,
                  width: ScreenConfig.screenWidth * 0.70,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          isLoadingApi = true;
                          updateUser();
                        });
                        // updateUser();
                        // ScaffoldMessenger.of(context)
                        //     .showSnackBar(SnackBar(content: Text('Processing Data 1')));
                      } else {
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Processing Data 2')));
                      }
                    },
                    child: isLoadingApi == true
                        ? spinkit
                        : Text("Save",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      primary: CColors.missonButtonColor, // background
                      onPrimary: CColors.missonButtonColor, // fo
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(06.0),
                          side: BorderSide(
                              color: CColors.missonButtonColor) // reground,
                          ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Position position;

  void callMe() {
    _determinePosition().then((value) {
      position = value;
    }).whenComplete(() {
      if (position != null) {
        setString(sharedPref.userCurrentLat, position.latitude.toString());
        setString(sharedPref.userCurrentLang, position.longitude.toString());
        getString(sharedPref.userCurrentLat).then((value) {
          lat = value;
        }).whenComplete(() {
          getString(sharedPref.userCurrentLang).then((value) {
            lang = value;
          }).whenComplete(() {
            getLocationName(Position(
                    latitude: double.parse(lat), longitude: double.parse(lang)))
                .then((value) {
              setState(() {
                // _locationController.text = value.elementAt(0).addressLine;
                // value.forEach((element){print("QWER ${element.addressLine}");});
                print(value.elementAt(0).addressLine);
                _location.text = value.elementAt(0).addressLine;
                _postal.text = value.elementAt(0).postalCode;
              });
            }).whenComplete(() {
              setState(() {
                // islocationAvailible = true;
              });
            });
          });
        });
      }
    });
  }

  Future<Position> _determinePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  Future<List<Address>> getLocationName(Position pos) async {
    return await Geocoder.local
        .findAddressesFromCoordinates(Coordinates(pos.latitude, pos.longitude));
  }
}
