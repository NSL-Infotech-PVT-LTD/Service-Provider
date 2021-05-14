import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:misson_tasker/model/api_models/GetProfileDataModel.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/CustomAppBar.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';
import 'package:misson_tasker/utils/StringsPath.dart';
import 'package:misson_tasker/view/startup_screens/Drawer.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          key: _drawerKey,
          drawer: Drawer(
            child: MyDrawer(
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
            titleHeading: "MissionExplore",
            titleSubHeading: "You can search for the mission you\nwant to do",
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
                showList(
                  exploreType: "upcoming",
                  context: context,
                  title: "fsdfrs",
                  visibleStatus: true,
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
                showList(
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
                showList(
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
                showList(
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
      {context,
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
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                child: containerBox(context, "$ref", "$title", "$description",
                    () {
                  switch (exploreType) {
                    case "upcoming":
                      {
                        print("Hello Upcoming");
                      }
                      break;

                    case "inProgress":
                      {
                        print("Hello inProgress");
                      }
                      break;
                    case "completed":
                      {
                        print("Hello Completed");
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
                    miles: miles,
                    type: "$type",
                    customWidget: customWidget,
                    visibleStatus: visibleStatus),
              );
            },
            itemCount: 10,
          ),
        ),
      ],
    );
  }

  Widget containerBox(context, ref, description, title, function,
      {visibleStatus, Widget customWidget, miles, type, String exploreType}) {
    return Container(
      height: ScreenConfig.screenHeight * 0.25,
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

                    Visibility(visible: visibleStatus, child: customWidget),
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
                            "$title ",
                            style: TextStyle(
                                fontSize: ScreenConfig.fontSizelarge,
                                fontFamily: "Product",
                                color: CColors.missonPrimaryColor),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          )),
                          Text(
                            "Tasker Required ",
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: "Product",
                                color: CColors.missonMediumGrey),
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
