import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';
import 'package:misson_tasker/utils/StringsPath.dart';

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
      )),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.green,//CColors.missonNormalWhiteColor,

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
        currentIndex:0,
        iconSize: 25,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.amber[800],
        onTap: (value) {},
      ),
    );
  }
}
