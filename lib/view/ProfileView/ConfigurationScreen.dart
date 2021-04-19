import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:misson_tasker/model/ApiCaller.dart';
import 'package:misson_tasker/model/api_models/ConfigurationModel.dart';
import 'package:misson_tasker/model/api_models/GetProfileDataModel.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/NavMe.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';
import 'package:misson_tasker/utils/StringsPath.dart';
import 'package:misson_tasker/utils/local_data.dart';
import 'package:misson_tasker/view/ProfileView/BusinessDetails.dart';
import 'package:misson_tasker/view/ProfileView/ChangeNotificationScreen.dart';
import 'package:misson_tasker/view/ProfileView/ChangePassword.dart';
import 'package:misson_tasker/view/ProfileView/UserProfile.dart';
import 'package:misson_tasker/view/startup_screens/SplashScreen.dart';

class ConfigurationScreen extends StatefulWidget {
  final String apiName;


  const ConfigurationScreen({Key key, this.apiName}) : super(key: key);
  @override
  _ConfigurationScreenState createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  bool isLoading = true;

  String auth = "";
  GetProfileDataModel getProfileDataModel;
  bool isLoadingData = true;
  ConfigurationModel configurationModel;
  var spinkit;

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
    getString(sharedPref.userToken).then((value) {
      auth = value;

      print("123 $value");
    });
    ApiCall(widget.apiName);

    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
void ApiCall(String apiType)
{
  switch(apiType) {
    case "Terms & Conditions": {
      ApiCaller()
          .termsAndConditionsApi()
          .then((value) => configurationModel = value)
          .whenComplete(() {
        setState(() {
          isLoadingData = false;
        });
      });
    }
    break;

    case "Privacy Policy": {
      ApiCaller()
          .privacyPolicyApi()
          .then((value) => configurationModel = value)
          .whenComplete(() {
        setState(() {
          isLoadingData = false;
        });
      });
    }
    break;
    case "AboutUs": {
      ApiCaller()
          .aboutUsApi()
          .then((value) => configurationModel = value)
          .whenComplete(() {
        setState(() {
          isLoadingData = false;
        });
      });
    }
    break;

    default: {
      //statements;
    }
    break;
  }
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
            "${widget.apiName}",
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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: ScreenConfig.screenHeight * 0.05, horizontal: 30),
          color: Colors.white,
          child: configurationModel == null
              ? spinkit
              : Text(
                  "${configurationModel.data.config}",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenConfig.fontSizelarge,
                      fontFamily: "Product"),
                ),
        ),
      ),
    );
  }
}
