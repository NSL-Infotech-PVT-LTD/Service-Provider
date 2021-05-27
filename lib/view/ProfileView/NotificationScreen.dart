import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:misson_tasker/model/ApiCaller.dart';
import 'package:misson_tasker/model/api_models/GetProfileDataModel.dart';
import 'package:misson_tasker/model/api_models/NotificationModel.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';
import 'package:misson_tasker/utils/StringsPath.dart';
import 'package:misson_tasker/utils/local_data.dart';
import 'package:misson_tasker/view/MissonRequestScreen/MissionRequest.dart';
import 'package:misson_tasker/view/startup_screens/SplashScreen.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isLoading = true;

  GetProfileDataModel getProfileDataModel;
  NotificationModel notificationModel;
  String auth;
  bool isLoadingData = true;

  @override
  void initState() {
    // registerUser();
    getString(sharedPref.userToken).then((value) {
      auth = value;

      print("123 $value");
    }).whenComplete(() {
      ApiCaller().getProfileData(auth: auth).then((value) {
        getProfileDataModel = value;
      }).whenComplete(() {
        setState(() {
          isLoadingData = false;
        });
        ApiCaller().getListOfNotification(auth: auth).then((value) {
          notificationModel = value;
        }).whenComplete(() {
          setState(() {
            isLoading = false;
          });
        });
      });
    });

    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> listOfNotifications = [
    {
      "name": "Jimmy Warish",
      "message": "Accepted your request for job. ",
      "time": "1hr ago",
      "isNotification": true,
    },
    {
      "name": "Armando A. Morris",
      "message": "Accepted your request for job. ",
      "time": "1hr ago",
      "isNotification": true,
    },
    {
      "name": "Todd Snow",
      "message": "Accepted your request for job. ",
      "time": "1hr ago",
      "isNotification": true,
    },
    {
      "name": "Jimmy Warish",
      "message": "Accepted your request for job. ",
      "time": "1hr ago",
      "isNotification": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 12.0, top: 30.0),
        //     child: Align(
        //         alignment: Alignment.topRight, child: SvgPicture.asset("")),
        //   ),
        // ],
        centerTitle: false,
        toolbarHeight: ScreenConfig.screenWidth * 0.2,
        title: Padding(
          padding: const EdgeInsets.only(right: 12.0, top: 30.0),
          child: Padding(
            padding: EdgeInsets.only(bottom: ScreenConfig.screenHeight * 0.03),
            child: Text(
              "Notifications",
              style: TextStyle(color: Colors.black, fontFamily: "Product"),
            ),
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
          color: CColors.missonNormalWhiteColor,
          child: isLoading == true
              ? Center(child: spinkit)
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: notificationModel.data.data.isEmpty
                            ? Center(
                                child: Text("There is no notification to show"))
                            : InkWell(
                                onTap: () {
                                  ApiCaller()
                                      .readNotification(
                                          auth: auth,
                                          Id: notificationModel.data.data
                                              .elementAt(index)
                                              .
                                              id
                                              .toString())
                                      .then((value) =>
                                          print("IS READ${value.toJson()}"))
                                      .whenComplete(() {
                                    Get.to(
                                            MissionRequest(
                                              id: notificationModel.data.data
                                                  .elementAt(index)
                                                  .bookingDetail
                                                  .targetId
                                                  .toString(),
                                            ),
                                            transition:
                                                Transition.leftToRightWithFade,
                                            duration:
                                                Duration(milliseconds: 400))
                                        .then((value) => initState());
                                  });
                                },
                                child: listCard(
                                    title:
                                        "${notificationModel.data.data.elementAt(index).title}"
                                            .replaceAll("Title.", ""),
                                    subtitle:
                                        "${notificationModel.data.data.elementAt(index).body}",
                                    time:
                                        "${DateFormat.jm().format(DateTime.parse(notificationModel.data.data.elementAt(index).updatedAt.toString()+"Z"))} ",
                                    showBadge: notificationModel.data.data
                                                .elementAt(index)
                                                .isRead !=
                                            "0"
                                        ? false
                                        : true,
                                    imageUrl: notificationModel.data.data
                                        .elementAt(index)
                                        .customerDetail
                                        .image),
                              ));
                  },
                  itemCount: notificationModel != null
                      ? notificationModel.data.data.isEmpty
                          ? 1
                          : notificationModel.data.data.length
                      : 0,
                )),
    );
  }

  listCard(
      {@required String title,
      @required String subtitle,
      @required String time,
      @required bool showBadge,
      @required String imageUrl}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Row(
        children: [
          Container(
            child: imageUrl == "" || imageUrl == null
                ? CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage(avatar1),
                  )
                : CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "$title",
                        style: TextStyle(
                            fontFamily: "Product",
                            fontSize: ScreenConfig.fontSizelarge),
                      ),
                      Spacer(),
                      Visibility(
                          visible: showBadge, child: SvgPicture.asset(dotLogo))
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Text(
                          "$subtitle",
                          style: TextStyle(
                              fontFamily: "Product",
                              fontSize: ScreenConfig.fontSizeMedium,
                              color: CColors.missonMediumGrey),
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Text(
                            "$time",
                            style: TextStyle(
                                fontSize: ScreenConfig.fontSizeSmall,
                                color: CColors.missonMediumGrey,
                                fontFamily: "Product"),
                            textAlign: TextAlign.right,
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
