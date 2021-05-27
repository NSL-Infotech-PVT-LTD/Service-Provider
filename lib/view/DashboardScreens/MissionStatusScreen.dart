import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:misson_tasker/model/ApiCaller.dart';
import 'package:misson_tasker/model/api_models/GetProfileDataModel.dart';
import 'package:misson_tasker/model/api_models/MissionRequestModel.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/CustomAppBar.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';
import 'package:misson_tasker/utils/StringsPath.dart';
import 'package:misson_tasker/utils/local_data.dart';
import 'package:misson_tasker/view/MissonRequestScreen/MissionRequest.dart';
import 'package:misson_tasker/view/startup_screens/Drawer.dart';
import 'package:misson_tasker/view/startup_screens/SplashScreen.dart';

class MissionStatusScreen extends StatefulWidget {
  // final MissionRequestModel missionRequest;
  final GetProfileDataModel getProfileDataModel;

  const MissionStatusScreen({Key key, this.getProfileDataModel})
      : super(key: key);

  @override
  _MissionStatusScreenState createState() => _MissionStatusScreenState();
}

class _MissionStatusScreenState extends State<MissionStatusScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  String _auth = "";
  String authId;
  bool isUpcommingLoading = true;
  bool isInProgressLoading = true;
  bool isCompleteLoading = true;
  bool isCancelledLoading = true;
  MissionRequestModel missionUpcoming;
  MissionRequestModel missionInProgress;
  MissionRequestModel missionCompleted;
  MissionRequestModel missionCancelled;
  String auth;

  void initState() {
    getString(sharedPref.userToken).then((value) {
      _auth = value;

      print("123 $value");
    }).whenComplete(() {
      // isUpcommingLoading = false;

      ApiCaller()
          .missionRequest(
              auth: _auth,
              jobType: "all",
              latitude: widget.getProfileDataModel.data.user.latitude,
              longitude: widget.getProfileDataModel.data.user.longitude,
              jobStatus: "upcoming")
          .then((value) {
        missionUpcoming = value;
      }).whenComplete(() {
        setState(() {
          isUpcommingLoading = false;
        });
      });
      ApiCaller()
          .missionRequest(
              auth: _auth,
              jobType: "all",
              latitude: widget.getProfileDataModel.data.user.latitude,
              longitude: widget.getProfileDataModel.data.user.longitude,
              jobStatus: "in-progress")
          .then((value) {
        missionInProgress = value;
      }).whenComplete(() {
        setState(() {
          isInProgressLoading = false;
        });
      });
      ApiCaller()
          .missionRequest(
              auth: _auth,
              jobType: "all",
              latitude: widget.getProfileDataModel.data.user.latitude,
              longitude: widget.getProfileDataModel.data.user.longitude,
              jobStatus: "completed")
          .then((value) {
        missionCompleted = value;
      }).whenComplete(() {
        setState(() {
          isCompleteLoading = false;
        });
      });
      ApiCaller()
          .missionRequest(
              auth: _auth,
              jobType: "all",
              latitude: widget.getProfileDataModel.data.user.latitude,
              longitude: widget.getProfileDataModel.data.user.longitude,
              jobStatus: "cancelled")
          .then((value) {
        missionCancelled = value;
      }).whenComplete(() {
        setState(() {
          isCancelledLoading = false;
        });
      });
    });
    //
    // getString(sharedPref.userToken).then((value) {
    //   _auth = value;
    //
    //   print("123 $value");
    // }).whenComplete(() {
    //   isLoadingData = false;
    //
    //   ApiCaller()
    //       .missionRequest(
    //       auth: _auth,
    //       jobType: "direct",
    //       latitude: widget.getProfileDataModel.data.user.latitude,
    //       longitude: widget.getProfileDataModel.data.user.longitude,
    //       jobStatus: "processing")
    //       .then((value) {
    //     missionRequestModelOnGoing = value;
    //   }).whenComplete(() {
    //     setState(() {
    //       isLoadingData = false;
    //     });
    //   });
    // });
    // getString(sharedPref.userToken).then((value) {
    //   _auth = value;
    //
    //   print("123 $value");
    // }).whenComplete(() {
    //   isLoadingData = false;
    //
    //   ApiCaller()
    //       .missionRequest(
    //       auth: _auth,
    //       jobType: "direct",
    //       latitude: widget.getProfileDataModel.data.user.latitude,
    //       longitude: widget.getProfileDataModel.data.user.longitude,
    //       jobStatus: "confirmed")
    //       .then((value) {
    //     missionRequestModelConfirmed = value;
    //     print("DFDSJNSDKJSDF ${missionRequestModelConfirmed.toJson()}");
    //   }).whenComplete(() {
    //     setState(() {
    //       isConfirmedList = false;
    //     });
    //   });
    // });

    // TODO: implement initState
    super.initState();
    // getString(sharedPref.userName).then((value) {
    //   // username = value;
    //   print("!@# $value");
    // }).whenComplete(() {
    //   setState(() {});
    // });
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getString(sharedPref.userToken).then((value) {
  //     auth = value;
  //
  //     print("123 $value");
  //   }).whenComplete(() {
  //     ApiCaller()
  //         .missionRequest(
  //             jobType: "direct",
  //             auth: auth,
  //             jobStatus: "Confirmed",
  //             latitude: widget.getProfileDataModel.data.user.latitude,
  //             longitude: widget.getProfileDataModel.data.user.longitude)
  //         .then((value) {
  //       missionUpcoming = value;
  //     }).whenComplete(() {
  //       setState(() {
  //         isUpcommingLoading = false;
  //       });
  //     });
  //     ApiCaller()
  //         .missionRequest(
  //             auth: _auth,
  //             jobType: "all",
  //             latitude: widget.getProfileDataModel.data.user.latitude,
  //             longitude: widget.getProfileDataModel.data.user.longitude,
  //             jobStatus: "processing")
  //         .then((value) {
  //       missionInProgress = value;
  //       print("DFDSJNSDKJSDF ${missionInProgress.toJson()}");
  //     }).whenComplete(() {
  //       setState(() {
  //         isInProgressLoading = false;
  //       });
  //     });
  //     ApiCaller()
  //         .missionRequest(
  //             auth: _auth,
  //             jobType: "all",
  //             latitude: widget.getProfileDataModel.data.user.latitude,
  //             longitude: widget.getProfileDataModel.data.user.longitude,
  //             jobStatus: "completed")
  //         .then((value) {
  //       missionCompleted = value;
  //       print("DFDSJNSDKJSDF ${missionInProgress.toJson()}");
  //     }).whenComplete(() {
  //       setState(() {
  //         isCompleteLoading = false;
  //       });
  //     });
  //     ApiCaller()
  //         .missionRequest(
  //             auth: _auth,
  //             jobType: "all",
  //             latitude: widget.getProfileDataModel.data.user.latitude,
  //             longitude: widget.getProfileDataModel.data.user.longitude,
  //             jobStatus: "Cancelled")
  //         .then((value) {
  //       missionCancelled = value;
  //       print("DFDSJNSDKJSDF ${missionInProgress.toJson()}");
  //     }).whenComplete(() {
  //       setState(() {
  //         isCancelledLoading = false;
  //       });
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          key: _drawerKey,
          drawer: Drawer(
            child: MyDrawer(
              auth: _auth,
              username: widget.getProfileDataModel.data.user.name,
              ImageUrl: widget.getProfileDataModel == null ||
                      widget.getProfileDataModel.data == null ||
                      widget.getProfileDataModel.data.user == null ||
                      widget.getProfileDataModel.data.user.image == null
                  ? null
                  : widget.getProfileDataModel.data.user.image,
            ),
          ),
          appBar: myCustomAppBar(
            titleHeading: "Mission Status",
            titleSubHeading:
                "You can check status of your Mission\nposted by customer",
            tabBarList: [
              Text("Upcoming"),
              Text("In-progress"),
              Text("Completed"),
              Text("Cancelled")
            ],
            drawerKey: _drawerKey,
            leftSideIconSvg: SvgPicture.asset(drawerIcon),
            rightHandSideOnTap: () {},
            rightSideIconSvg: SvgPicture.asset(searchIcon),
          ),
          body: Container(
            color: CColors.missonNormalWhiteColor,
            child: TabBarView(
              children: [
                // Icon(Icons.directions_car),
                isUpcommingLoading == true
                    ? Center(
                        child: spinkit,
                      )
                    : showList(
                        obj: missionUpcoming,
                        exploreType: "upcoming",
                        context: context,
                        title: "sdvlsdknmsdfsd",
                        visibleStatus: true,
                        miles: 6.5,
                        customWidget: Badge(
                            badgeContent: Text(
                              '6',
                              style: TextStyle(
                                  fontSize: ScreenConfig.fontSizeXlarge,
                                  color: CColors.missonNormalWhiteColor,
                                  fontWeight: FontWeight.w100,
                                  fontFamily: "Product"),
                            ),
                            badgeColor: Colors.blue.shade400

                            // child: Icon(Icons.settings),
                            ),
                        description: "sdfdf",
                        ref: 1234,
                        type: "1 day ago",
                      ),
                isInProgressLoading == true
                    ? Center(
                        child: spinkit,
                      )
                    : showList(
                        obj: missionInProgress,
                        exploreType: "inProgress",
                        context: context,
                        title: "fsdfrs",
                        visibleStatus: true,
                        miles: 6.5,
                        customWidget: Row(
                          children: [
                            Container(
                              height: 10,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Colors.yellow.shade300,
                                  // border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              height: 10,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Colors.yellow.shade300,
                                  // border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ],
                        ),
                        description: "sdfdf",
                        ref: 1234,
                        type: "1 day ago",
                      ),
                isCompleteLoading == true
                    ? Center(
                        child: spinkit,
                      )
                    : showList(
                        obj: missionCompleted,
                        exploreType: "completed",
                        context: context,
                        title: "fsdfrs",
                        visibleStatus: true,
                        miles: 6.5,
                        customWidget: Badge(
                            badgeContent: Icon(
                              Icons.check,
                              size: 15,
                              color: CColors.missonNormalWhiteColor,
                            ),
                            badgeColor: Colors.green.shade200

                            // child: Icon(Icons.settings),
                            ),
                        description: "sdfdf",
                        ref: 1234,
                        type: "1 day ago",
                      ),
                isCancelledLoading == true
                    ? Center(
                        child: spinkit,
                      )
                    : showList(
                        obj: missionCancelled,
                        exploreType: "cancelled",
                        context: context,
                        title: "fsdfrs",
                        visibleStatus: false,
                        miles: 6.5,
                        customWidget: Badge(
                            badgeContent: Text(
                              '5',
                              style: TextStyle(
                                  fontSize: ScreenConfig.fontSizeXlarge,
                                  color: CColors.missonNormalWhiteColor,
                                  fontWeight: FontWeight.w100,
                                  fontFamily: "Product"),
                            ),
                            badgeColor: Colors.blue.shade400

                            // child: Icon(Icons.settings),
                            ),
                        description: "sdfdf",
                        ref: 1234,
                        type: "1 day ago",
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showList(
      {MissionRequestModel obj,
      context,
      ref,
      description,
      title,
      String exploreType,
      visibleStatus,
      Widget customWidget,
      miles,
      type}) {
    return Column(
      children: [
        // Container(
        //   color: CColors.missonNormalWhiteColor,
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
        //     child: Row(
        //       children: [
        //         Text("Posted By Task Seekers",
        //             style: TextStyle(
        //                 fontWeight: FontWeight.w500,
        //                 color: CColors.missonMediumGrey,
        //                 fontSize: ScreenConfig.fontSizeMedium))
        //       ],
        //     ),
        //   ),
        // ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return obj.data.data.isEmpty
                  ? Center(
                      child: Text("There is no data to show"),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 8.0),
                      child: containerBox(
                          context,
                          "${obj.data.data.elementAt(index).id}",
                          "${obj.data.data.elementAt(index).title}",
                          "${obj.data.data.elementAt(index).description}", () {
                        switch (exploreType) {
                          case "upcoming":
                            {
                              print("Hello Upcoming");
                              print("sdfsddsfd $exploreType");
                            }
                            Get.to(
                                    MissionRequest(
                                      id: obj.data.data
                                          .elementAt(index)
                                          .id
                                          .toString(),
                                    ),
                                    transition: Transition.leftToRightWithFade,
                                    duration: Duration(milliseconds: 400))
                                .then((value) => initState());
                            break;

                          case "inProgress":
                            {
                              print("Hello inProgress");
                              Get.to(
                                      MissionRequest(
                                        id: obj.data.data
                                            .elementAt(index)
                                            .id
                                            .toString(),
                                      ),
                                      transition:
                                          Transition.leftToRightWithFade,
                                      duration: Duration(milliseconds: 400))
                                  .then((value) => initState());
                            }
                            break;
                          case "completed":
                            {
                              print("Hello Completed");
                              Get.to(
                                      MissionRequest(
                                        id: obj.data.data
                                            .elementAt(index)
                                            .id
                                            .toString(),
                                      ),
                                      transition:
                                          Transition.leftToRightWithFade,
                                      duration: Duration(milliseconds: 400))
                                  .then((value) => initState());
                            }
                            break;
                          case "cancelled":
                            {
                              print("Hello Cancelled");
                            }
                            break;

                          default:
                            {
                              //statements;
                            }
                            break;
                        }
                        print("Hello $index");
                      },
                          miles: obj.data.data.elementAt(index).distanceMiles,
                          // type: obj.data.data
                          //     .elementAt(index)
                          //     .startDate
                          //     .toString()
                          //     .split(":")
                          //     .elementAt(0)
                          //     .split(" ")
                          //     .elementAt(0),
                          // type: "${DateFormat.jm().format(DateTime.parse(obj.data.data.elementAt(index).createdAt).toLocal())} ",
                          type: "${DateFormat.MMMMd().add_jm().format(DateTime.parse(obj.data.data.elementAt(index).createdAt).toLocal())} ",
                          customWidget: customWidget,
                          visibleStatus: visibleStatus,
                          status: obj.data.data.elementAt(index).jobStatus,
                          jobType: obj.data.data.elementAt(index).jobType),
                    );
            },
            itemCount: obj.data.data.isEmpty ? 1 : obj.data.data.length,
          ),
        ),
      ],
    );
  }

  Widget containerBox(context, ref, description, title, function,
      {visibleStatus,
      Widget customWidget,
      miles,
      type,
      String exploreType,
      String status,
      String jobType}) {
    return Container(
      height: ScreenConfig.screenHeight * 0.28,
      width: ScreenConfig.screenWidth * 0.90,
      decoration: BoxDecoration(
        color: CColors.missonNormalWhiteColor,
        border: Border.all(color: CColors.missonPrimaryColor, width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
                ScreenConfig.screenWidth * 0.05,
                ScreenConfig.screenHeight * 0.02,
                ScreenConfig.screenWidth * 0.04,
                0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "#$ref",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Product",
                              color: CColors.missonPrimaryColor,
                            )),
                        TextSpan(
                            text: " Job Reference No,",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Product",
                              color: CColors.missonMediumGrey,
                            )),
                      ]),
                    ),
                    Spacer(),
                    Text(
                      "Created at $type",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenConfig.fontSizeSmall,
                          color: CColors.missonMediumGrey),
                    ),
                  ],
                ),
                SizedBox(height: ScreenConfig.screenHeight * 0.01),
                Row(
                  children: [
                    Expanded(
                        flex: 4,
                        child: Text(
                          "$description",
                          softWrap: true,
                          maxLines: 2,
                          style: TextStyle(
                            color: CColors.missonPrimaryColor,
                            fontFamily: "Product",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        )),
                    Spacer(),
                    // Visibility(
                    //   visible: visibleStatus,
                    //   child: Expanded(
                    //     flex: 1,
                    //     child: roundTextBox("$statusData",CColors.blueText),
                    //   ),
                    // ),
                    //

                    // Visibility(visible: visibleStatus, child: customWidget),
                  ],
                ),
                SizedBox(height: ScreenConfig.screenHeight * 0.01),
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.circular(30.0),
                        //shape: BoxShape.circle,
                        color: CColors.missonMediumGrey,
                      ),
                      child: Center(
                          child: SvgPicture.asset(
                        "",
                        height: ScreenConfig.screenHeight * 0.02,
                      )), //assets/images/jobIcon.svg
                    ),
                    SizedBox(width: ScreenConfig.screenWidth * 0.02),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                              child: Text(
                            "$title  ",
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: ScreenConfig.fontSizelarge,
                                fontFamily: "Product",
                                color: CColors.missonPrimaryColor),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          )),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "$status",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: "Product",
                                  color: status == "pending"
                                      ? Colors.blueGrey
                                      : status == "accepted"
                                          ? CColors.missonSkyBlue
                                          : status == "processing"
                                              ? CColors.missonYellow
                                              : status == "cancelled"
                                                  ? CColors.missonRed
                                                  : status == "confirmed"
                                                      ? Colors.lightGreen
                                                      : CColors.missonGreen),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: ScreenConfig.screenHeight * 0.01),
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.circular(30.0),
                        //shape: BoxShape.circle,
                        color: CColors.missonMediumGrey,
                      ),
                      child: Center(
                          child: SvgPicture.asset(
                        "",
                        height: ScreenConfig.screenHeight * 0.02,
                      )),
                    ),
                    SizedBox(width: ScreenConfig.screenWidth * 0.02),
                    RichText(
                      text: TextSpan(
                        text: "",
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                              text: '$miles ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: CColors.missonPrimaryColor,
                                  fontSize: ScreenConfig.fontSizeXlarge)),
                          TextSpan(
                              text: 'miles away',
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: CColors.missonPrimaryColor,
                                  fontSize: ScreenConfig.fontSizeXlarge)),
                        ],
                      ),
                    )
                    // Text(
                    //   "$miles",
                    //   style: TextStyle(fontFamily: "Product"),
                    // ),
                  ],
                ),
                SizedBox(height: ScreenConfig.screenHeight * 0.01),
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.circular(30.0),
                        //shape: BoxShape.circle,
                        color: CColors.missonMediumGrey,
                      ),
                      child: Center(
                          child: SvgPicture.asset(
                        "",
                        height: ScreenConfig.screenHeight * 0.02,
                      )),
                    ),
                    SizedBox(width: ScreenConfig.screenWidth * 0.02),
                    RichText(
                      text: TextSpan(
                        text: "",
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                              text: '$jobType ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: CColors.missonPrimaryColor,
                                  fontSize: ScreenConfig.fontSizeXlarge)),
                          TextSpan(
                              text: 'job type',
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: CColors.missonPrimaryColor,
                                  fontSize: ScreenConfig.fontSizeXlarge)),
                        ],
                      ),
                    )
                    // Text(
                    //   "$miles",
                    //   style: TextStyle(fontFamily: "Product"),
                    // ),
                  ],
                ),
                //  SizedBox(height:4),
              ],
            ),
          ),
          Spacer(),
          Align(
              alignment: Alignment.bottomRight,
              child: FlatButton(
                onPressed: function,
                child: Text(
                  "View More +",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                color: CColors.missonPrimaryColor,
              ))
        ],
      ),
    );
  }
}
