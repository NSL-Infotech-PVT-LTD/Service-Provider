import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:misson_tasker/model/ApiCaller.dart';
import 'package:misson_tasker/model/api_models/GetProfileDataModel.dart';
import 'package:misson_tasker/model/api_models/ListOfServicesModel.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/CustomImageView.dart';
import 'package:misson_tasker/utils/NavMe.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';
import 'package:misson_tasker/utils/StringsPath.dart';
import 'package:misson_tasker/utils/local_data.dart';
import 'package:misson_tasker/view/ProfileView/ChildCategory.dart';
import 'package:misson_tasker/view/ProfileView/UserProfile.dart';
import 'package:misson_tasker/view/startup_screens/SplashScreen.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'editProfile.dart';

class ChooseServices extends StatefulWidget {
  @override
  _ChooseServicesState createState() => _ChooseServicesState();
}

class _ChooseServicesState extends State<ChooseServices> {
  bool isLoading = true;
  String _fullName = "Loading....";
  bool isLoadingApi = true;
  List<Asset> images = List<Asset>();
  String _error;
  bool isLoadingData = true;

  final _formKey = GlobalKey<FormState>();

  ListOfServicesModel listOfServicesModel;
String auth="";
  @override
  void initState() {
    // registerUser();


    getString(sharedPref.userToken).then((value) {
      auth = value;

      print("123 $value");
    }).whenComplete(() {
      ApiCaller()
          .getServiceList(auth:auth )
          .then((value) => listOfServicesModel = value)
          .whenComplete(() {
        setState(() {
          isLoadingApi = false;
        });
      });
    });

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
                  "Choose Services",
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
        body: Container(
            margin: EdgeInsets.only(top: 30),
            color: Colors.white,
            child: isLoadingApi ==true
                ?     Center(child: spinkit)
                : Form(
                    key: _formKey,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: 16.0, left: 10, right: 10),
                          child: ListTile(
                            title: InkWell(
                              onTap: () {
                                NavMe().NavPushLeftToRight(ChildCategory(
                                  parentName: listOfServicesModel.data.data
                                      .elementAt(index)
                                      .name,
                                  parentId: listOfServicesModel.data.data
                                      .elementAt(index)
                                      .id,
                                ));
                              },
                              child: Text(
                                "${listOfServicesModel.data.data.elementAt(index).name}",
                                style: TextStyle(
                                    fontSize: ScreenConfig.fontSizelarge,
                                    color: CColors.missonPrimaryColor,
                                    fontFamily: "Product"),
                              ),
                            ),
                            trailing: SvgPicture.asset(
                              rightArrowIcon,
                              height: 15,
                            ),
                          ),
                        );
                      },
                      itemCount: listOfServicesModel == null
                          ? 0
                          : listOfServicesModel.data.data.length,
                    ))));
  }
}
