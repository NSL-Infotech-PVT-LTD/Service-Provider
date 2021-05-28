import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:misson_tasker/model/ApiCaller.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';
import 'package:misson_tasker/utils/StringsPath.dart';
import 'package:misson_tasker/utils/local_data.dart';
import 'package:misson_tasker/view/startup_screens/SplashScreen.dart';

import 'package:misson_tasker/view/startup_screens/SplashScreen.dart';
import 'package:misson_tasker/model/api_models/GetJobByIdModel.dart';
import 'package:misson_tasker/model/api_models/ChnageJobStatusModel.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MissionProcessScreen extends StatefulWidget {
  final String id;

  const MissionProcessScreen({Key key, this.id}) : super(key: key);

  @override
  _MissionProcessScreenState createState() => _MissionProcessScreenState();
}

class _MissionProcessScreenState extends State<MissionProcessScreen> {
  // bool isLoading = true;
  String _fullName = "Loading....";
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
        });
      });
    });
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              // NavMe().NavPushLeftToRight(NotificationScreen());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 18.0, top: 30.0),
              child: Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset(optionLogo)),
            ),
          ),
        ],
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 30.0),
          child: Text(
            "Mission",
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
                  margin:
                      EdgeInsets.only(top: ScreenConfig.screenHeight * 0.05),
                  color: Colors.white,
                  child: Container(
                    height: ScreenConfig.screenHeight,
                    child: Stack(
                      children: [
                        SingleChildScrollView(
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
                                      crossAxisAlignment: CrossAxisAlignment.center,
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
                                          height: ScreenConfig.screenHeight * 0.01,
                                        ),
                                        Text(
                                          "Posted on ${DateFormat.MMMMd().add_jm().format(DateTime.parse(getJobByIdModel.data.createdAt).toLocal())}",
                                          style: TextStyle(
                                            color: CColors.missonMediumGrey,
                                            fontSize: ScreenConfig.fontSizeSmall,
                                          ),
                                        ),
                                        SizedBox(
                                          height: ScreenConfig.screenHeight * 0.02,
                                        ),
                                        Text(
                                          "Job Reference number",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: ScreenConfig.fontSizeSmall,
                                          ),
                                        ),
                                        SizedBox(
                                          height: ScreenConfig.screenHeight * 0.02,
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
                              ExpansionTile(
                                tilePadding: EdgeInsets.symmetric(horizontal: 10),
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
                                          child:
                                              SvgPicture.asset(timeTextFiledIcon),
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
                                                    fontSize:
                                                        ScreenConfig.fontSizelarge,
                                                    fontWeight: FontWeight.w300,
                                                    color:
                                                        CColors.missonMediumGrey),
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
                                                    fontSize:
                                                        ScreenConfig.fontSizelarge,
                                                    fontWeight: FontWeight.w300,
                                                    color:
                                                        CColors.missonMediumGrey),
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
                                ],
                              ),
                              ExpansionTile(
                                tilePadding: EdgeInsets.symmetric(horizontal: 10),
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
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 8.0),
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
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Advance pay",
                                              style: TextStyle(
                                                  fontSize:
                                                      ScreenConfig.fontSizelarge,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Product",
                                                  color:
                                                      CColors.missonPrimaryColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 8.0),
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
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Mission Started",
                                              style: TextStyle(
                                                  fontSize:
                                                      ScreenConfig.fontSizelarge,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Product",
                                                  color:
                                                      CColors.missonPrimaryColor),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "12:36 PM, Thursday, 32 march",
                                              style: TextStyle(
                                                  fontSize:
                                                      ScreenConfig.fontSizeMedium,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Product",
                                                  color: CColors.missonMediumGrey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 8.0),
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
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Mission Accomplished",
                                              style: TextStyle(
                                                  fontSize:
                                                      ScreenConfig.fontSizelarge,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Product",
                                                  color:
                                                      CColors.missonPrimaryColor),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "12:36 PM, Thursday, 32 march",
                                              style: TextStyle(
                                                  fontSize:
                                                      ScreenConfig.fontSizeMedium,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Product",
                                                  color: CColors.missonMediumGrey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 8.0),
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
                                          mainAxisAlignment: MainAxisAlignment.end,
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
                                                      fontWeight: FontWeight.w500,
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
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: "Product",
                                                      color: CColors.missonGreen),
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
                                                  fontSize:
                                                      ScreenConfig.fontSizeMedium,
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
                              ExpansionTile(
                                tilePadding: EdgeInsets.symmetric(horizontal: 10),
                                title: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Mission Reviews",
                                      style: TextStyle(
                                          fontSize: ScreenConfig.fontSizelarge,
                                          fontWeight: FontWeight.w300,
                                          color: CColors.missonPrimaryColor),
                                    ),
                                  ],
                                ),
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Assigner reviews will be shown here ",
                                        style: TextStyle(
                                            fontSize: ScreenConfig.fontSizelarge,
                                            fontWeight: FontWeight.w300,
                                            color: CColors.missonPrimaryColor),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Send request for reviews",
                                        style: TextStyle(
                                            fontSize: ScreenConfig.fontSizelarge,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 120,)

                            ],
                          ),
                        ),
                        Align(child:     AnimatedSwitcher(
                          duration: Duration(milliseconds: 400),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return ScaleTransition(
                                child: child, scale: animation);
                          },
                          child: bottomView(viewValue),
                        ),
                        alignment: Alignment.bottomCenter,
                        )
                      ],
                    ),
                  )),
            ),
    );
  }

  int _index = 0;

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
                                          isDeclineButtonPressed = false;
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
              Container(
                color: CColors.missonNormalWhiteColor,
                width: 70,
                height: 100,
                child: SvgPicture.asset(tickLogo),
              ),
              Expanded(
                child: Container(
                  height: 100,
                  color: CColors.missonGrey,
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

      default:
        {
          return Container();
        }
        break;
    }
  }
}
