import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:misson_tasker/model/ApiCaller.dart';
import 'package:misson_tasker/model/api_models/GetProfileDataModel.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/NavMe.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';
import 'package:misson_tasker/utils/StringsPath.dart';
import 'package:misson_tasker/utils/local_data.dart';
import 'package:misson_tasker/view/ProfileView/BusinessProfile.dart';
import 'package:misson_tasker/view/ProfileView/UserProfile.dart';
import 'package:misson_tasker/view/startup_screens/Drawer.dart';
import 'package:misson_tasker/view/startup_screens/SplashScreen.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  String username = "";
  String auth = "";
  GetProfileDataModel getProfileDataModel;
  bool isLoadingData = true;

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
        });
      });
    });
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
    return Scaffold(
      key: _drawerKey,
      drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: MyDrawer(
        username: username,
        ImageUrl: getProfileDataModel == null ||
                getProfileDataModel.data == null ||
                getProfileDataModel.data.user == null ||
                getProfileDataModel.data.user.image == null
            ? null
            : getProfileDataModel.data.user.image,
      )),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CColors.missonNormalWhiteColor,
        titleSpacing: -1.0,
        leading: InkWell(
          onTap: () {
            _drawerKey.currentState.openDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SvgPicture.asset(drawerIcon),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "current location",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: ScreenConfig.fontSizeSmall,
                  color: CColors.textColor),
            ),
            Text(
              "$_location",
              style: TextStyle(
                  fontSize: ScreenConfig.fontSizeMedium,
                  color: CColors.textColor),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: InkWell(
              onTap: () {
                NavMe().NavPushLeftToRight(BusinessProfile());
              },
              child: CircleAvatar(
                backgroundColor: CColors.missonGrey,
                // radius: ,
                child: CircleAvatar(
                  backgroundImage: getProfileDataModel == null ||
                          getProfileDataModel.data == null ||
                          getProfileDataModel.data.user == null ||
                          getProfileDataModel.data.user.image == null
                      ? AssetImage(avatar1)
                      : NetworkImage("${getProfileDataModel.data.user.image}"),
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          color: CColors.missonNormalWhiteColor,
          child: currentView(1),
        ),
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
        currentIndex: 0,
        iconSize: 25,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: CColors.missonNormalWhiteColor,
        onTap: (value) {},
      ),
    );
  }

  Widget currentView(int state) {
    switch (state) {
      case 0:
        {
          return Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Spacer(),
              SvgPicture.asset(postbox),
              SizedBox(
                height: ScreenConfig.widgetPaddingXLarge,
              ),
              Text(
                "No Mission To Do",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: ScreenConfig.fontSizeXXlarge,
                    color: CColors.missonGrey),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Ready for your mission, we will redirect\nrequest in this page.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: ScreenConfig.fontSizeMedium,
                      color: CColors.missonMediumGrey),
                ),
              ),
              SizedBox(
                height: ScreenConfig.widgetPaddingXLarge,
              )
            ]),
          );
          // statements;
        }
        break;

      case 1:
        {
          return Padding(
            padding: const EdgeInsets.only(top: 16.0, right: 16.0),
            child: Column(
              children: [
                ListTile(
                  dense: true,

                  title: Row(
                    children: [
                      Text(
                        "Mission Request",
                        style: TextStyle(fontSize: ScreenConfig.fontSizeMedium),
                      ),
                      Spacer(),
                      Text(
                        "View All",
                        style: TextStyle(fontSize: ScreenConfig.fontSizeSmall),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    "Costumer waiting for your response.",
                    style: TextStyle(fontSize: ScreenConfig.fontSizeSmall),
                  ),
                  // trailing: Padding(
                  //   padding: EdgeInsets.only(right: 8.0, top: 16.0),
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //
                  //
                  //     ],
                  //   ),
                  // ),
                ),
                Container(
                    height: 180,
                    width: ScreenConfig.screenWidth,
                    color: CColors.backgroundRed,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 10),
                          child: customTile(
                              heading: "Shop groceries for me",
                              subheading: "12:32 PM, Thursday, 23 march",
                              lines: "Mission details",
                              bottomLineColor: CColors.missonRed,
                              tileColor: CColors.missonNormalWhiteColor),
                        );
                      },
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                    )),
                ListTile(
                  dense: true,

                  title: Row(
                    children: [
                      Text(
                        "Mission Ongoing",
                        style: TextStyle(fontSize: ScreenConfig.fontSizeMedium),
                      ),
                      Spacer(),
                      Text(
                        "View All",
                        style: TextStyle(fontSize: ScreenConfig.fontSizeSmall),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    "All the best! Do it perfectly.",
                    style: TextStyle(fontSize: ScreenConfig.fontSizeSmall),
                  ),
                  // trailing: Padding(
                  //   padding: EdgeInsets.only(right: 8.0, top: 16.0),
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //
                  //
                  //     ],
                  //   ),
                  // ),
                ),
                Container(
                    height: 200,
                    width: ScreenConfig.screenWidth,
                    color: CColors.backgroundyellow,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10),
                          child: customTile2(
                              heading: "Shop groceries for me",
                              subheading: "12:32 PM, Thursday, 23 march",
                              lines: "Mission details",
                              backgroundColor: CColors.backgroundRed,
                              bottomWidget: SvgPicture.asset(yellowClockLogo),
                              bottomLineColor: CColors.missonYellow,
                              tileColor: CColors.missonNormalWhiteColor),
                        );
                      },
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                    )),
                ListTile(
                  dense: true,

                  title: Row(
                    children: [
                      Text(
                        "Mission Accomplished",
                        style: TextStyle(fontSize: ScreenConfig.fontSizeMedium),
                      ),
                      Spacer(),
                      Text(
                        "View All",
                        style: TextStyle(fontSize: ScreenConfig.fontSizeSmall),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    "See your  recent completed work",
                    style: TextStyle(fontSize: ScreenConfig.fontSizeSmall),
                  ),
                  // trailing: Padding(
                  //   padding: EdgeInsets.only(right: 8.0, top: 16.0),
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //
                  //
                  //     ],
                  //   ),
                  // ),
                ),
                Container(
                    height: 200,
                    width: ScreenConfig.screenWidth,
                    color: CColors.backgroundgreen,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10),
                          child: customTile2(
                              heading: "Shop groceries for me",
                              subheading: "12:32 PM, Thursday, 23 march",
                              lines: "Mission details",
                              bottomLineColor: CColors.missonGreen,
                              tileColor: CColors.missonNormalWhiteColor,
                              bottomWidget: SvgPicture.asset(yellowClockLogo),
                              backgroundColor: CColors.backgroundgreen),
                        );
                      },
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                    )),
              ],
            ),
          );
        }
        break;

      default:
        {
          //statements;
        }
        break;
    }
  }

  Widget customTile(
      {String heading,
      String subheading,
      String lines,
      Color bottomLineColor,
      Color tileColor}) {
    return Container(
      width: ScreenConfig.screenWidth * 0.70,
      color: tileColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: Text(
                heading,
                style: TextStyle(fontSize: ScreenConfig.fontSizeXlarge),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: Text(
                subheading,
                style: TextStyle(fontSize: ScreenConfig.fontSizeSmall),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
              child: Text(
                lines,
                style: TextStyle(fontSize: ScreenConfig.fontSizelarge),
              ),
            ),
            Spacer(),
            Container(
              color: bottomLineColor,
              height: 2.5,
            )
          ],
        ),
      ),
    );
  }

  Widget customTile2(
      {String heading,
      String subheading,
      String lines,
      Color bottomLineColor,
      Color tileColor,
      Color backgroundColor,
      Widget bottomWidget}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: ScreenConfig.screenWidth * 0.70,
          height: 140,
          color: tileColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 16.0),
                  child: Text(
                    heading,
                    style: TextStyle(fontSize: ScreenConfig.fontSizeXlarge),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 2.0),
                  child: Text(
                    subheading,
                    style: TextStyle(fontSize: ScreenConfig.fontSizeSmall),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                  child: Text(
                    lines,
                    style: TextStyle(fontSize: ScreenConfig.fontSizelarge),
                  ),
                ),
                Spacer(),
                Container(
                  color: bottomLineColor,
                  height: 2.5,
                )
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Icon(Icons.watch_later_outlined),
            bottomWidget,
            SizedBox(
              width: 5,
            ),
            // Container(
            //   width: ScreenConfig.screenWidth * 0.50,
            //   height: 5,
            //   decoration: BoxDecoration(
            //       color: CColors.missonYellow,
            //       border: Border.all(color: CColors.missonYellow),
            //       borderRadius: BorderRadius.circular(5)),
            // )
            Container(
              child: LinearProgressIndicator(
                backgroundColor: backgroundColor,
                value: 0.5,
                valueColor: AlwaysStoppedAnimation<Color>(bottomLineColor),
              ),
              width: ScreenConfig.screenWidth * 0.50,
              height: 5,
            )
          ],
        )
      ],
    );
  }
}
