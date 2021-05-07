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
  final GetProfileDataModel getProfileDataModel;
  final MissionRequestModel missionRequest;

  const HomeScreen(
      {@required this.getProfileDataModel, @required this.missionRequest});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
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

      setState(() {

      });

    });
  }


  @override
  @override
  Widget build(BuildContext context) {
    print("YEH ====> ${widget.missionRequest.toJson()}");

    return Scaffold(
      key: _drawerKey,
      onDrawerChanged: (isOpened) {
        print(isOpened);
        if(isOpened==false)
          {
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
                          widget.getProfileDataModel.data.user.image == null
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
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, right: 16.0),
              child: Column(
                children: [
                  ListTile(
                    dense: true,

                    title: Row(
                      children: [
                        Text(
                          "Mission Request",
                          style:
                              TextStyle(fontSize: ScreenConfig.fontSizeMedium),
                        ),
                        Spacer(),
                        Text(
                          "View All",
                          style:
                              TextStyle(fontSize: ScreenConfig.fontSizeSmall),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      "Customer waiting for your response.",
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
                      height: 170,
                      width: ScreenConfig.screenWidth,
                      color: CColors.backgroundRed,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 10),
                            child: InkWell(
                              onTap: () {


                                NavMe().NavPushLeftToRight(MissionRequest(
                                  id: widget.missionRequest.data.data
                                      .elementAt(index)
                                      .id
                                      .toString(),
                                ));
                              },
                              child: customTile(
                                  heading:
                                      "${widget.missionRequest.data.data.elementAt(index).title}",
                                  // heading: "sdf",
                                  subheading:
                                      "${widget.missionRequest.data.data.elementAt(index).startTime.split(":").elementAt(0)}: ${widget.missionRequest.data.data.elementAt(index).startTime.split(":").elementAt(1)}, ${getWeekDay(widget.missionRequest.data.data.elementAt(index).startDate.weekday)}, ${widget.missionRequest.data.data.elementAt(index).startDate.day} ${getMonth(widget.missionRequest.data.data.elementAt(index).startDate.month)}",
                                  lines: "Mission details",
                                  bottomLineColor: CColors.missonRed,
                                  tileColor: CColors.missonNormalWhiteColor),
                            ),
                          );
                        },
                        itemCount: widget.missionRequest.data.data.length,
                        // itemCount: 1,
                        scrollDirection: Axis.horizontal,
                      )),
                  ListTile(
                    dense: true,

                    title: Row(
                      children: [
                        Text(
                          "Mission Ongoing",
                          style:
                              TextStyle(fontSize: ScreenConfig.fontSizeMedium),
                        ),
                        Spacer(),
                        Text(
                          "View All",
                          style:
                              TextStyle(fontSize: ScreenConfig.fontSizeSmall),
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
                          style:
                              TextStyle(fontSize: ScreenConfig.fontSizeMedium),
                        ),
                        Spacer(),
                        Text(
                          "View All",
                          style:
                              TextStyle(fontSize: ScreenConfig.fontSizeSmall),
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
