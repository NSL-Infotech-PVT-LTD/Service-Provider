import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';
import 'package:misson_tasker/utils/StringsPath.dart';
import 'package:misson_tasker/utils/local_data.dart';
import 'package:misson_tasker/view/startup_screens/SplashScreen.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {





    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CColors.missonNormalWhiteColor,
        titleSpacing: -1.0,
        leading: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SvgPicture.asset(drawerIcon),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Delivery",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: ScreenConfig.fontSizeSmall,
                  color: CColors.textColor),
            ),
            Text(
              "B-52 Technobuilding, Sec-53, Noida",
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
            child: CircleAvatar(
              backgroundImage: AssetImage(avatar1),
            ),
          )
        ],
      ),
      body: SafeArea(
          child: Container(
        color: CColors.missonNormalWhiteColor,
        child: currentView(1),
      )),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.green,
        //CColors.missonNormalWhiteColor,

        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              backgroundColor: CColors.missonNormalWhiteColor,
              icon: SvgPicture.asset(
                navbarHomeDeactive,
                height: 20,
              ),
              activeIcon: SvgPicture.asset(
                navbarHomeActive,
                height: 20,
              ),
              label: " "),
          BottomNavigationBarItem(
            backgroundColor: CColors.missonNormalWhiteColor,
            icon: SvgPicture.asset(navbarExploerDeactive),
            activeIcon: SvgPicture.asset(navbarExplorerActive),
            label: ' ',
          ),
          BottomNavigationBarItem(
            backgroundColor: CColors.missonNormalWhiteColor,
            icon: SvgPicture.asset(navbarChatDeactive),
            activeIcon: SvgPicture.asset(navbarChatActive),
            label: ' ',
          ),
          BottomNavigationBarItem(
            backgroundColor: CColors.missonNormalWhiteColor,
            icon: SvgPicture.asset(navbarClockDeactive),
            activeIcon: SvgPicture.asset(navbarClockActive),
            label: ' ',
          ),
        ],
        currentIndex: 0,
        iconSize: 25,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.amber[800],
        onTap: (value) {},
      ),
    );
  }

  Widget currentView(int state) {
    switch (state) {
      case 0:
        {
          return Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
          );
          // statements;
        }
        break;

      case 1:
        {
          return Padding(
            padding: const EdgeInsets.only(top: 16.0, right: 16.0),
            child: Column(
              children: [
                ListTile(
                  dense: true,

                  title: Row(
                    children: [
                      Text(
                        "Mission Request",
                        style: TextStyle(fontSize: ScreenConfig.fontSizeMedium),
                      ),
                      Spacer(),
                      Text(
                        "View All",
                        style: TextStyle(fontSize: ScreenConfig.fontSizeSmall),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    "Costumer waiting for your response.",
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

                  width: ScreenConfig.screenWidth,
                  color: CColors.backgroundRed,
                  // child: ListView.builder(itemBuilder: (context, index){
                  //   return Padding(
                  //     padding: const EdgeInsets.all(10.0),
                  //     child: customTile(
                  //         heading: "Shop groceries for me",
                  //         subheading: "12:32 PM, Thursday, 23 march",
                  //         lines: "Mission details",
                  //     bottomLineColor: CColors.missonRed,
                  //     tileColor: CColors.missonNormalWhiteColor),
                  //   );
                  // }, itemCount: 4,scrollDirection: Axis.horizontal,)
                ),

              ],
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

  Widget customTile({String heading, String subheading, String lines, Color bottomLineColor, Color tileColor}) {
    return Container(
      width: ScreenConfig.screenWidth*0.70,
      color: tileColor,
      child: Padding(
        padding: const EdgeInsets.
          symmetric(horizontal:8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0, vertical:16.0),
              child: Text(
                heading,
                style: TextStyle(fontSize: ScreenConfig.fontSizeXlarge),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
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
            Container(color:bottomLineColor,height: 2.5,)


          ],
        ),
      ),
    );
  }
}
