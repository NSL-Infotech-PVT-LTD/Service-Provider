import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';
import 'package:misson_tasker/utils/StringsPath.dart';

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
        backgroundColor: Colors.white,
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
      body: Container(
          width: ScreenConfig.screenWidth,
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
                child: Text(
                  "Shop groceries for me",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                title: Text("Mission details"),
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
                                child: SvgPicture.asset(personTextFiledIcon),
                              ),
                              suffix: Text("Task Required"),
                            ),
                          ),
                          SizedBox(
                            height: ScreenConfig.widgetPaddingMedium,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(locationTextFiledIcon),
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
                                child: SvgPicture.asset(calanderTextFiledIcon),
                              ),

                            ),
                          ),
                          SizedBox(
                            height: ScreenConfig.widgetPaddingMedium,
                          ), TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(timeTextFiledIcon),
                              ),

                            ),
                          ),
                          SizedBox(
                            height: ScreenConfig.widgetPaddingMedium,
                          ), TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(moneyTextFiledIcon),
                              ),

                            ),
                          ),
                          SizedBox(
                            height: ScreenConfig.widgetPaddingMedium,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
