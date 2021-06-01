import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:misson_tasker/model/ApiCaller.dart';
import 'package:misson_tasker/model/api_models/GetProfileDataModel.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/NavMe.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';
import 'package:misson_tasker/utils/StringsPath.dart';
import 'package:misson_tasker/utils/local_data.dart';
import 'package:misson_tasker/view/JobFlowScreen/MissionProcessScreen.dart';
import 'package:misson_tasker/view/ProfileView/BusinessDetails.dart';
import 'package:misson_tasker/view/ProfileView/NotificationScreen.dart';
import 'package:misson_tasker/view/ProfileView/SettingPage.dart';
import 'package:misson_tasker/view/ProfileView/SubscriptionScreen.dart';
import 'package:misson_tasker/view/ProfileView/UserProfile.dart';
import 'package:misson_tasker/view/startup_screens/SplashScreen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MissionReviewScreen extends StatefulWidget {
  @override
  _MissionReviewScreenState createState() => _MissionReviewScreenState();
}

class _MissionReviewScreenState extends State<MissionReviewScreen> {
  final _formKey = GlobalKey<FormState>();
  PanelController _panelController = PanelController();
  final children = <Widget>[];
  double _currentSliderValue = 3.5;
  String isShowPositive = "";
  bool isDescendingIsPressed = true;

  DateTime selectedDate = DateTime.now();

  _selectFilterDate(BuildContext context) async {
    final DateTime filterTime = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (filterTime != null) {
      setState(() {
        selectedDate = filterTime;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var i = 6; i < 11; i++) {
      children.add(Text(
        "${i / 2}",
        style: TextStyle(
            fontSize: ScreenConfig.fontSizeMedium,
            color: CColors.missonPrimaryColor,
            fontFamily: "Product"),
      ));
    }
  }

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
              "Customers Reviews",
              style: TextStyle(
                  color: CColors.missonNormalGrey,
                  fontSize: ScreenConfig.fontSizelarge,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Product"),
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
        body: SlidingUpPanel(
          controller: _panelController,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
          body: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RatingBar.builder(
                            initialRating: 3,
                            glow: false,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                            unratedColor: CColors.missonLightGrey,
                            itemBuilder: (context, _) => Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 20.0),
                            child: Text(
                              "Global Ratting",
                              style: TextStyle(
                                  color: CColors.missonMediumGrey,
                                  fontSize: ScreenConfig.fontSizeMedium,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Product"),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "5 star",
                            style: TextStyle(
                                color: Colors.blue.shade800,
                                fontSize: ScreenConfig.fontSizeMedium,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Product"),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              width: ScreenConfig.screenWidth * 0.65,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: LinearProgressIndicator(
                                  minHeight: 40,
                                  value: 0.85,
                                  backgroundColor: CColors.missonLightGrey,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      CColors.missonYellow),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "85%",
                            style: TextStyle(
                                color: Colors.blue.shade800,
                                fontSize: ScreenConfig.fontSizeMedium,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Product"),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "4 star",
                            style: TextStyle(
                                color: Colors.blue.shade800,
                                fontSize: ScreenConfig.fontSizeMedium,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Product"),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              width: ScreenConfig.screenWidth * 0.65,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: LinearProgressIndicator(
                                  minHeight: 40,
                                  value: 0.70,
                                  backgroundColor: CColors.missonLightGrey,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      CColors.missonYellow),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "70%",
                            style: TextStyle(
                                color: Colors.blue.shade800,
                                fontSize: ScreenConfig.fontSizeMedium,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Product"),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "3 star",
                            style: TextStyle(
                                color: Colors.blue.shade800,
                                fontSize: ScreenConfig.fontSizeMedium,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Product"),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              width: ScreenConfig.screenWidth * 0.65,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: LinearProgressIndicator(
                                  minHeight: 40,
                                  value: 0.50,
                                  backgroundColor: CColors.missonLightGrey,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      CColors.missonYellow),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "50%",
                            style: TextStyle(
                                color: Colors.blue.shade800,
                                fontSize: ScreenConfig.fontSizeMedium,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Product"),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "2 star",
                            style: TextStyle(
                                color: Colors.blue.shade800,
                                fontSize: ScreenConfig.fontSizeMedium,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Product"),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              width: ScreenConfig.screenWidth * 0.65,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: LinearProgressIndicator(
                                  minHeight: 40,
                                  value: 0.20,
                                  backgroundColor: CColors.missonLightGrey,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      CColors.missonYellow),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "20%",
                            style: TextStyle(
                                color: Colors.blue.shade800,
                                fontSize: ScreenConfig.fontSizeMedium,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Product"),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "1 star",
                            style: TextStyle(
                                color: Colors.blue.shade800,
                                fontSize: ScreenConfig.fontSizeMedium,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Product"),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              width: ScreenConfig.screenWidth * 0.65,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: LinearProgressIndicator(
                                  minHeight: 40,
                                  value: 0.10,
                                  backgroundColor: CColors.missonLightGrey,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      CColors.missonYellow),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "10%",
                            style: TextStyle(
                                color: Colors.blue.shade800,
                                fontSize: ScreenConfig.fontSizeMedium,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Product"),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Reviews By Customers",
                            style: TextStyle(
                                color: Colors.blue.shade800,
                                fontSize: ScreenConfig.fontSizelarge,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Product"),
                          ),
                          InkWell(
                              onTap: () {
                                _panelController.open();
                              },
                              child: Icon(Icons.account_tree_rounded))
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return feedbackCard();
                      },
                      itemCount: 15,
                    )
                  ],
                ),
              ),
            ],
          ),
          panel: panelView(),
          maxHeight: ScreenConfig.screenHeight * 0.88,
          minHeight: 0,
        ));
  }

  Widget feedbackCard() {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              child: Image.asset(avatar1),
              radius: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Georgiana Xiong",
                style: TextStyle(
                    color: CColors.missonPrimaryColor,
                    fontSize: ScreenConfig.fontSizelarge,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Product"),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "sdfdsijsdljdsflds;dsj;ldsj;dsjfdjf;ldjdfjl;jdf;lsdlkdsndlfjsd;lsdj;sldjfsdlfjsdl;jsd;fdsj;fjds;fj;lsdlf;sdjm;ldsjsdlfd",
                style: TextStyle(
                    letterSpacing: 1,
                    color: CColors.missonPrimaryColor,
                    fontSize: ScreenConfig.fontSizeMedium,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Product"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: RatingBar.builder(
                  ignoreGestures: true,
                  initialRating: 3,
                  itemSize: 25,
                  glow: false,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                  unratedColor: CColors.missonLightGrey,
                  itemBuilder: (context, _) => Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
              // border: Border.all(),
              borderRadius: BorderRadius.circular(15),
              color: CColors.backgroundRed),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "02:30 PM, Thursday, 23 march",
              style: TextStyle(
                  color: CColors.missonMediumGrey,
                  fontSize: ScreenConfig.fontSizeSmall,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Product"),
            ),
          ],
        )
      ],
    );
  }

  Widget panelView() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    _panelController.close();
                  },
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 24.0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Filter reviews",
                style: TextStyle(
                    color: CColors.missonPrimaryColor,
                    fontSize: ScreenConfig.fontSizeXhlarge,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Product"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "By name",
                    style: TextStyle(
                        color: CColors.missonPrimaryColor,
                        fontSize: ScreenConfig.fontSizelarge,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Product"),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: isDescendingIsPressed == true
                                  ? Colors.blue
                                  : CColors.missonNormalWhiteColor,
                              onPrimary: isDescendingIsPressed == true
                                  ? CColors.missonNormalWhiteColor
                                  : CColors.missonPrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                // side: BorderSide(color: Colors.)
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 20)),
                          onPressed: () {
                            setState(() {
                              isDescendingIsPressed = true;
                            });
                          },
                          child: Text(
                            "Descending",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              onPrimary: isDescendingIsPressed == true
                                  ? CColors.missonPrimaryColor
                                  : CColors.missonNormalWhiteColor,
                              primary: isDescendingIsPressed == true
                                  ? CColors.missonNormalWhiteColor
                                  : Colors.blue,
                              // textStyle: TextStyle(color: CColors.missonPrimaryColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                // side: BorderSide(color: Colors.)
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 20)),
                          onPressed: () {
                            setState(() {
                              isDescendingIsPressed = false;
                            });
                          },
                          child: Text(
                            "Ascending",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "By date",
                    style: TextStyle(
                        color: CColors.missonPrimaryColor,
                        fontSize: ScreenConfig.fontSizelarge,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Product"),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.maxFinite,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: CColors.missonNormalWhiteColor,
                            onPrimary: CColors.missonPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              // side: BorderSide(color: Colors.)
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20)),
                        onPressed: () {
                          _selectFilterDate(context);
                          print("$selectedDate");
                        },
                        child: Row(
                          children: [
                            Text(
                              "${DateFormat.yMd().format(selectedDate)}",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rating",
                    style: TextStyle(
                        color: CColors.missonPrimaryColor,
                        fontSize: ScreenConfig.fontSizelarge,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Product"),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    // width: double.maxFinite,
                    // color: Colors.redAccent,
                    child: Column(
                      children: [
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Colors.blue,
                            inactiveTrackColor: CColors.missonLightGrey,
                            trackShape: RoundedRectSliderTrackShape(),
                            // trackShape: RectangularSliderTrackShape(),
                            trackHeight: 15.0,
                            thumbShape: RoundSliderThumbShape(
                                enabledThumbRadius: 12.0, elevation: 10),
                            thumbColor: Colors.white,
                            overlayColor: Colors.blue,
                            overlayShape:
                                RoundSliderOverlayShape(overlayRadius: 24.0),
                            tickMarkShape: RoundSliderTickMarkShape(),
                            activeTickMarkColor: Colors.white,
                            inactiveTickMarkColor: CColors.missonMediumGrey,
                            valueIndicatorShape:
                                PaddleSliderValueIndicatorShape(),
                            valueIndicatorColor: Colors.blue,
                            valueIndicatorTextStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          child: Slider(
                            value: _currentSliderValue,
                            min: 3,
                            max: 5,
                            divisions: 4,
                            label: _currentSliderValue.toString(),
                            onChanged: (double value) {
                              setState(() {
                                _currentSliderValue = value;
                                print("$value");
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: children),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    horizontalTitleGap: 0,
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      "Positive reviews",
                      style: TextStyle(
                          fontSize: ScreenConfig.fontSizeXlarge,
                          color: CColors.missonPrimaryColor,
                          fontFamily: "Product"),
                    ),
                    subtitle: Text(
                      "Filter taskers according to positive reviews",
                      style: TextStyle(
                          fontSize: ScreenConfig.fontSizeMedium,
                          color: CColors.missonMediumGrey,
                          fontFamily: "Product",
                          fontWeight: FontWeight.w100),
                    ),
                    leading: Radio<String>(
                      value: "showPositiveReviews",
                      groupValue: isShowPositive,
                      onChanged: (value) {
                        setState(() {
                          isShowPositive == "$value"
                              ? isShowPositive = ""
                              : isShowPositive = "$value";
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.maxFinite,
              height: 60,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: CColors.missonPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      // side: BorderSide(color: Colors.)
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Apply",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
