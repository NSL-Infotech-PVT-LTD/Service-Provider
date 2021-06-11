import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';
import 'package:misson_tasker/utils/StringsPath.dart';

// class CustomAppBar extends StatefulWidget {
//   final String titleHeading;
//   final String titleSubHeading;
//   final Widget leftSideIconSvg;
//   final Widget rightSideIconSvg;
//   final List<Widget> tabBarList;
//   final Function leftHandSideOnTap;
//   final Function rightHandSideOnTap;
//
//   const CustomAppBar({Key key,
//     this.titleHeading,
//     this.titleSubHeading,
//     this.leftSideIconSvg,
//     this.rightSideIconSvg,
//     this.tabBarList,
//     this.leftHandSideOnTap,
//     this.rightHandSideOnTap})
//       : super(key: key);
//
//   @override
//   _CustomAppBarState createState() => _CustomAppBarState();
// }
//
// class _CustomAppBarState extends State<CustomAppBar> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

Widget myCustomAppBar(
    {String titleHeading,
    String titleSubHeading,
    Widget leftSideIconSvg,
    Widget rightSideIconSvg,
    TabController tabController,
    List<Widget> tabBarList,
    // Function leftHandSideOnTap,
    Function rightHandSideOnTap,
    GlobalKey<ScaffoldState> drawerKey}) {
  return AppBar(
    bottom: TabBar(
        enableFeedback: true,
        automaticIndicatorColorAdjustment: true,
        controller: tabController,
        labelPadding: EdgeInsets.symmetric(vertical: 2),
        labelColor: CColors.textColor,
        indicatorColor: CColors.missonPrimaryColor,
        unselectedLabelColor: CColors.missonMediumGrey,
        unselectedLabelStyle: TextStyle(
            fontSize: ScreenConfig.fontSizeMedium,
            color: CColors.backgroundRed,
            fontWeight: FontWeight.w100,
            fontFamily: "Product"),
        labelStyle: TextStyle(
            fontSize: ScreenConfig.fontSizeMedium,
            color: CColors.textColor,
            fontWeight: FontWeight.w100,
            fontFamily: "Product"),
        tabs: tabBarList),
    elevation: 0,
    toolbarHeight: 160,
    backgroundColor: CColors.missonNormalWhiteColor,
    leadingWidth: 0,
    centerTitle: true,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  drawerKey.currentState.openDrawer();
                },
                child: leftSideIconSvg),
            Text(
              "$titleHeading",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: ScreenConfig.fontSizeXhlarge,
                  color: CColors.textColor,
                  fontWeight: FontWeight.w100,
                  fontFamily: "Product"),
            ),
            InkWell(onTap: rightHandSideOnTap, child: rightSideIconSvg)
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "$titleSubHeading",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: ScreenConfig.fontSizeMedium,
              color: CColors.textColor,
              fontWeight: FontWeight.w100,
              fontFamily: "Product"),
        ),
      ],
    ),
  );
}
