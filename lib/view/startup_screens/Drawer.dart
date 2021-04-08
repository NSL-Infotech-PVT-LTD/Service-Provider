import 'package:flutter/material.dart';
import 'package:misson_tasker/utils/NavMe.dart';
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
          child: Text('MyDrawer Header'),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
        ListTile(
          title: Text('LOGOUT'),
          onTap: () {
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
