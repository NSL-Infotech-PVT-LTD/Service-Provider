import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';
import 'package:misson_tasker/utils/StringsPath.dart';

import '../utils/ScreenConfig.dart';

class JobDetailsScreen extends StatefulWidget {
  @override
  _JobDetailsScreenState createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_rounded,
          color: Colors.black,
          size: 30,
        ),
        backgroundColor: CColors.missonNormalWhiteColor,
        elevation: 0,
        toolbarHeight: 70,
        title: Row(
          children: [
            Spacer(),
            Text(
              "Mission Request",
              style: TextStyle(
                  color: Colors.black, fontFamily: "Product_Sans_Regular"),
            ),
            Spacer()
          ],
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 30),
              child: SvgPicture.asset(
                "assets/svg_assets/appbar_option.svg",
                height: 20,
              ))
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
                width: ScreenConfig.screenWidth,
                color: CColors.missonNormalWhiteColor,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
                      child: Text(
                        "Shop groceries for me",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "Posted on 18/04/2021 , 02:34 PM",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                      child: Text(
                        "Job Reference number",
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                    Text(
                      " #7621189  ",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          backgroundColor: CColors.missonLightGrey),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    ExpansionTile(
                   
                      title: Text(
                        "Mission details",
                        style: TextStyle(color: CColors.missonGrey),

                      ),
                      expandedAlignment: Alignment.topLeft,
                      children: [
                        Form(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgPicture.asset(
                                            personTextFiledIcon),
                                      ),
                                      suffixIcon: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 15.0),
                                        child: Text(
                                          "Task Required",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: CColors.missonXLightGrey),
                                        ),
                                      ),
                                      hintTextDirection: TextDirection.rtl),
                                ),
                                SizedBox(
                                  height: ScreenConfig.widgetPaddingMedium,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                          locationTextFiledIcon),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenConfig.widgetPaddingMedium,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                          calanderTextFiledIcon),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenConfig.widgetPaddingMedium,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          SvgPicture.asset(timeTextFiledIcon),
                                    ),
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Text(
                                        "Hrs",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: CColors.missonXLightGrey),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenConfig.widgetPaddingMedium,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          SvgPicture.asset(moneyTextFiledIcon),
                                    ),
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Text(
                                        "\$/hr",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: CColors.missonXLightGrey),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenConfig.widgetPaddingLarge,
                                ),
                                Row(
                                  children: [Text("Description"), Spacer()],
                                ),
                                SizedBox(
                                  height: ScreenConfig.widgetPaddingXSmall,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "Description",
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                    ),
                                    maxLines: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 80,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: CColors.missonNormalWhiteColor,
                      child: Center(
                        child:
                            SvgPicture.asset("assets/svg_assets/tick_svg.svg"),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      color: CColors.missonPrimaryColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 10),
                            child: Text(
                              "Response successfully sent to Assigner.",
                              style: TextStyle(
                                  fontSize: ScreenConfig.fontSizelarge,
                                  color: CColors.missonNormalWhiteColor),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 10),
                            child: Text(
                              "Ready for your mission, we will redirect request",
                              style: TextStyle(
                                  fontSize: ScreenConfig.fontSizeSmall,
                                  color: CColors.missonNormalWhiteColor),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
