import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/NavMe.dart';
import 'package:misson_tasker/utils/StringsPath.dart';
import 'package:misson_tasker/utils/local_data.dart';
import 'package:misson_tasker/view/startup_screens/LoginPage.dart';
import 'package:misson_tasker/view/startup_screens/SplashScreen.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,

      children: <Widget>[
        DrawerHeader(
          child: Center(
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(avatar1),
                      radius: 50,
                    )),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("NAME"),
                      Text("tasker"),
                      Text("edit profile")
                    ],
                  ),
                )
              ],
            ),
          ),
          decoration: BoxDecoration(
            color: CColors.missonPrimaryColor,
          ),
        ),
        ListTile(
          title: Text('LOGOUT'),
          onTap: () {
            return showCupertinoDialog(
              context: context,
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  title: Text('Alert'),
                  content: Text('Do you sure want to quit ?'),
                  actions: [
                    CupertinoDialogAction(
                      child: Text('Yes'),
                      onPressed: () {
                        clearedShared();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>LoginPage()));
                        // NavMe().NavPushReplaceFadeIn(LoginPage());
                      },
                    ),
                    CupertinoDialogAction(
                      child: Text('No'),
                      onPressed: () {
                        clearedShared();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );

            // Update the state of the app
            // ...
            // Then close the MyDrawer
            clearedShared();
            NavMe().NavPushReplaceFadeIn(LoginPage());
          },
        ),
        ListTile(
          title: Text('Item 2'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the MyDrawer
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
