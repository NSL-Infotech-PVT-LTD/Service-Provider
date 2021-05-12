import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:misson_tasker/model/ApiCaller.dart';
import 'package:misson_tasker/model/api_models/GetProfileDataModel.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/NavMe.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';
import 'package:misson_tasker/utils/StringsPath.dart';
import 'package:misson_tasker/utils/local_data.dart';

import 'package:misson_tasker/view/ProfileView/NotificationScreen.dart';

import 'package:misson_tasker/view/startup_screens/SplashScreen.dart';
import 'package:misson_tasker/model/api_models/GetJobByIdModel.dart';
import 'package:misson_tasker/model/api_models/ChnageJobStatusModel.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class MissionRequest extends StatefulWidget {
  final String id;

  const MissionRequest({Key key, this.id}) : super(key: key);

  @override
  _MissionRequestState createState() => _MissionRequestState();
}

class _MissionRequestState extends State<MissionRequest> {
  // bool isLoading = true;
  String _fullName = "Loading....";
  int currentCaseStatus = 1;
  TextEditingController locationController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  TextEditingController timeController = new TextEditingController();
  TextEditingController moneyController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  ChangeJobStatusModel changeJobStatusModel;
  String auth = "";
  GetJobByIdModel getJobByIdModel;
  bool isLoadingData = true;
  bool isJobStatusChanging = false;
  bool isAcceptButtonPressed = false;
  bool isDeclineButtonPressed = false;
  String viewValue = "pending";
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String cc;
  Barcode result;
  QRViewController controller;
  CountdownTimerController _countDownTimerController;
  int endTime;
  bool showDialogLoader = false;

  void onEnd() {
    print('onEnd');
  }

  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     controller.pauseCamera();
  //   } else if (Platform.isIOS) {
  //     controller.resumeCamera();
  //   }
  // }

  @override
  void initState() {
    // registerUser();

    getString(sharedPref.userToken).then((value) {
      auth = value;

      print("123 $value");
    }).whenComplete(() {
      ApiCaller()
          .getJobDetailsByID(auth: auth, Id: widget.id)
          .then((value) => getJobByIdModel = value)
          .whenComplete(() {
        setState(() {
          isLoadingData = false;
          locationController.text = getJobByIdModel.data.location;
          dateController.text =
              "${getJobByIdModel.data.startDate.day}/${getJobByIdModel.data.startDate.month}/${getJobByIdModel.data.startDate.year}";
          timeController.text = getJobByIdModel.data.startTime;
          moneyController.text = getJobByIdModel.data.budget.toString();
          descriptionController.text = getJobByIdModel.data.description;
          viewValue = getJobByIdModel.data.jobStatus;
          endTime = DateTime.now().millisecondsSinceEpoch +
              1000 *
                  ((getJobByIdModel.data.estimatedHours.split(":").elementAt(0) != "0"
                          ? int.parse(getJobByIdModel.data.estimatedHours
                                  .split(":")
                                  .elementAt(0)) *
                              3600
                          : 0 * 3600) +
                      (getJobByIdModel.data.estimatedHours.split(":").elementAt(1) !=
                              "0"
                          ? int.parse(getJobByIdModel.data.estimatedHours
                                  .split(":")
                                  .elementAt(1)) *
                              60
                          : 0 * 60) +
                      (getJobByIdModel.data.estimatedHours
                                  .split(":")
                                  .elementAt(2) !=
                              "0"
                          ? int.parse(getJobByIdModel.data.estimatedHours.split(":").elementAt(2))
                          : 0));

          if (viewValue == "confirmed") {
            print("111 $viewValue");
            setState(() {
              currentCaseStatus = 2;
            });
          }
          if (viewValue == "processing") {
            print("111 $viewValue");

            setState(() {
              currentCaseStatus = 3;
            });
          }
        });
      });
    });
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  String stateOfSheet = "isClose";
  String timeOfSheet = "isActive";
  PanelController _panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return screenView("$currentCaseStatus");
    // return screenView("2");
  }

  Widget screenView(String status) {
    switch (status) {
      case "1":
        {
          // statements;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              actions: [
                InkWell(
                  onTap: () {
                    // NavMe().NavPushLeftToRight(NotificationScreen());
                    initState();
                  },
                  child: Padding(
                      padding: const EdgeInsets.only(right: 18.0, top: 30.0),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.refresh,
                            color: CColors.missonPrimaryColor,
                          ))
                      // SvgPicture.asset(optionLogo)),
                      ),
                ),
              ],
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 30.0),
                child: Text(
                  "Mission Request",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Product",
                      fontWeight: FontWeight.w200,
                      fontSize: ScreenConfig.fontSizeXlarge),
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
            body: isLoadingData == true
                ? Center(child: spinkit)
                : SingleChildScrollView(
                    child: Container(
                        margin: EdgeInsets.only(
                            top: ScreenConfig.screenHeight * 0.05),
                        color: Colors.white,
                        child: Column(
                          children: [
                            Container(
                              width: ScreenConfig.screenWidth * 0.80,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${getJobByIdModel.data.title}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                ScreenConfig.fontSizeXXlarge,
                                            fontFamily: "Product"),
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height:
                                            ScreenConfig.screenHeight * 0.01,
                                      ),
                                      Text(
                                        "Posted on 18/04/2021 , 02:34 PM",
                                        style: TextStyle(
                                          color: CColors.missonMediumGrey,
                                          fontSize: ScreenConfig.fontSizeSmall,
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            ScreenConfig.screenHeight * 0.02,
                                      ),
                                      Text(
                                        "Job Reference number",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: ScreenConfig.fontSizeSmall,
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            ScreenConfig.screenHeight * 0.02,
                                      ),
                                      Text(
                                        "#${getJobByIdModel.data.id}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: ScreenConfig.fontSizeXlarge,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Text(
                                    "Mission details",
                                    style: TextStyle(
                                        fontSize: ScreenConfig.fontSizelarge,
                                        fontWeight: FontWeight.w300,
                                        color: CColors.missonPrimaryColor),
                                  ),
                                ),
                                Spacer()
                              ],
                            ),
                            Divider(
                              color: CColors.missonMediumGrey,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 8.0),
                              child: TextFormField(
                                controller: locationController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                        SvgPicture.asset(locationTextFiledIcon),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 8.0),
                              child: TextFormField(
                                controller: dateController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                        SvgPicture.asset(calanderTextFiledIcon),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 8.0),
                              child: TextFormField(
                                controller: timeController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(timeTextFiledIcon),
                                  ),
                                  suffixIcon: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 16.0),
                                        child: Text(
                                          "Hrs",
                                          style: TextStyle(
                                              fontSize:
                                                  ScreenConfig.fontSizelarge,
                                              fontWeight: FontWeight.w300,
                                              color: CColors.missonMediumGrey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 8.0),
                              child: TextFormField(
                                controller: moneyController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(cashLogo),
                                  ),
                                  suffixIcon: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 16.0),
                                        child: Text(
                                          "\$/hr",
                                          style: TextStyle(
                                              fontSize:
                                                  ScreenConfig.fontSizelarge,
                                              fontWeight: FontWeight.w300,
                                              color: CColors.missonMediumGrey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8.0),
                                  child: Text(
                                    "Description",
                                    style: TextStyle(
                                        fontSize: ScreenConfig.fontSizeXlarge,
                                        fontWeight: FontWeight.w300,
                                        color: CColors.missonPrimaryColor),
                                  ),
                                ),
                                Spacer()
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 8.0),
                              child: Container(
                                child: TextFormField(
                                  controller: descriptionController,
                                  readOnly: true,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 8,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: CColors.missonMediumGrey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            AnimatedSwitcher(
                              duration: Duration(milliseconds: 400),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return ScaleTransition(
                                    child: child, scale: animation);
                              },
                              child: bottomView(viewValue),
                            )
                          ],
                        )),
                  ),
          );
        }
        break;

      case "2":
        {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              actions: [
                InkWell(
                  onTap: () {
                    // NavMe().NavPushLeftToRight(NotificationScreen());
                    initState();
                  },
                  child: Padding(
                      padding: const EdgeInsets.only(right: 18.0, top: 30.0),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Icon(Icons.refresh,
                              color: CColors.missonPrimaryColor))

                      // SvgPicture.asset(optionLogo)),
                      ),
                ),
              ],
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 30.0),
                child: Text(
                  "Mission Request",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Product",
                      fontWeight: FontWeight.w200,
                      fontSize: ScreenConfig.fontSizeXlarge),
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
            body: isLoadingData == true
                ? Center(child: spinkit)
                : SlidingUpPanel(
                    controller: _panelController,
                    color: CColors.missonPrimaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    onPanelOpened: () {
                      setState(() {
                        stateOfSheet = "isOpen";
                      });
                    },
                    onPanelClosed: () {
                      setState(() {
                        stateOfSheet = "isClose";
                      });
                    },
                    minHeight: 170,
                    maxHeight: ScreenConfig.screenHeight,
                    panel: showScannerState(stateOfSheet),
                    body: SingleChildScrollView(
                      child: Container(
                          margin: EdgeInsets.only(
                              top: ScreenConfig.screenHeight * 0.05),
                          color: Colors.white,
                          child: Column(
                            children: [
                              Container(
                                width: ScreenConfig.screenWidth * 0.80,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${getJobByIdModel.data.title}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  ScreenConfig.fontSizeXXlarge,
                                              fontFamily: "Product"),
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height:
                                              ScreenConfig.screenHeight * 0.01,
                                        ),
                                        Text(
                                          "Posted on 18/04/2021 , 02:34 PM",
                                          style: TextStyle(
                                            color: CColors.missonMediumGrey,
                                            fontSize:
                                                ScreenConfig.fontSizeSmall,
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              ScreenConfig.screenHeight * 0.02,
                                        ),
                                        Text(
                                          "Job Reference number",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                ScreenConfig.fontSizeSmall,
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              ScreenConfig.screenHeight * 0.02,
                                        ),
                                        Text(
                                          "#${getJobByIdModel.data.id}",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                ScreenConfig.fontSizeXlarge,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              ExpansionTile(
                                tilePadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                title: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Mission details",
                                      style: TextStyle(
                                          fontSize: ScreenConfig.fontSizelarge,
                                          fontWeight: FontWeight.w300,
                                          color: CColors.missonPrimaryColor),
                                    ),
                                  ],
                                ),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 8.0),
                                    child: TextFormField(
                                      controller: locationController,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                              locationTextFiledIcon),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 8.0),
                                    child: TextFormField(
                                      controller: dateController,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                              calanderTextFiledIcon),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 8.0),
                                    child: TextFormField(
                                      controller: timeController,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                              timeTextFiledIcon),
                                        ),
                                        suffixIcon: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 16.0),
                                              child: Text(
                                                "Hrs",
                                                style: TextStyle(
                                                    fontSize: ScreenConfig
                                                        .fontSizelarge,
                                                    fontWeight: FontWeight.w300,
                                                    color: CColors
                                                        .missonMediumGrey),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 8.0),
                                    child: TextFormField(
                                      controller: moneyController,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(cashLogo),
                                        ),
                                        suffixIcon: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 16.0),
                                              child: Text(
                                                "\$/hr",
                                                style: TextStyle(
                                                    fontSize: ScreenConfig
                                                        .fontSizelarge,
                                                    fontWeight: FontWeight.w300,
                                                    color: CColors
                                                        .missonMediumGrey),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8.0),
                                        child: Text(
                                          "Description",
                                          style: TextStyle(
                                              fontSize:
                                                  ScreenConfig.fontSizeXlarge,
                                              fontWeight: FontWeight.w300,
                                              color:
                                                  CColors.missonPrimaryColor),
                                        ),
                                      ),
                                      Spacer()
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 8.0),
                                    child: Container(
                                      child: TextFormField(
                                        controller: descriptionController,
                                        readOnly: true,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 8,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: CColors.missonMediumGrey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                              ExpansionTile(
                                tilePadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                title: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Mission Status",
                                      style: TextStyle(
                                          fontSize: ScreenConfig.fontSizelarge,
                                          fontWeight: FontWeight.w300,
                                          color: CColors.missonPrimaryColor),
                                    ),
                                  ],
                                ),
                                children: [
                                  Text(
                                    "Mission not started yet",
                                    style: TextStyle(
                                        fontSize: ScreenConfig.fontSizelarge,
                                        fontWeight: FontWeight.w500,
                                        color: CColors.missonPrimaryColor),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Ready for your mission, we will redirect\n request in this page",
                                    style: TextStyle(
                                        fontSize: ScreenConfig.fontSizeMedium,
                                        fontWeight: FontWeight.w500,
                                        color: CColors.missonMediumGrey),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Text(
                                    "This new mission has been moved to \n upcoming mission tab",
                                    style: TextStyle(
                                        fontSize: ScreenConfig.fontSizeMedium,
                                        fontWeight: FontWeight.w400,
                                        color: CColors.missonGrey),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Click it here",
                                    style: TextStyle(
                                        fontSize: ScreenConfig.fontSizeMedium,
                                        fontWeight: FontWeight.w400,
                                        color: CColors.missonSkyBlue),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 300,
                              )
                            ],
                          )),
                    ),
                  ),
          );
        }

        break;
      case "3":
        {
          // initState();

          // endTime =  1210;
          // endTime = DateTime.now().millisecondsSinceEpoch + 1000 *((getJobByIdModel.data.estimatedHours
          //                 .split(":")
          //                 .elementAt(0) !=
          //             "0"
          //         ? int.parse(getJobByIdModel.data.estimatedHours
          //                 .split(":")
          //                 .elementAt(0)) *
          //             3600
          //         : 0 * 3600) +
          //     (getJobByIdModel.data.estimatedHours.split(":").elementAt(1) != "0"
          //         ? int.parse(getJobByIdModel.data.estimatedHours
          //                 .split(":")
          //                 .elementAt(1)) *
          //             60
          //         : 0 * 60) +
          //     (getJobByIdModel.data.estimatedHours.split(":").elementAt(2) != "0"
          //         ? int.parse(getJobByIdModel.data.estimatedHours
          //             .split(":")
          //             .elementAt(2))
          //         : 0));
          print(
              "ALFENO ${((getJobByIdModel.data.estimatedHours.split(":").elementAt(0) != "0" ? int.parse(getJobByIdModel.data.estimatedHours.split(":").elementAt(0)) * 3600 : 0 * 3600) + (getJobByIdModel.data.estimatedHours.split(":").elementAt(1) != "0" ? int.parse(getJobByIdModel.data.estimatedHours.split(":").elementAt(1)) * 60 : 0 * 60) + (getJobByIdModel.data.estimatedHours.split(":").elementAt(2) != "0" ? int.parse(getJobByIdModel.data.estimatedHours.split(":").elementAt(2)) : 0))}");

          // endTime = DateTime.now().millisecondsSinceEpoch +
          //     1000 *
          //         ((getJobByIdModel.data.estimatedHours.split(":").elementAt(0) !=
          //             "0"
          //             ? int.parse(getJobByIdModel.data.estimatedHours
          //             .split(":")
          //             .elementAt(0))
          //             : 0 * 3600) +
          //             (getJobByIdModel.data.estimatedHours
          //                 .split(":")
          //                 .elementAt(1) !=
          //                 "0"
          //                 ? int.parse(getJobByIdModel.data.estimatedHours
          //                 .split(":")
          //                 .elementAt(1))
          //                 : 0 * 60) +
          //             (getJobByIdModel.data.estimatedHours
          //                 .split(":")
          //                 .elementAt(2) !=
          //                 "0"
          //                 ? int.parse(getJobByIdModel.data.estimatedHours.split(":").elementAt(2))
          //                 : 0));
          // endTime = DateTime.now().millisecondsSinceEpoch +
          //     1000 *
          //         ((getJobByIdModel.data.estimatedHours.split(pattern) * 3600) +
          //             (getJobByIdModel.data.estimatedHours.minute *
          //                 60) *
          //                 (getJobByIdModel.data.estimatedHours.second));
          _countDownTimerController =
              CountdownTimerController(endTime: endTime, onEnd: onEnd);

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              actions: [
                InkWell(
                  onTap: () {
                    // NavMe().NavPushLeftToRight(NotificationScreen());
                    initState();
                  },
                  child: Padding(
                      padding: const EdgeInsets.only(right: 18.0, top: 30.0),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Icon(Icons.refresh,
                              color: CColors.missonPrimaryColor))
                      // SvgPicture.asset(optionLogo)),
                      ),
                ),
              ],
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 30.0),
                child: Text(
                  "Mission Request",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Product",
                      fontWeight: FontWeight.w200,
                      fontSize: ScreenConfig.fontSizeXlarge),
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
            body: isLoadingData == true
                ? Center(child: spinkit)
                : SlidingUpPanel(
                    controller: _panelController,
                    color: CColors.missonPrimaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    onPanelOpened: () {},
                    onPanelClosed: () {},
                    // minHeight: ScreenConfig.screenHeight*0.25,
                    maxHeight: ScreenConfig.screenHeight * 0.25,
                    panel: showTimerState(timeOfSheet),
                    body: SingleChildScrollView(
                      child: Container(
                          margin: EdgeInsets.only(
                              top: ScreenConfig.screenHeight * 0.05),
                          color: Colors.white,
                          child: Column(
                            children: [
                              Container(
                                width: ScreenConfig.screenWidth * 0.80,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${getJobByIdModel.data.title}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  ScreenConfig.fontSizeXXlarge,
                                              fontFamily: "Product"),
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height:
                                              ScreenConfig.screenHeight * 0.01,
                                        ),
                                        Text(
                                          "Posted on 18/04/2021 , 02:34 PM",
                                          style: TextStyle(
                                            color: CColors.missonMediumGrey,
                                            fontSize:
                                                ScreenConfig.fontSizeSmall,
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              ScreenConfig.screenHeight * 0.02,
                                        ),
                                        Text(
                                          "Job Reference number",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                ScreenConfig.fontSizeSmall,
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              ScreenConfig.screenHeight * 0.02,
                                        ),
                                        Text(
                                          "#${getJobByIdModel.data.id}",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                ScreenConfig.fontSizeXlarge,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              ExpansionTile(
                                tilePadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                title: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Mission details",
                                      style: TextStyle(
                                          fontSize: ScreenConfig.fontSizelarge,
                                          fontWeight: FontWeight.w300,
                                          color: CColors.missonPrimaryColor),
                                    ),
                                  ],
                                ),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 8.0),
                                    child: TextFormField(
                                      controller: locationController,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                              locationTextFiledIcon),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 8.0),
                                    child: TextFormField(
                                      controller: dateController,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                              calanderTextFiledIcon),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 8.0),
                                    child: TextFormField(
                                      controller: timeController,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                              timeTextFiledIcon),
                                        ),
                                        suffixIcon: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 16.0),
                                              child: Text(
                                                "Hrs",
                                                style: TextStyle(
                                                    fontSize: ScreenConfig
                                                        .fontSizelarge,
                                                    fontWeight: FontWeight.w300,
                                                    color: CColors
                                                        .missonMediumGrey),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 8.0),
                                    child: TextFormField(
                                      controller: moneyController,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(cashLogo),
                                        ),
                                        suffixIcon: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 16.0),
                                              child: Text(
                                                "\$/hr",
                                                style: TextStyle(
                                                    fontSize: ScreenConfig
                                                        .fontSizelarge,
                                                    fontWeight: FontWeight.w300,
                                                    color: CColors
                                                        .missonMediumGrey),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8.0),
                                        child: Text(
                                          "Description",
                                          style: TextStyle(
                                              fontSize:
                                                  ScreenConfig.fontSizeXlarge,
                                              fontWeight: FontWeight.w300,
                                              color:
                                                  CColors.missonPrimaryColor),
                                        ),
                                      ),
                                      Spacer()
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 8.0),
                                    child: Container(
                                      child: TextFormField(
                                        controller: descriptionController,
                                        readOnly: true,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 8,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: CColors.missonMediumGrey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                              ExpansionTile(
                                tilePadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                title: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Mission Status",
                                      style: TextStyle(
                                          fontSize: ScreenConfig.fontSizelarge,
                                          fontWeight: FontWeight.w300,
                                          color: CColors.missonPrimaryColor),
                                    ),
                                  ],
                                ),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: TimelineTile(
                                      alignment: TimelineAlign.start,
                                      // afterLineStyle: ,
                                      // isLast: false,
                                      isFirst: true,
                                      indicatorStyle: IndicatorStyle(
                                        width: 20,
                                        color: CColors.missonGrey,
                                        // indicator: Text("efdsf"),
                                        // indicatorXY: 0.7,
                                        iconStyle: IconStyle(
                                          color: CColors.missonNormalWhiteColor,
                                          iconData: Icons.check,
                                        ),
                                      ),
                                      endChild: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Advance pay",
                                              style: TextStyle(
                                                  fontSize: ScreenConfig
                                                      .fontSizelarge,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Product",
                                                  color: CColors
                                                      .missonPrimaryColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: TimelineTile(
                                      alignment: TimelineAlign.start,
                                      // afterLineStyle: ,
                                      // isLast: false,
                                      // isFirst: true,
                                      indicatorStyle: IndicatorStyle(
                                        width: 20,
                                        color: CColors.missonGrey,
                                        // indicator: Text("efdsf"),
                                        // indicatorXY: 0.7,
                                        iconStyle: IconStyle(
                                          color: CColors.missonNormalWhiteColor,
                                          iconData: Icons.check,
                                        ),
                                      ),
                                      endChild: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 30),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Mission Started",
                                              style: TextStyle(
                                                  fontSize: ScreenConfig
                                                      .fontSizelarge,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Product",
                                                  color: CColors
                                                      .missonPrimaryColor),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "12:36 PM, Thursday, 32 march",
                                              style: TextStyle(
                                                  fontSize: ScreenConfig
                                                      .fontSizeMedium,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Product",
                                                  color:
                                                      CColors.missonMediumGrey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: TimelineTile(
                                      alignment: TimelineAlign.start,
                                      // afterLineStyle: ,
                                      // isLast: false,
                                      // isFirst: true,
                                      indicatorStyle: IndicatorStyle(
                                        width: 20,
                                        color: CColors.missonGreen,
                                        // indicator: Text("efdsf"),
                                        // indicatorXY: 0.7,
                                        iconStyle: IconStyle(
                                          color: CColors.missonNormalWhiteColor,
                                          iconData: Icons.check,
                                        ),
                                      ),
                                      endChild: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Mission Accomplished",
                                              style: TextStyle(
                                                  fontSize: ScreenConfig
                                                      .fontSizelarge,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Product",
                                                  color: CColors
                                                      .missonPrimaryColor),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "12:36 PM, Thursday, 32 march",
                                              style: TextStyle(
                                                  fontSize: ScreenConfig
                                                      .fontSizeMedium,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Product",
                                                  color:
                                                      CColors.missonMediumGrey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: TimelineTile(
                                      alignment: TimelineAlign.start,
                                      // afterLineStyle: ,
                                      isLast: true,
                                      // isFirst: true,
                                      indicatorStyle: IndicatorStyle(
                                        width: 20,
                                        color: CColors.missonGrey,
                                        // indicator: Text("efdsf"),
                                        // indicatorXY: 0.7,
                                        iconStyle: IconStyle(
                                          color: CColors.missonNormalWhiteColor,
                                          iconData: Icons.check,
                                        ),
                                      ),
                                      endChild: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Total Payment",
                                                  style: TextStyle(
                                                      fontSize: ScreenConfig
                                                          .fontSizelarge,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: "Product",
                                                      color: CColors
                                                          .missonPrimaryColor),
                                                ),
                                                Spacer(),
                                                Text(
                                                  "\$ 174.00",
                                                  style: TextStyle(
                                                      fontSize: ScreenConfig
                                                          .fontSizelarge,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: "Product",
                                                      color:
                                                          CColors.missonGreen),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "View Receipt",
                                              style: TextStyle(
                                                  fontSize: ScreenConfig
                                                      .fontSizeMedium,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Product",
                                                  color: Colors.blue),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              SizedBox(height: ScreenConfig.screenHeight*0.25,)
                            ],
                          )),
                    ),
                  ),
          );
        }
        break;
      case "4":
        {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              actions: [
                InkWell(
                  onTap: () {
                    // NavMe().NavPushLeftToRight(NotificationScreen());
                    initState();
                  },
                  child: Padding(
                      padding:
                      const EdgeInsets.only(right: 18.0, top: 30.0),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Icon(Icons.refresh,
                              color: CColors.missonPrimaryColor))
                    // SvgPicture.asset(optionLogo)),
                  ),
                ),
              ],
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 30.0),
                child: Text(
                  "Mission Request",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Product",
                      fontWeight: FontWeight.w200,
                      fontSize: ScreenConfig.fontSizeXlarge),
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
            body: isLoadingData == true
                ? Center(child: spinkit)
                : SlidingUpPanel(
              controller: _panelController,
              color: CColors.missonPrimaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              onPanelOpened: () {},
              onPanelClosed: () {},
              // minHeight: ScreenConfig.screenHeight*0.25,
              maxHeight: ScreenConfig.screenHeight * 0.25,
              panel: showTimerState(timeOfSheet),
              body: SingleChildScrollView(
                child: Container(
                    margin: EdgeInsets.only(
                        top: ScreenConfig.screenHeight * 0.05),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          width: ScreenConfig.screenWidth * 0.80,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${getJobByIdModel.data.title}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight:
                                        FontWeight.bold,
                                        fontSize: ScreenConfig
                                            .fontSizeXXlarge,
                                        fontFamily: "Product"),
                                    softWrap: true,
                                    overflow:
                                    TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: ScreenConfig
                                        .screenHeight *
                                        0.01,
                                  ),
                                  Text(
                                    "Posted on 18/04/2021 , 02:34 PM",
                                    style: TextStyle(
                                      color: CColors
                                          .missonMediumGrey,
                                      fontSize: ScreenConfig
                                          .fontSizeSmall,
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenConfig
                                        .screenHeight *
                                        0.02,
                                  ),
                                  Text(
                                    "Job Reference number",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: ScreenConfig
                                          .fontSizeSmall,
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenConfig
                                        .screenHeight *
                                        0.02,
                                  ),
                                  Text(
                                    "#${getJobByIdModel.data.id}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenConfig
                                          .fontSizeXlarge,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        ExpansionTile(
                          tilePadding: EdgeInsets.symmetric(
                              horizontal: 10),
                          title: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.end,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mission details",
                                style: TextStyle(
                                    fontSize: ScreenConfig
                                        .fontSizelarge,
                                    fontWeight: FontWeight.w300,
                                    color: CColors
                                        .missonPrimaryColor),
                              ),
                            ],
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                  vertical: 8.0),
                              child: TextFormField(
                                controller: locationController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding:
                                    const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                        locationTextFiledIcon),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                  vertical: 8.0),
                              child: TextFormField(
                                controller: dateController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding:
                                    const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                        calanderTextFiledIcon),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                  vertical: 8.0),
                              child: TextFormField(
                                controller: timeController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding:
                                    const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                        timeTextFiledIcon),
                                  ),
                                  suffixIcon: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            right: 16.0),
                                        child: Text(
                                          "Hrs",
                                          style: TextStyle(
                                              fontSize: ScreenConfig
                                                  .fontSizelarge,
                                              fontWeight:
                                              FontWeight.w300,
                                              color: CColors
                                                  .missonMediumGrey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                  vertical: 8.0),
                              child: TextFormField(
                                controller: moneyController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding:
                                    const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                        cashLogo),
                                  ),
                                  suffixIcon: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            right: 16.0),
                                        child: Text(
                                          "\$/hr",
                                          style: TextStyle(
                                              fontSize: ScreenConfig
                                                  .fontSizelarge,
                                              fontWeight:
                                              FontWeight.w300,
                                              color: CColors
                                                  .missonMediumGrey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8.0),
                                  child: Text(
                                    "Description",
                                    style: TextStyle(
                                        fontSize: ScreenConfig
                                            .fontSizeXlarge,
                                        fontWeight:
                                        FontWeight.w300,
                                        color: CColors
                                            .missonPrimaryColor),
                                  ),
                                ),
                                Spacer()
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 8.0),
                              child: Container(
                                child: TextFormField(
                                  controller:
                                  descriptionController,
                                  readOnly: true,
                                  keyboardType:
                                  TextInputType.multiline,
                                  maxLines: 8,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: CColors
                                            .missonMediumGrey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                        ExpansionTile(
                          tilePadding: EdgeInsets.symmetric(
                              horizontal: 10),
                          title: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.end,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mission Status",
                                style: TextStyle(
                                    fontSize: ScreenConfig
                                        .fontSizelarge,
                                    fontWeight: FontWeight.w300,
                                    color: CColors
                                        .missonPrimaryColor),
                              ),
                            ],
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0),
                              child: TimelineTile(
                                alignment: TimelineAlign.start,
                                // afterLineStyle: ,
                                // isLast: false,
                                isFirst: true,
                                indicatorStyle: IndicatorStyle(
                                  width: 20,
                                  color: CColors.missonGrey,
                                  // indicator: Text("efdsf"),
                                  // indicatorXY: 0.7,
                                  iconStyle: IconStyle(
                                    color: CColors
                                        .missonNormalWhiteColor,
                                    iconData: Icons.check,
                                  ),
                                ),
                                endChild: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Advance pay",
                                        style: TextStyle(
                                            fontSize: ScreenConfig
                                                .fontSizelarge,
                                            fontWeight:
                                            FontWeight.w500,
                                            fontFamily: "Product",
                                            color: CColors
                                                .missonPrimaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0),
                              child: TimelineTile(
                                alignment: TimelineAlign.start,
                                // afterLineStyle: ,
                                // isLast: false,
                                // isFirst: true,
                                indicatorStyle: IndicatorStyle(
                                  width: 20,
                                  color: CColors.missonGrey,
                                  // indicator: Text("efdsf"),
                                  // indicatorXY: 0.7,
                                  iconStyle: IconStyle(
                                    color: CColors
                                        .missonNormalWhiteColor,
                                    iconData: Icons.check,
                                  ),
                                ),
                                endChild: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 30),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.end,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Mission Started",
                                        style: TextStyle(
                                            fontSize: ScreenConfig
                                                .fontSizelarge,
                                            fontWeight:
                                            FontWeight.w500,
                                            fontFamily: "Product",
                                            color: CColors
                                                .missonPrimaryColor),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "12:36 PM, Thursday, 32 march",
                                        style: TextStyle(
                                            fontSize: ScreenConfig
                                                .fontSizeMedium,
                                            fontWeight:
                                            FontWeight.w500,
                                            fontFamily: "Product",
                                            color: CColors
                                                .missonMediumGrey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0),
                              child: TimelineTile(
                                alignment: TimelineAlign.start,
                                // afterLineStyle: ,
                                // isLast: false,
                                // isFirst: true,
                                indicatorStyle: IndicatorStyle(
                                  width: 20,
                                  color: CColors.missonGreen,
                                  // indicator: Text("efdsf"),
                                  // indicatorXY: 0.7,
                                  iconStyle: IconStyle(
                                    color: CColors
                                        .missonNormalWhiteColor,
                                    iconData: Icons.check,
                                  ),
                                ),
                                endChild: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 20),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.end,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Mission Accomplished",
                                        style: TextStyle(
                                            fontSize: ScreenConfig
                                                .fontSizelarge,
                                            fontWeight:
                                            FontWeight.w500,
                                            fontFamily: "Product",
                                            color: CColors
                                                .missonPrimaryColor),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "12:36 PM, Thursday, 32 march",
                                        style: TextStyle(
                                            fontSize: ScreenConfig
                                                .fontSizeMedium,
                                            fontWeight:
                                            FontWeight.w500,
                                            fontFamily: "Product",
                                            color: CColors
                                                .missonMediumGrey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0),
                              child: TimelineTile(
                                alignment: TimelineAlign.start,
                                // afterLineStyle: ,
                                isLast: true,
                                // isFirst: true,
                                indicatorStyle: IndicatorStyle(
                                  width: 20,
                                  color: CColors
                                      .missonNormalWhiteColor,
                                  // indicator: Text("efdsf"),
                                  // indicatorXY: 0.7,
                                  // iconStyle: IconStyle(
                                  //   color: CColors
                                  //       .missonNormalWhiteColor,
                                  //   iconData: Icons.check,
                                  // ),
                                ),
                                endChild: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 20),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.end,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Total Payment",
                                            style: TextStyle(
                                                fontSize: ScreenConfig
                                                    .fontSizelarge,
                                                fontWeight:
                                                FontWeight
                                                    .w500,
                                                fontFamily:
                                                "Product",
                                                color: CColors
                                                    .missonPrimaryColor),
                                          ),
                                          Spacer(),
                                          // Text(
                                          //   "\$ 174.00",
                                          //   style: TextStyle(
                                          //       fontSize: ScreenConfig
                                          //           .fontSizelarge,
                                          //       fontWeight:
                                          //           FontWeight
                                          //               .bold,
                                          //       fontFamily:
                                          //           "Product",
                                          //       color: CColors
                                          //           .missonGreen),
                                          // ),
                                          SizedBox(
                                            width: 20,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "View Receipt",
                                        style: TextStyle(
                                            fontSize: ScreenConfig
                                                .fontSizeMedium,
                                            fontWeight:
                                            FontWeight.bold,
                                            fontFamily: "Product",
                                            color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        )
                      ],
                    )),
              ),
            ),
          );
        }
        break;
      case "5":
        {

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              actions: [
                InkWell(
                  onTap: () {
                    // NavMe().NavPushLeftToRight(NotificationScreen());
                    initState();
                  },
                  child: Padding(
                      padding:
                      const EdgeInsets.only(right: 18.0, top: 30.0),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Icon(Icons.refresh,
                              color: CColors.missonPrimaryColor))
                    // SvgPicture.asset(optionLogo)),
                  ),
                ),
              ],
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 30.0),
                child: Text(
                  "Mission Request",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Product",
                      fontWeight: FontWeight.w200,
                      fontSize: ScreenConfig.fontSizeXlarge),
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
            body: isLoadingData == true
                ? Center(child: spinkit)
                : SlidingUpPanel(
              controller: _panelController,
              color: CColors.missonPrimaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),

              maxHeight: 0,
              minHeight: 0,
              // maxHeight: ScreenConfig.screenHeight * 0.25,
              panel: Container(),
              body: SingleChildScrollView(
                child: Container(
                    margin: EdgeInsets.only(
                        top: ScreenConfig.screenHeight * 0.05),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          width: ScreenConfig.screenWidth * 0.80,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${getJobByIdModel.data.title}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight:
                                        FontWeight.bold,
                                        fontSize: ScreenConfig
                                            .fontSizeXXlarge,
                                        fontFamily: "Product"),
                                    softWrap: true,
                                    overflow:
                                    TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: ScreenConfig
                                        .screenHeight *
                                        0.01,
                                  ),
                                  Text(
                                    "Posted on 18/04/2021 , 02:34 PM",
                                    style: TextStyle(
                                      color: CColors
                                          .missonMediumGrey,
                                      fontSize: ScreenConfig
                                          .fontSizeSmall,
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenConfig
                                        .screenHeight *
                                        0.02,
                                  ),
                                  Text(
                                    "Job Reference number",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: ScreenConfig
                                          .fontSizeSmall,
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenConfig
                                        .screenHeight *
                                        0.02,
                                  ),
                                  Text(
                                    "#${getJobByIdModel.data.id}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenConfig
                                          .fontSizeXlarge,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        ExpansionTile(
                          tilePadding: EdgeInsets.symmetric(
                              horizontal: 10),
                          title: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.end,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mission details",
                                style: TextStyle(
                                    fontSize: ScreenConfig
                                        .fontSizelarge,
                                    fontWeight: FontWeight.w300,
                                    color: CColors
                                        .missonPrimaryColor),
                              ),
                            ],
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                  vertical: 8.0),
                              child: TextFormField(
                                controller: locationController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding:
                                    const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                        locationTextFiledIcon),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                  vertical: 8.0),
                              child: TextFormField(
                                controller: dateController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding:
                                    const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                        calanderTextFiledIcon),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                  vertical: 8.0),
                              child: TextFormField(
                                controller: timeController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding:
                                    const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                        timeTextFiledIcon),
                                  ),
                                  suffixIcon: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            right: 16.0),
                                        child: Text(
                                          "Hrs",
                                          style: TextStyle(
                                              fontSize: ScreenConfig
                                                  .fontSizelarge,
                                              fontWeight:
                                              FontWeight.w300,
                                              color: CColors
                                                  .missonMediumGrey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                  vertical: 8.0),
                              child: TextFormField(
                                controller: moneyController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding:
                                    const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                        cashLogo),
                                  ),
                                  suffixIcon: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            right: 16.0),
                                        child: Text(
                                          "\$/hr",
                                          style: TextStyle(
                                              fontSize: ScreenConfig
                                                  .fontSizelarge,
                                              fontWeight:
                                              FontWeight.w300,
                                              color: CColors
                                                  .missonMediumGrey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8.0),
                                  child: Text(
                                    "Description",
                                    style: TextStyle(
                                        fontSize: ScreenConfig
                                            .fontSizeXlarge,
                                        fontWeight:
                                        FontWeight.w300,
                                        color: CColors
                                            .missonPrimaryColor),
                                  ),
                                ),
                                Spacer()
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 8.0),
                              child: Container(
                                child: TextFormField(
                                  controller:
                                  descriptionController,
                                  readOnly: true,
                                  keyboardType:
                                  TextInputType.multiline,
                                  maxLines: 8,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: CColors
                                            .missonMediumGrey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                        ExpansionTile(
                          tilePadding: EdgeInsets.symmetric(
                              horizontal: 10),
                          title: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.end,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mission Status",
                                style: TextStyle(
                                    fontSize: ScreenConfig
                                        .fontSizelarge,
                                    fontWeight: FontWeight.w300,
                                    color: CColors
                                        .missonPrimaryColor),
                              ),
                            ],
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0),
                              child: TimelineTile(
                                alignment: TimelineAlign.start,
                                // afterLineStyle: ,
                                // isLast: false,
                                isFirst: true,
                                indicatorStyle: IndicatorStyle(
                                  width: 20,
                                  color: CColors.missonGrey,
                                  // indicator: Text("efdsf"),
                                  // indicatorXY: 0.7,
                                  iconStyle: IconStyle(
                                    color: CColors
                                        .missonNormalWhiteColor,
                                    iconData: Icons.check,
                                  ),
                                ),
                                endChild: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Advance pay",
                                        style: TextStyle(
                                            fontSize: ScreenConfig
                                                .fontSizelarge,
                                            fontWeight:
                                            FontWeight.w500,
                                            fontFamily: "Product",
                                            color: CColors
                                                .missonPrimaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0),
                              child: TimelineTile(
                                alignment: TimelineAlign.start,
                                // afterLineStyle: ,
                                // isLast: false,
                                // isFirst: true,
                                indicatorStyle: IndicatorStyle(
                                  width: 20,
                                  color: CColors.missonGrey,
                                  // indicator: Text("efdsf"),
                                  // indicatorXY: 0.7,
                                  iconStyle: IconStyle(
                                    color: CColors
                                        .missonNormalWhiteColor,
                                    iconData: Icons.check,
                                  ),
                                ),
                                endChild: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 30),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.end,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Mission Started",
                                        style: TextStyle(
                                            fontSize: ScreenConfig
                                                .fontSizelarge,
                                            fontWeight:
                                            FontWeight.w500,
                                            fontFamily: "Product",
                                            color: CColors
                                                .missonPrimaryColor),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "12:36 PM, Thursday, 32 march",
                                        style: TextStyle(
                                            fontSize: ScreenConfig
                                                .fontSizeMedium,
                                            fontWeight:
                                            FontWeight.w500,
                                            fontFamily: "Product",
                                            color: CColors
                                                .missonMediumGrey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0),
                              child: TimelineTile(
                                alignment: TimelineAlign.start,
                                // afterLineStyle: ,
                                // isLast: false,
                                // isFirst: true,
                                indicatorStyle: IndicatorStyle(
                                  width: 20,
                                  color: CColors.missonGreen,
                                  // indicator: Text("efdsf"),
                                  // indicatorXY: 0.7,
                                  iconStyle: IconStyle(
                                    color: CColors
                                        .missonNormalWhiteColor,
                                    iconData: Icons.check,
                                  ),
                                ),
                                endChild: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 20),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.end,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Mission Accomplished",
                                        style: TextStyle(
                                            fontSize: ScreenConfig
                                                .fontSizelarge,
                                            fontWeight:
                                            FontWeight.w500,
                                            fontFamily: "Product",
                                            color: CColors
                                                .missonPrimaryColor),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "12:36 PM, Thursday, 32 march",
                                        style: TextStyle(
                                            fontSize: ScreenConfig
                                                .fontSizeMedium,
                                            fontWeight:
                                            FontWeight.w500,
                                            fontFamily: "Product",
                                            color: CColors
                                                .missonMediumGrey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0),
                              child: TimelineTile(
                                alignment: TimelineAlign.start,
                                // afterLineStyle: ,
                                isLast: true,
                                // isFirst: true,
                                indicatorStyle: IndicatorStyle(
                                  width: 20,
                                  color: CColors
                                      .missonMediumGrey,
                                  // indicator: Text("efdsf"),
                                  // indicatorXY: 0.7,
                                  iconStyle: IconStyle(
                                    color: CColors
                                        .missonNormalWhiteColor,
                                    iconData: Icons.circle,
                                    fontSize: 17
                                  ),
                                ),
                                endChild: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 20),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.end,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Total Payment",
                                            style: TextStyle(
                                                fontSize: ScreenConfig
                                                    .fontSizelarge,
                                                fontWeight:
                                                FontWeight
                                                    .w500,
                                                fontFamily:
                                                "Product",
                                                color: CColors
                                                    .missonPrimaryColor),
                                          ),
                                          Spacer(),
                                          // Text(
                                          //   "\$ 174.00",
                                          //   style: TextStyle(
                                          //       fontSize: ScreenConfig
                                          //           .fontSizelarge,
                                          //       fontWeight:
                                          //           FontWeight
                                          //               .bold,
                                          //       fontFamily:
                                          //           "Product",
                                          //       color: CColors
                                          //           .missonGreen),
                                          // ),
                                          SizedBox(
                                            width: 20,
                                          )
                                        ],
                                      ),
                                      // SizedBox(
                                      //   height: 10,
                                      // ),
                                      // Text(
                                      //   "View Receipt",
                                      //   style: TextStyle(
                                      //       fontSize: ScreenConfig
                                      //           .fontSizeMedium,
                                      //       fontWeight:
                                      //       FontWeight.bold,
                                      //       fontFamily: "Product",
                                      //       color: Colors.blue),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        )
                      ],
                    )),
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

  Widget bottomView(String status) {
    switch (status) {
      case "pending":
        {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10, left: 30),
                      height: 60,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: CColors.missonNormalWhiteColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: CColors.missonRed, width: 1))),

                          // style: ElevatedButton.styleFrom(primary: CColors.b),
                          onPressed: isJobStatusChanging == true
                              ? null
                              : isJobStatusChanging == true
                                  ? null
                                  : () {
                                      setState(() {
                                        isJobStatusChanging = true;
                                        isDeclineButtonPressed = true;
                                      });
                                      ApiCaller()
                                          .changeJobStatus(
                                              auth: auth,
                                              Id: widget.id,
                                              jobStatus: "rejected")
                                          .then((value) =>
                                              changeJobStatusModel = value)
                                          .whenComplete(() {
                                        setState(() {
                                          isJobStatusChanging = false;

                                          if (isDeclineButtonPressed == true) {
                                            isDeclineButtonPressed = false;
                                            Navigator.pop(context);
                                          }
                                        });

                                        if (changeJobStatusModel.code == 422) {
                                          return showCupertinoDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return CupertinoAlertDialog(
                                                title: Text('Alert'),
                                                content: Text(
                                                    '${changeJobStatusModel.error.message}'),
                                                actions: [
                                                  CupertinoDialogAction(
                                                    child: Text('OK'),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      // NavMe().NavPushReplaceFadeIn(LoginPage());
                                                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> LoginPage()));
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        } else {
                                          return showCupertinoDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return CupertinoAlertDialog(
                                                title: Text('Alert'),
                                                content: Text(
                                                    'Job Decline successfully '),
                                                actions: [
                                                  CupertinoDialogAction(
                                                    child: Text('OK'),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      // NavMe().NavPushReplaceFadeIn(LoginPage());
                                                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> LoginPage()));
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      });
                                    },
                          child: isDeclineButtonPressed == true
                              ? spinkit
                              : Text(
                                  "Decline",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: CColors.missonRed),
                                )),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.only(top: 10, bottom: 10, right: 30),
                      child: ElevatedButton(
                          // style: ElevatedButton.styleFrom(primary: CColors.b),
                          //   onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              primary: CColors.missonGreen,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: CColors.missonGreen, width: 1))),

                          // style: ElevatedButton.styleFrom(primary: CColors.b),
                          onPressed: () {
                            setState(() {
                              isJobStatusChanging = true;
                              isAcceptButtonPressed = true;
                            });
                            ApiCaller()
                                .changeJobStatus(
                                    auth: auth,
                                    Id: widget.id,
                                    jobStatus: "accepted")
                                .then((value) => changeJobStatusModel = value)
                                .whenComplete(() {
                              setState(() {
                                isJobStatusChanging = false;
                                isAcceptButtonPressed = false;
                              });

                              if (changeJobStatusModel.code == 422) {
                                return showCupertinoDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CupertinoAlertDialog(
                                      title: Text('Alert'),
                                      content: Text(
                                          '${changeJobStatusModel.error.message}'),
                                      actions: [
                                        CupertinoDialogAction(
                                          child: Text('OK'),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            // NavMe().NavPushReplaceFadeIn(LoginPage());
                                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> LoginPage()));
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                return showCupertinoDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CupertinoAlertDialog(
                                      title: Text('Alert'),
                                      content: Text(
                                          '${changeJobStatusModel.data.message}'),
                                      actions: [
                                        CupertinoDialogAction(
                                          child: Text('OK'),
                                          onPressed: () {
                                            Navigator.pop(context);

                                            setState(() {
                                              viewValue = "accepted";
                                            });
                                            // NavMe().NavPushReplaceFadeIn(LoginPage());
                                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> LoginPage()));
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            });
                          },
                          child: isAcceptButtonPressed == true
                              ? spinkit
                              : Text(
                                  "Accept",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          );
          // statements;
        }
        break;

      case "accepted":
        {
          return Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    currentCaseStatus = 2;
                  });
                },
                child: Container(
                  color: CColors.missonNormalWhiteColor,
                  width: 70,
                  height: 100,
                  child: SvgPicture.asset(tickLogo),
                ),
              ),
              Expanded(
                child: Container(
                  height: 100,
                  color: CColors.missonPrimaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Spacer(),
                        Text(
                          "Response successfully sent to Assigner.",
                          style: TextStyle(
                              fontSize: ScreenConfig.fontSizelarge,
                              fontWeight: FontWeight.w400,
                              color: CColors.missonNormalWhiteColor),
                        ),
                        Spacer(),
                        Text(
                          "Ready for your mission, we will redirect request",
                          style: TextStyle(
                              fontSize: ScreenConfig.fontSizeSmall,
                              fontWeight: FontWeight.w400,
                              color: CColors.missonNormalWhiteColor),
                        ),
                        Spacer()
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        }
        break;
      case "rejected":
        {
          return Container(
            width: ScreenConfig.screenWidth,
            height: 100,
            color: CColors.missonPrimaryColor,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    Text(
                      "Response successfully sent to Assigner.",
                      style: TextStyle(
                          fontSize: ScreenConfig.fontSizelarge,
                          fontWeight: FontWeight.w400,
                          color: CColors.missonNormalWhiteColor),
                    ),
                    Spacer(),
                    Text(
                      "You have Decline the mission request",
                      style: TextStyle(
                          fontSize: ScreenConfig.fontSizeSmall,
                          fontWeight: FontWeight.w400,
                          color: CColors.missonNormalWhiteColor),
                    ),
                    Spacer()
                  ],
                ),
              ),
            ),
          );
        }
        break;

      default:
        {
          return Container();
        }
        break;
    }
  }

  Widget showScannerState(String status) {
    switch (status) {
      case "isClose":
        {
          // statements;

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Scan to start a job",
                        style: TextStyle(
                            color: CColors.missonNormalWhiteColor,
                            fontSize: ScreenConfig.fontSizelarge,
                            fontFamily: "Product"),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Mission start schedule",
                        style: TextStyle(
                            color: CColors.missonNormalWhiteColor,
                            fontSize: ScreenConfig.fontSizeXSmall,
                            fontFamily: "Product"),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        // "28/04/2021, 2:00 PM",
                        "${getJobByIdModel.data.startDate.toString().split(" ").elementAt(0)}, ${getJobByIdModel.data.startTime.toString().split(":").elementAt(0)}: ${getJobByIdModel.data.startTime.toString().split(":").elementAt(1)}",
                        style: TextStyle(
                            color: CColors.missonNormalWhiteColor,
                            fontSize: ScreenConfig.fontSizeMedium,
                            fontFamily: "Product"),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Spacer(),
                  SvgPicture.asset(
                    qrScanSmall,
                    height: 130,
                  )
                ],
              ),
            ),
          );
        }
        break;

      case "isOpen":
        {
          //statements;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Spacer(),
                      InkWell(
                          onTap: () {
                            _panelController.close();
                          },
                          child: SvgPicture.asset(crossLogo))
                    ],
                  ),
                ),
                Text(
                  "SCAN QR CODE",
                  style: TextStyle(
                      color: CColors.missonNormalWhiteColor,
                      fontSize: ScreenConfig.fontSizeXhlarge,
                      fontFamily: "Product"),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "To start mission you have to scan\nassigner's code",
                  style: TextStyle(
                      color: CColors.missonNormalWhiteColor,
                      fontSize: ScreenConfig.fontSizeMedium,
                      fontFamily: "Product",
                      fontWeight: FontWeight.w100),
                  textAlign: TextAlign.center,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: ScreenConfig.screenHeight * 0.05,
                ),
                Stack(
                  children: [
                    SvgPicture.asset(
                      qrBorderLogo,
                      height: ScreenConfig.screenHeight * 0.45,
                    ),
                    Align(
                      child: Container(
                        margin: EdgeInsets.only(
                            top: ScreenConfig.screenHeight * 0.04),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        height: 300,
                        width: 300,
                        child: QRView(
                          key: qrKey,
                          onQRViewCreated: _onQRViewCreated,
                        ),
                      ),
                      alignment: Alignment.center,
                    )

                    // Positioned(
                    //   left:ScreenConfig.screenWidth*0.09,
                    //   top: ScreenConfig.screenWidth*0.12,
                    //   child:
                    // )
                  ],
                )
              ],
            ),
          );
        }
        break;

      default:
        {
          return Container();
        }
        break;
    }
  }

  Widget showTimerState(String status) {
    switch (status) {
      case "isActive":
        {
          _countDownTimerController.start();
          // statements;

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
                child: Column(
              children: [
                Container(
                  width: 200,
                  height: 75,
                  child: Center(
                    // child: Text(
                    //   "00:02:23",
                    //   textAlign: TextAlign.left,
                    //   style: TextStyle(
                    //     fontSize: ScreenConfig.fontSizeXXXlarge,
                    //       fontWeight: FontWeight.bold,
                    //       fontFamily: "Product",
                    //       color: CColors.missonPrimaryColor),
                    // ),
                    child: CountdownTimer(
                      endTime: endTime,
                      controller: _countDownTimerController,
                      endWidget: Text(
                        "00:00:00",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: ScreenConfig.fontSizeXXXlarge,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Product",
                            color: CColors.missonLightGrey),
                      ),
                      textStyle: TextStyle(
                          fontSize: ScreenConfig.fontSizeXXXlarge,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Product",
                          color: CColors.missonPrimaryColor),
                      onEnd: onEnd,
                    ),
                  ),
                  // color: CColors.missonNormalWhiteColor,
                  decoration: BoxDecoration(
                      color: CColors.missonNormalWhiteColor,
                      borderRadius: BorderRadius.circular(20)),
                ),
                Container(
                  width: ScreenConfig.screenWidth * 0.8,
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                                color: CColors.missonNormalWhiteColor)),
                        primary: CColors.missonPrimaryColor),

                    // style: ElevatedButton.styleFrom(primary: CColors.b),
                    //   onPressed: () {},
                    onPressed: () {
                      // _countDownTimerController.dispose();
                      onEnd();
                      _countDownTimerController.disposeTimer();

                      return showCupertinoDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoAlertDialog(
                            title: Text('Alert'),
                            content: Text('Do you want to finish mission ?'),
                            actions: [

                              CupertinoDialogAction(
                                child: showDialogLoader == false
                                    ? Text('Yes')
                                    : spinkit,
                                onPressed: () {
                                  // _countDownTimerController.endTime(0)
                                  ApiCaller()
                                      .changeJobStatus(
                                          auth: auth,
                                          // Id: result.code,
                                          Id: getJobByIdModel.data.id
                                              .toString(),
                                          jobStatus: "completed")
                                      .then((value) =>
                                          changeJobStatusModel = value)
                                      .whenComplete(() {

                                    setState(() {
                                      showDialogLoader = false;

                                      Navigator.pop(context);
                                    });
                                  });

                                  // NavMe().NavPushReplaceFadeIn(LoginPage());
                                },
                              ),
                              CupertinoDialogAction(
                                child: Text('No'),
                                onPressed: () {

                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      "Finish Mission",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: "Product",
                          color: CColors.missonNormalWhiteColor),
                    ),
                  ),
                ),
              ],
            )),
          );
        }
        break;

      default:
        {
          return Container();
        }
        break;
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;

        print("HHHHH ${result.code}");

        if (result.code != null && result.code != "") {
          controller.stopCamera();
          showCupertinoDialog(
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: Text('Job code scanned'),
                content: Text('${result.code}'),
                actions: [
                  CupertinoDialogAction(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.pop(context);

                      ApiCaller()
                          .changeJobStatus(
                              auth: auth,
                              Id: result.code,
                              jobStatus: "processing")
                          .then((value) => changeJobStatusModel = value)
                          .whenComplete(() {
                        // setState(() {
                        //   isJobStatusChanging = false;
                        //   isAcceptButtonPressed = false;
                        // });

                        if (changeJobStatusModel.code == 422) {
                          return showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: Text('Alert'),
                                content: Text(
                                    '${changeJobStatusModel.error.message}'),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      // NavMe().NavPushReplaceFadeIn(LoginPage());
                                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> LoginPage()));
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          currentCaseStatus = 3;
                          _panelController.close();
                        }
                      });
                    },
                  ),
                ],
              );
            },
          );
          // currentCaseStatus = 3;
        }
      });
    }, onDone: () {
      _panelController.close();
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
