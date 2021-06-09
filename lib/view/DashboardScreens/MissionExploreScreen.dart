import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:misson_tasker/model/ApiCaller.dart';
import 'package:misson_tasker/model/api_models/GetProfileDataModel.dart';
import 'package:misson_tasker/model/api_models/MissionRequestModel.dart';
import 'package:misson_tasker/utils/AnimatorUtil.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/CustomAppBar.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';
import 'package:misson_tasker/utils/StringsPath.dart';
import 'package:misson_tasker/utils/local_data.dart';
import 'package:misson_tasker/view/MissonRequestScreen/MissionRequest.dart';
import 'package:misson_tasker/view/startup_screens/Drawer.dart';
import 'package:misson_tasker/view/startup_screens/SplashScreen.dart';

class MissionExploreScreen extends StatefulWidget {
  // final MissionRequestModel missionRequest;
  final GetProfileDataModel getProfileDataModel;

  const MissionExploreScreen({Key key, this.getProfileDataModel})
      : super(key: key);

  @override
  _MissionExploreScreenState createState() => _MissionExploreScreenState();
}

class _MissionExploreScreenState extends State<MissionExploreScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  String _auth = "";

  bool isPosted = true;
  bool isRequested = true;
  bool isProfileData = true;

  MissionRequestModel posted;
  MissionRequestModel requested;

  String auth;

  @override
  void initState() {
    getString(sharedPref.userToken).then((value) {
      _auth = value;

      print("123 $value");
    }).whenComplete(() {
      // isUpcommingLoading = false;

      ApiCaller()
          .missionRequest(
              auth: _auth,
              jobType: "direct",
              latitude: widget.getProfileDataModel.data.user.latitude,
              longitude: widget.getProfileDataModel.data.user.longitude,
              jobStatus: "upcoming")
          .then((value) {
        posted = value;
      }).whenComplete(() {
        setState(() {
          isPosted = false;
        });
      });
      ApiCaller()
          .missionRequest(
              auth: _auth,
              jobType: "post",
              latitude: widget.getProfileDataModel.data.user.latitude,
              longitude: widget.getProfileDataModel.data.user.longitude,
              jobStatus: "upcoming")
          .then((value) {
        requested = value;
      }).whenComplete(() {
        setState(() {
          isRequested = false;
        });
      });
      // TODO: implement initState
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 2,
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
            titleHeading: "Mission Explore",
            titleSubHeading: "You can search for the mission you\nwant to do",
            tabBarList: [Text("Posted"), Text("Requested")],
            drawerKey: _drawerKey,
            leftSideIconSvg: SvgPicture.asset(drawerIcon),
            rightHandSideOnTap: () {},
            rightSideIconSvg: SvgPicture.asset(searchIcon),
          ),
          // AppBar(
          //   bottom: TabBar(
          //     labelColor: CColors.textColor,
          //     indicatorColor: CColors.missonPrimaryColor,
          //     unselectedLabelColor: CColors.missonMediumGrey,
          //     unselectedLabelStyle: TextStyle(
          //         fontSize: ScreenConfig.fontSizeXlarge,
          //         color: CColors.backgroundRed,
          //         fontWeight: FontWeight.w100,
          //         fontFamily: "Product"),
          //     labelStyle: TextStyle(
          //         fontSize: ScreenConfig.fontSizeXlarge,
          //         color: CColors.textColor,
          //         fontWeight: FontWeight.w100,
          //         fontFamily: "Product"),
          //     tabs: [
          //       Text(
          //         "Posted",
          //       ),
          //       Text(
          //         "Requested",
          //       ),
          //     ],
          //   ),
          //   elevation: 0,
          //   toolbarHeight: 140,
          //   backgroundColor: CColors.missonNormalWhiteColor,
          //   leadingWidth: 0,
          //   centerTitle: true,
          //   title: Column(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           InkWell(
          //             onTap: () {
          //               _drawerKey.currentState.openDrawer();
          //             },
          //             child: SvgPicture.asset(drawerIcon),
          //           ),
          //           Text(
          //             "Mission Explore",
          //             textAlign: TextAlign.left,
          //             style: TextStyle(
          //                 fontSize: ScreenConfig.fontSizeXhlarge,
          //                 color: CColors.textColor,
          //                 fontWeight: FontWeight.w100,
          //                 fontFamily: "Product"),
          //           ),
          //           InkWell(
          //             onTap: () {},
          //             child: SvgPicture.asset(searchIcon),
          //           )
          //         ],
          //       ),
          //       SizedBox(
          //         height: 10,
          //       ),
          //       Text(
          //         "You can send message or chat with your \n mission speakers",
          //         textAlign: TextAlign.center,
          //         style: TextStyle(
          //             fontSize: ScreenConfig.fontSizeMedium,
          //             color: CColors.textColor,
          //             fontWeight: FontWeight.w100,
          //             fontFamily: "Product"),
          //       ),
          //     ],
          //   ),
          // ),
          body: Container(
            color: CColors.missonNormalWhiteColor,
            child: TabBarView(
              children: [
                // Icon(Icons.directions_car),
                isRequested == true
                    ? Center(child: spinkit)
                    : TweenAnimationBuilder(
                  builder: (BuildContext context, double val, Widget child) {
                    return
                      Opacity(
                        opacity: val,
                        child: Padding(
                          padding: EdgeInsets.only(top: val*30),
                          child: child,
                        ),
                      );
                  },
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: AnimatorUtil.animationSpeedTimeFast,
                      child: showList(
                          obj: requested, heading: "Posted By Task Seekers"),
                    ),
                isPosted == true
                    ? Center(
                        child: spinkit,
                      )
                    : TweenAnimationBuilder(builder: (BuildContext context, double val, Widget child) {
                  return
                    Opacity(
                      opacity: val,
                      child: Padding(
                        padding: EdgeInsets.only(top: val*30),
                        child: child,
                      ),
                    );
                }, tween: Tween<double>(begin: 0, end: 1),
                    duration: AnimatorUtil.animationSpeedTimeFast, child: showList(obj: posted, heading: "Assigned By Task Seekers"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showList({MissionRequestModel obj, String heading}) {
    return Column(
      children: [
        Container(
          color: CColors.missonNormalWhiteColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, ),
            child: Row(
              children: [
                Text("$heading",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: CColors.missonMediumGrey,
                        fontSize: ScreenConfig.fontSizeMedium))
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                child: obj.data.data.isEmpty
                    ? Center(child: Text("There is no data to show"))
                    : containerBox(
                        context,
                        "${obj.data.data.elementAt(index).id}",
                        "${obj.data.data.elementAt(index).title}",
                        "${obj.data.data.elementAt(index).description}", () {
                        obj.data.data.elementAt(index).jobType == "direct"
                            ? Get.to(
                                    MissionRequest(
                                      id: obj.data.data
                                          .elementAt(index)
                                          .id
                                          .toString(),
                                    ),
                                    transition: Transition.leftToRightWithFade,
                                    duration: Duration(milliseconds: 400))
                                .then((value) => initState())
                            : Get.to(
                            MissionRequest(
                              id: obj.data.data
                                  .elementAt(index)
                                  .id
                                  .toString(),
                            ),
                            transition: Transition.leftToRightWithFade,
                            duration: Duration(milliseconds: 400))
                            .then((value) => initState());
                      },
                        obj: obj,
                        miles: obj.data.data.elementAt(index).distanceMiles,
                 type:  "${DateFormat.MMMMd().add_jm().format(DateTime.parse(obj.data.data.elementAt(index).createdAt+"Z").toLocal())} ",
                        statusData: "123",
                        jobStatus: obj.data.data.elementAt(index).jobStatus),
              );
            },
            itemCount: obj.data.data.isEmpty ? 1 : obj.data.data.length,
          ),
        ),
      ],
    );
  }

  Widget containerBox(context, ref, description, title, function,
      {MissionRequestModel obj,
      visibleStatus,
      statusData,
      miles,
      type,
      String jobStatus}) {
    return Container(
      height: ScreenConfig.screenHeight * 0.25,
      width: ScreenConfig.screenWidth * 0.90,
      decoration: BoxDecoration(
        color: CColors.missonNormalWhiteColor,
        border: Border.all(color: CColors.missonLightGrey, width: 2),
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
                            text: " Job Reference number,",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Product",
                              color: CColors.missonMediumGrey,
                            )),
                      ]),
                    ),
                    Spacer(),
                    Text(
                      "Posted $type",
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
                          maxLines: 1,
                          style: TextStyle(
                            color: CColors.missonPrimaryColor,
                            fontFamily: "Product",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        )),
                    // Spacer(),
                    // Visibility(
                    //   visible: visibleStatus,
                    //   child: Expanded(
                    //     flex: 1,
                    //     child: roundTextBox("$statusData",CColors.blueText),
                    //   ),
                    // ),
                    //
                  ],
                ),
                SizedBox(height: ScreenConfig.screenHeight * 0.01),
                Row(
                  children: [
                    // Container(
                    //   width: 30,
                    //   height: 30,
                    //   decoration: BoxDecoration(
                    //     borderRadius: new BorderRadius.circular(30.0),
                    //     //shape: BoxShape.circle,
                    //     color: CColors.missonMediumGrey,
                    //   ),
                    //   child: Center(
                    //       child: SvgPicture.asset(
                    //     "",
                    //     height: ScreenConfig.screenHeight * 0.02,
                    //   )), //assets/images/jobIcon.svg
                    // ),
                    // SizedBox(width: ScreenConfig.screenWidth * 0.02),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: ScreenConfig.screenWidth * 0.6,
                              child: Text(
                                "$title ",
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: ScreenConfig.fontSizelarge,
                                    fontFamily: "Product",
                                    color: CColors.missonPrimaryColor),
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              )),
                          Text(
                            "$jobStatus",
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: "Product",
                                color: jobStatus == "pending"
                                    ? Colors.blueGrey
                                    : jobStatus == "accepted"
                                        ? CColors.missonSkyBlue
                                        : jobStatus == "processing"
                                            ? CColors.missonYellow
                                            : jobStatus == "cancelled"
                                                ? CColors.missonRed
                                                : jobStatus == "confirmed"
                                                    ? Colors.lightGreen
                                                    : CColors.missonGreen),
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
