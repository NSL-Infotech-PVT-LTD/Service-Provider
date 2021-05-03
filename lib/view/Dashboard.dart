import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:misson_tasker/model/ApiCaller.dart';
import 'package:misson_tasker/model/api_models/GetProfileDataModel.dart';
import 'package:misson_tasker/model/api_models/MissionRequestModel.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/NavMe.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';
import 'package:misson_tasker/utils/StringsPath.dart';
import 'package:misson_tasker/utils/local_data.dart';
import 'package:misson_tasker/view/DashboardScreens/ChatListScreen.dart';
import 'package:misson_tasker/view/DashboardScreens/MissionExploreScreen.dart';
import 'package:misson_tasker/view/DashboardScreens/MissionStatusScreen.dart';
import 'package:misson_tasker/view/MissonRequestScreen/MissionRequest.dart';
import 'package:misson_tasker/view/ProfileView/BusinessProfile.dart';
import 'package:misson_tasker/view/ProfileView/UserProfile.dart';
import 'package:misson_tasker/view/startup_screens/Drawer.dart';
import 'package:misson_tasker/view/DashboardScreens/HomeScreen.dart';
import 'package:misson_tasker/view/startup_screens/SplashScreen.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String username = "";
  String auth = "";
  GetProfileDataModel getProfileDataModel;
  MissionRequestModel missionRequest;
  bool isLoadingData = true;
  bool isLoadingRequest = true;
  int _selectedIndex = 0;

  String _location = "Loading....";

  @override
  void initState() {

    getString(sharedPref.userToken).then((value) {
      auth = value;

      print("123 $value");
    }).whenComplete(() {
      ApiCaller().getProfileData(auth: auth).then((value) {
        getProfileDataModel = value;
      }).whenComplete(() {
        setState(() {
          isLoadingData = false;

          _location = getProfileDataModel.data.user.location;
          ApiCaller()
              .missionRequest(
                  auth: auth,
                  latitude: getProfileDataModel.data.user.latitude,
                  longitude: getProfileDataModel.data.user.longitude,
                  jobStatus: "pending")
              .then((value) {
            missionRequest = value;
          }).whenComplete(() {
            setState(() {
              isLoadingRequest = false;
            });
          });
        });
      });
    });
    // getString(sharedPref.userToken).then((value) {
    //   auth = value;
    //
    //   print("123 $value");
    // }).whenComplete(() {
    //
    // });
    // TODO: implement initState
    super.initState();
    getString(sharedPref.userName).then((value) {
      username = value;
      print("!@# $value");
    }).whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    _listOfScreens = <Widget>[
      HomeScreen(
        getProfileDataModel: getProfileDataModel,
        missionRequest: missionRequest,
      ),
      MissionExploreScreen(),
      ChatListScreen(getProfileDataModel: getProfileDataModel,),
      MissionStatusScreen()
    ];

    return Scaffold(
      body: (getProfileDataModel == null || missionRequest == null)
          ? Center(child: spinkit)
          : SafeArea(
              child: Container(
              color: CColors.missonNormalWhiteColor,
              child: _listOfScreens.elementAt(_selectedIndex),
            )),
      bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          backgroundColor: CColors.missonNormalWhiteColor,
          //CColors.missonNormalWhiteColor,

          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                // backgroundColor: CColors.missonNormalWhiteColor,
                icon: SvgPicture.asset(
                  navbarHomeDeactive,
                  height: 20,
                ),
                activeIcon: SvgPicture.asset(
                  navbarHomeActive,
                  height: 20,
                ),
                label: " "),
            BottomNavigationBarItem(
              // backgroundColor: CColors.missonNormalWhiteColor,
              icon: SvgPicture.asset(navbarExploerDeactive),
              activeIcon: SvgPicture.asset(navbarExplorerActive),
              label: ' ',
            ),
            BottomNavigationBarItem(
              // backgroundColor: CColors.missonNormalWhiteColor,
              icon: SvgPicture.asset(navbarChatDeactive),
              activeIcon: SvgPicture.asset(navbarChatActive),
              label: ' ',
            ),
            BottomNavigationBarItem(
              // backgroundColor: CColors.missonNormalWhiteColor,
              icon: SvgPicture.asset(navbarClockDeactive),
              activeIcon: SvgPicture.asset(navbarClockActive),
              label: ' ',
            ),
          ],
          currentIndex: _selectedIndex,
          iconSize: 25,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: CColors.missonNormalWhiteColor,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
    );
  }

  List<Widget> _listOfScreens = [];
}
