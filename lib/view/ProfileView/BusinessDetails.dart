import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:misson_tasker/model/ApiCaller.dart';
import 'package:misson_tasker/model/api_models/GetProfileDataModel.dart';
import 'package:misson_tasker/model/api_models/UpdateProfileDataModel.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/CustomImageView.dart';
import 'package:misson_tasker/utils/NavMe.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';
import 'package:misson_tasker/utils/StringsPath.dart';
import 'package:misson_tasker/utils/local_data.dart';
import 'package:misson_tasker/view/ProfileView/ChooseServices.dart';
import 'package:misson_tasker/view/ProfileView/UserProfile.dart';
import 'package:misson_tasker/view/startup_screens/SplashScreen.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'editProfile.dart';

class BusinessDetails extends StatefulWidget {
  @override
  _BusinessDetailsState createState() => _BusinessDetailsState();
}

class _BusinessDetailsState extends State<BusinessDetails> {
  bool isLoading = true;
  String _fullName = "Loading....";
  bool isLoadingApi = false;
  List<Asset> images=[];
  List<File> files = [];
  String _error;
  bool isLoadingData = true;

  final _formKey = GlobalKey<FormState>();
  TextEditingController hour = TextEditingController();
  TextEditingController toolBox = TextEditingController();
  TextEditingController description = TextEditingController();
  UpdateProfileDataModel dataModel;
String auth="";
  Widget buildListView() {
    if (images != null)
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          Asset asset = images[index];
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomImageView(
                  asset: asset,
                  width: 300,
                  height: 300,
                ),
              ),
              Positioned(
                child: InkWell(
                    onTap: () {
                      print(index);
                      setState(() {
                        images.removeAt(index);
                      });
                    },
                    child: SvgPicture.asset(
                      cancelLogo,
                      height: 20,
                    )),
                top: 0,
                right: 0,
              )
            ],
          );
        },
        itemCount: images.length,
      );
    else
      return Container(
        color: Colors.white,
      );
  }

  Future<void> loadAssets() async {


    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 6,
        selectedAssets: images

      );
    } on Exception catch (e) {
      error = e.toString();
    }
    // files = [];
    for (Asset asset in resultList) {
      final path = await FlutterAbsolutePath.getAbsolutePath(asset.identifier);
      files.add(File(path));
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      if (error == null) _error = 'No Error Dectected';
    });
  }

  @override
  void initState() {
    getString(sharedPref.userToken).then((value) => auth=value);
    // registerUser();


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Row(
              children: [
                Text(
                  "Business Details",
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.start,
                ),
                Spacer()
              ],
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
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                  margin: EdgeInsets.only(top: 30),
                  color: Colors.white,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 16.0, left: 10, right: 10),
                          child: ListTile(
                            title: InkWell(
                              onTap: () {
                                NavMe().NavPushLeftToRight(ChooseServices());
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Choose Services",
                                    style: TextStyle(
                                        fontSize: ScreenConfig.fontSizelarge,
                                        color: CColors.missonPrimaryColor,
                                        fontFamily: "Product"),
                                  ),
                                  Text(
                                    "Choose categories and their sub-categories.",
                                    style: TextStyle(
                                        fontSize: ScreenConfig.fontSizeSmall,
                                        color: CColors.missonMediumGrey,
                                        fontFamily: "Product"),
                                  ),
                                ],
                              ),
                            ),
                            trailing: SvgPicture.asset(
                              rightArrowIcon,
                              height: 15,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 10),
                          child: ListTile(
                            title: InkWell(
                              onTap: () {},
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Add Work Images",
                                    style: TextStyle(
                                        fontSize: ScreenConfig.fontSizelarge,
                                        color: CColors.missonPrimaryColor,
                                        fontFamily: "Product"),
                                  ),
                                  Text(
                                    "Upload pictures of their previous tasks (optional for taskers)",
                                    style: TextStyle(
                                        fontSize: ScreenConfig.fontSizeSmall,
                                        color: CColors.missonMediumGrey,
                                        fontFamily: "Product"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6.0, horizontal: 10),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor:
                                        CColors.missonLightGrey),
                                    onPressed: () {},
                                    child: Text(
                                      images.isEmpty
                                          ? "0 Photos"
                                          : "${images.length} Photos",
                                      style: TextStyle(
                                          fontSize: ScreenConfig.fontSizeSmall,
                                          fontFamily: "Product",
                                          color: CColors.missonGrey),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: loadAssets,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      "Choose from gallery",
                                      style: TextStyle(
                                          fontSize: ScreenConfig.fontSizeSmall,
                                          fontFamily: "Product",
                                          color: CColors.missonSkyBlue),
                                    ),
                                  ),
                                )
                              ],
                            )),
                        images.isEmpty
                            ? Container()
                            : Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 6.0, horizontal: 16),
                          height: 100,
                          width: ScreenConfig.screenWidth,
                          child: buildListView(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 16.0, left: 10, right: 10),
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hourly rate",
                                  style: TextStyle(
                                      fontSize: ScreenConfig.fontSizelarge,
                                      color: CColors.missonPrimaryColor,
                                      fontFamily: "Product"),
                                ),
                                Text(
                                  "Mention the hourly rate here",
                                  style: TextStyle(
                                      fontSize: ScreenConfig.fontSizeSmall,
                                      color: CColors.missonMediumGrey,
                                      fontFamily: "Product"),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 16.0, left: 24, right: 24),
                          child: TextFormField(
                            controller: hour,
                            keyboardType:
                            TextInputType.numberWithOptions(signed: true),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: CColors.missonMediumGrey,
                                ),
                              ),
                              suffixIcon: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "\$/hr",
                                    style: TextStyle(
                                        fontSize: ScreenConfig.fontSizeMedium,
                                        fontFamily: "Product",
                                        color: CColors.missonMediumGrey),
                                  ),
                                ],
                              ),
                              // suffix: Text(
                              //   "\$/hr",
                              //   style: TextStyle(
                              //       fontSize: ScreenConfig.fontSizeMedium,
                              //       fontFamily: "Product",
                              //       color: CColors.missonMediumGrey),
                              // ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 16.0, left: 10, right: 10, bottom: 4.0),
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Toolbox information",
                                  style: TextStyle(
                                      fontSize: ScreenConfig.fontSizelarge,
                                      color: CColors.missonPrimaryColor),
                                ),
                                Text(
                                  "Add tool information like tool box, drills, ladder,mini Van, pickup truck, etc",
                                  style: TextStyle(
                                      fontSize: ScreenConfig.fontSizeSmall,
                                      color: CColors.missonMediumGrey),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 5.0, left: 24, right: 24),
                          child: TextFormField(
                            controller: toolBox,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: CColors.missonMediumGrey,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24),
                          child: Text(
                            "Describe about you and you services, make it more enticing.",
                            style: TextStyle(
                                fontSize: ScreenConfig.fontSizeSmall,
                                color: CColors.missonMediumGrey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 10, right: 10, bottom: 4.0),
                          child: ListTile(
                            title: Text(
                              "Description",
                              style: TextStyle(
                                  fontSize: ScreenConfig.fontSizelarge,
                                  color: CColors.missonPrimaryColor),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 10.0, left: 24, right: 24),
                          child: Container(
                            child: TextFormField(
                              controller: description,
                              keyboardType: TextInputType.multiline,
                              maxLines: 8,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: CColors.missonMediumGrey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                          child: SizedBox(
                            height: ScreenConfig.screenHeight * 0.06,
                            width: ScreenConfig.screenWidth * 0.70,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    isLoadingApi = true;




                                  });
                                  ApiCaller().updateBusinessDetailApi(auth:auth,
                                      params: {
                                        "hourly_rate": "${hour.text}",
                                        "toolbox_info": "${toolBox.text}",
                                        "description": "${description.text}",
                                      }, listFile: files).then((value) => dataModel=value).whenComplete(() {

                                    setState(() {
                                      print("sdfsdfsdf${description.text}");
                                      isLoadingApi = false;

                                    });
                                    return showCupertinoDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CupertinoAlertDialog(
                                          title: Text('Info'),
                                          content: Text('${dataModel.data.message}'),
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
                                } else {}
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
                        ),
                      ],
                    ),
                  )),
            ),
            Align(

              alignment: Alignment.bottomCenter,
            )
          ],
        ));
  }
}
