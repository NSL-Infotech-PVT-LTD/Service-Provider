import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:misson_tasker/model/ApiCaller.dart';
import 'package:misson_tasker/model/api_models/GetProfileDataModel.dart';
import 'package:misson_tasker/model/api_models/MissionRequestModel.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/NavMe.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';
import 'package:misson_tasker/utils/StringsPath.dart';
import 'package:misson_tasker/utils/local_data.dart';
import 'package:misson_tasker/view/MissonRequestScreen/MissionRequest.dart';
import 'package:misson_tasker/view/ProfileView/BusinessProfile.dart';
import 'package:misson_tasker/view/startup_screens/Drawer.dart';
import 'package:misson_tasker/view/startup_screens/SplashScreen.dart';

class HomeScreen extends StatefulWidget {
  GetProfileDataModel getProfileDataModel;
  MissionRequestModel missionRequest;

  HomeScreen(
      {@required this.getProfileDataModel, @required this.missionRequest});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  String _auth;
  bool isLoadingData = true;
  bool isRequestList = true;
  bool isConfirmedList = true;
  MissionRequestModel missionRequestModelOnGoing;
  MissionRequestModel missionRequestModelConfirmed;
  String username;

  @override
  void initState() {
    getString(sharedPref.userToken).then((value) {
      _auth = value;

      print("123 $value");
    }).whenComplete(() {
      isRequestList = false;

      ApiCaller()
          .missionRequest(
              auth: _auth,
              latitude: widget.getProfileDataModel.data.user.latitude,
              longitude: widget.getProfileDataModel.data.user.longitude,
              jobStatus: "pending")
          .then((value) {
        widget.missionRequest = value;
      }).whenComplete(() {
        setState(() {
          isRequestList = false;
        });
      });
    });

    getString(sharedPref.userToken).then((value) {
      _auth = value;

      print("123 $value");
    }).whenComplete(() {
      isLoadingData = false;

      ApiCaller()
          .missionRequest(
              auth: _auth,
              latitude: widget.getProfileDataModel.data.user.latitude,
              longitude: widget.getProfileDataModel.data.user.longitude,
              jobStatus: "processing")
          .then((value) {
        missionRequestModelOnGoing = value;
      }).whenComplete(() {
        setState(() {
          isLoadingData = false;
        });
      });
    });
    getString(sharedPref.userToken).then((value) {
      _auth = value;

      print("123 $value");
    }).whenComplete(() {
      isLoadingData = false;

      ApiCaller()
          .missionRequest(
              auth: _auth,
              latitude: widget.getProfileDataModel.data.user.latitude,
              longitude: widget.getProfileDataModel.data.user.longitude,
              jobStatus: "confirmed")
          .then((value) {
        missionRequestModelConfirmed = value;
        print("DFDSJNSDKJSDF ${missionRequestModelConfirmed.toJson()}");
      }).whenComplete(() {
        setState(() {
          isConfirmedList = false;
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

  void getSharedPref(widget) {
    getString(sharedPref.userLocation).then((value) {
      widget.getProfileDataModel.data.user.location = value;

      print("123 $value");
    });
    getString(sharedPref.userNetworkImage).then((value) {
      widget.getProfileDataModel.data.user.image = value;

      print("123 $value");
    });
    getString(sharedPref.userName).then((value) {
      widget.getProfileDataModel.data.user.name = value;

      print("123 $value");
    }).whenComplete(() {
      setState(() {});
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    print("YEH ====> ${widget.missionRequest.toJson()}");

    return widget.missionRequest == null || widget.getProfileDataModel == null
        ? Scaffold(
            body: Center(
              child: spinkit,
            ),
          )
        : Scaffold(
            key: _drawerKey,
            onDrawerChanged: (isOpened) {
              print(isOpened);
              if (isOpened == false) {
                getSharedPref(widget);
              }
            },
            drawer: Drawer(
                // Add a ListView to the drawer. This ensures the user can scroll
                // through the options in the drawer if there isn't enough vertical
                // space to fit everything.
                child: MyDrawer(
              username: widget.getProfileDataModel.data.user.name,
              ImageUrl: widget.getProfileDataModel == null ||
                      widget.getProfileDataModel.data == null ||
                      widget.getProfileDataModel.data.user == null ||
                      widget.getProfileDataModel.data.user.image == null
                  ? null
                  : widget.getProfileDataModel.data.user.image,
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
                    "${widget.getProfileDataModel.data.user.location}",
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
                      // NavMe().NavPushLeftToRight(BusinessProfile());
                      Get.to(BusinessProfile(),
                              transition: Transition.leftToRightWithFade,
                              duration: Duration(milliseconds: 400))
                          .then((value) {
                        getSharedPref(widget);
                      }).whenComplete(() {
                        setState(() {});
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: CColors.missonGrey,
                      // radius: ,
                      child: CircleAvatar(
                        backgroundImage: widget.getProfileDataModel == null ||
                                widget.getProfileDataModel.data == null ||
                                widget.getProfileDataModel.data.user == null ||
                                widget.getProfileDataModel.data.user.image ==
                                    null
                            ? AssetImage(avatar1)
                            : NetworkImage(
                                "${widget.getProfileDataModel.data.user.image}"),
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: currentView(1),
          );
  }

  Widget currentView(int state) {
    switch (state) {
      case 0:
        {
          return Center(
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
            ),
          );
          // statements;
        }
        break;

      case 1:
        {
          return SingleChildScrollView(
            child: widget.missionRequest.data.data.length == 0
                ? Center(
                    child: Container(
                      child: Text("No Data"),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                    child: Column(
                      children: [
                        ListTile(
                          dense: true,

                          title: Row(
                            children: [
                              Text(
                                "Mission Request",
                                style: TextStyle(
                                    fontSize: ScreenConfig.fontSizeMedium),
                              ),
                              Spacer(),
                              Text(
                                "View All",
                                style: TextStyle(
                                    fontSize: ScreenConfig.fontSizeSmall),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            "Customer waiting for your response.",
                            style:
                                TextStyle(fontSize: ScreenConfig.fontSizeSmall),
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
                            height: 170,
                            width: ScreenConfig.screenWidth,
                            color: CColors.backgroundRed,
                            child: widget.missionRequest.data.data.isEmpty
                                ? Center(
                                    child: Container(
                                      child:
                                          Text("No Mission Request to show "),
                                    ),
                                  )
                                : ListView.builder(
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20.0, horizontal: 10),
                                        child: InkWell(
                                          onTap: () {
                                            // NavMe().NavPushLeftToRight(MissionRequest(
                                            //   id: widget.missionRequest.data.data
                                            //       .elementAt(index)
                                            //       .id
                                            //       .toString(),
                                            // ));

                                            Get.to(
                                                    MissionRequest(
                                                      id: widget.missionRequest
                                                          .data.data
                                                          .elementAt(index)
                                                          .id
                                                          .toString(),
                                                    ),
                                                    transition: Transition
                                                        .leftToRightWithFade,
                                                    duration: Duration(
                                                        milliseconds: 400))
                                                .then((value) => initState());
                                          },
                                          child: customTile(
                                              heading:
                                                  "${widget.missionRequest.data.data.elementAt(index).title}",
                                              // heading: "sdf",
                                              subheading:
                                                  "${widget.missionRequest.data.data.elementAt(index).startTime.split(":").elementAt(0)}: ${widget.missionRequest.data.data.elementAt(index).startTime.split(":").elementAt(1)}, ${getWeekDay(widget.missionRequest.data.data.elementAt(index).startDate.weekday)}, ${widget.missionRequest.data.data.elementAt(index).startDate.day} ${getMonth(widget.missionRequest.data.data.elementAt(index).startDate.month)}",
                                              lines: "Mission details",
                                              bottomLineColor:
                                                  CColors.missonRed,
                                              tileColor: CColors
                                                  .missonNormalWhiteColor),
                                        ),
                                      );
                                    },
                                    itemCount:
                                        widget.missionRequest.data.data.length,
                                    // itemCount: 1,
                                    scrollDirection: Axis.horizontal,
                                  )),
                        ListTile(
                          dense: true,

                          title: Row(
                            children: [
                              Text(
                                "Mission Started",
                                style: TextStyle(
                                    fontSize: ScreenConfig.fontSizeMedium),
                              ),
                              Spacer(),
                              Text(
                                "View All",
                                style: TextStyle(
                                    fontSize: ScreenConfig.fontSizeSmall),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            "All the best! Do it perfectly.",
                            style:
                                TextStyle(fontSize: ScreenConfig.fontSizeSmall),
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
                            child: isLoadingData == true
                                ? Center(child: spinkit)
                                : ListView.builder(
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          // NavMe().NavPushLeftToRight(MissionRequest(
                                          //   id: missionRequestModelOnGoing.data.data
                                          //       .elementAt(index)
                                          //       .id
                                          //       .toString(),
                                          // ));

                                          Get.to(
                                                  MissionRequest(
                                                    id: missionRequestModelOnGoing
                                                        .data.data
                                                        .elementAt(index)
                                                        .id
                                                        .toString(),
                                                  ),
                                                  transition: Transition
                                                      .leftToRightWithFade,
                                                  duration: Duration(
                                                      milliseconds: 400))
                                              .then((value) => initState());
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 10),
                                          child: customTile2(
                                              heading:
                                                  "${missionRequestModelOnGoing.data.data.elementAt(index).title}",
                                              subheading:
                                                  "${missionRequestModelOnGoing.data.data.elementAt(index).startTime.split(":").elementAt(0)}: ${missionRequestModelOnGoing.data.data.elementAt(index).startTime.split(":").elementAt(1)}, ${getWeekDay(missionRequestModelOnGoing.data.data.elementAt(index).startDate.weekday)}, ${missionRequestModelOnGoing.data.data.elementAt(index).startDate.day} ${getMonth(missionRequestModelOnGoing.data.data.elementAt(index).startDate.month)}",
                                              lines: "Mission details",
                                              backgroundColor:
                                                  CColors.backgroundRed,
                                              bottomWidget: SvgPicture.asset(
                                                  yellowClockLogo),
                                              bottomLineColor:
                                                  CColors.missonYellow,
                                              tileColor: CColors
                                                  .missonNormalWhiteColor),
                                        ),
                                      );
                                    },
                                    itemCount: missionRequestModelOnGoing
                                        .data.data.length,
                                    scrollDirection: Axis.horizontal,
                                  )),
                        ListTile(
                          dense: true,

                          title: Row(
                            children: [
                              Text(
                                "Mission Confirmed",
                                style: TextStyle(
                                    fontSize: ScreenConfig.fontSizeMedium),
                              ),
                              Spacer(),
                              Text(
                                "View All",
                                style: TextStyle(
                                    fontSize: ScreenConfig.fontSizeSmall),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            "See your  recent Confirmed work",
                            style:
                                TextStyle(fontSize: ScreenConfig.fontSizeSmall),
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
                            child: isConfirmedList == true
                                ? Center(child: spinkit)
                                : missionRequestModelConfirmed.data.data.isEmpty
                                    ? Center(
                                        child: Text("There is nothing to show"))
                                    : ListView.builder(
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0, horizontal: 10),
                                            child: InkWell(
                                              onTap: () {
                                                Get.to(
                                                        MissionRequest(
                                                          id: missionRequestModelOnGoing
                                                              .data.data
                                                              .elementAt(index)
                                                              .id
                                                              .toString(),
                                                        ),
                                                        transition: Transition
                                                            .leftToRightWithFade,
                                                        duration: Duration(
                                                            milliseconds: 400))
                                                    .then(
                                                        (value) => initState());
                                              },
                                              child: Expanded(
                                                child: customTile2(
                                                    heading:
                                                        "${missionRequestModelConfirmed.data.data.elementAt(index).title}",
                                                    subheading:
                                                        "${missionRequestModelConfirmed.data.data.elementAt(index).startTime.split(":").elementAt(0)}: ${missionRequestModelOnGoing.data.data.elementAt(index).startTime.split(":").elementAt(1)}, ${getWeekDay(missionRequestModelOnGoing.data.data.elementAt(index).startDate.weekday)}, ${missionRequestModelOnGoing.data.data.elementAt(index).startDate.day} ${getMonth(missionRequestModelOnGoing.data.data.elementAt(index).startDate.month)}",
                                                    lines: "Mission details",
                                                    backgroundColor:
                                                        CColors.backgroundRed,
                                                    bottomWidget:
                                                        SvgPicture.asset(
                                                            yellowClockLogo),
                                                    bottomLineColor:
                                                        CColors.missonYellow,
                                                    tileColor: CColors
                                                        .missonNormalWhiteColor),
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount: missionRequestModelConfirmed
                                            .data.data.length,
                                        scrollDirection: Axis.horizontal,
                                      )),
                      ],
                    ),
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
            Expanded(
              flex: 4,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
                child: Text(
                  heading,
                  style: TextStyle(
                      fontSize: ScreenConfig.fontSizeXlarge,
                      color: CColors.missonGrey,
                      fontFamily: "Product",
                      fontWeight: FontWeight.w100),
                  overflow: TextOverflow.ellipsis,
                  // maxLines: 2,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  subheading,
                  style: TextStyle(
                      fontSize: ScreenConfig.fontSizeMedium,
                      color: CColors.missonMediumGrey,
                      fontFamily: "Product"),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  lines,
                  style: TextStyle(
                      fontSize: ScreenConfig.fontSizeMedium,
                      color: CColors.missonGrey,
                      fontFamily: "Product"),
                ),
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
        Expanded(
          flex: 4,
          child: Container(
            width: ScreenConfig.screenWidth * 0.70,
            height: 140,
            color: tileColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 16.0),
                      child: Text(
                        heading,
                        style: TextStyle(fontSize: ScreenConfig.fontSizeXlarge),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 2.0),
                      child: Text(
                        subheading,
                        style: TextStyle(fontSize: ScreenConfig.fontSizeSmall),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 6),
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

  String getMonth(int monthNumber) {
    switch (monthNumber) {
      case 01:
        {
          return "January"; // statements;
        }
        break;

      case 02:
        {
          return "February";
          //statements;
        }
        break;

      case 03:
        {
          return "March";
          //statements;
        }
        break;

      case 04:
        {
          return "April";
          //statements;
        }
        break;

      case 05:
        {
          return "May";
          //statements;
        }
        break;

      case 06:
        {
          return "June";
          //statements;
        }
        break;

      case 07:
        {
          return "July";
          //statements;
        }
        break;

      case 08:
        {
          return "August";
          //statements;
        }
        break;

      case 09:
        {
          return "September";
          //statements;
        }
        break;

      case 10:
        {
          return "October";
          //statements;
        }
        break;

      case 11:
        {
          return "November";
          //statements;
        }
        break;

      case 12:
        {
          return "December";
          //statements;
        }
        break;
      default:
        {
          //statements;
        }
        break;
    }
  }

  String getWeekDay(int monthNumber) {
    switch (monthNumber) {
      case 1:
        {
          return "Monday"; // statements;
        }
        break;

      case 2:
        {
          return "Tuesday";
          //statements;
        }
        break;

      case 3:
        {
          return "Wednesday";
          //statements;
        }
        break;

      case 4:
        {
          return "Thursday";
          //statements;
        }
        break;

      case 5:
        {
          return "Friday";
          //statements;
        }
        break;

      case 6:
        {
          return "Saturday";
          //statements;
        }
        break;

      case 7:
        {
          return "Sunday";
          //statements;
        }
        break;

      default:
        {
          //statements;
        }
        break;
    }
  }
}
