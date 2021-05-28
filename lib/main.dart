import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/local_data.dart';
import 'package:misson_tasker/view/MissonRequestScreen/MissionRequest.dart';
import 'package:misson_tasker/view/startup_screens/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('IN THE ON Background ===============>>>>>>>>>>> ${message.data}');
  setString("target_id", message.data["target_id"]);
  getString("target_id").then((value) {
    print("======target_id==============> $value");
  });
}

//check kri
//ok
String fcmToken=" ";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  fcmToken = await FirebaseMessaging.instance.getToken();
  print("====================> $fcmToken");

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  var token;


  @override
  void initState() {
    getString("target_id").then((value) {
      print("======target_id==============> $value");
    });


    FirebaseMessaging.instance.requestPermission();
    print("CHECK $token");
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        print("IN THE ON MESSAGE ===============>>>>>>>>>>>");
        RemoteNotification notification = message.notification;
        AndroidNotification android = message.notification?.android;
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channel.description,
                  // color: Colors.blue,
                  playSound: true,
                  icon: '@mipmap/ic_launcher',
                ),
              ));

          print(
              "======IN onMessage ========> YYYYYYYYYYYYYYYY ${message.data}");
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("IN THE OPEN MESSAGE  ============>>>>>>>>>>>");

      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        print(
            "======IN onMessageOpenedApp ========> YYYYYYYYYYYYYYYY ${message.data}");

        if (message.data["data_type"] == "Job") {
          print("${message.data}");
          setString("target_id", message.data["target_id"]);
          getString("target_id").then((value) {
            print("======target_id==============> $value");

            print("123 $value");
          });
          Get.to(MissionRequest(id: message.data["target_id"]),
              transition: Transition.leftToRightWithFade,
              duration: Duration(milliseconds: 400));
        }
      }
    });

    super.initState();
  }

  void _showNotification() {
    flutterLocalNotificationsPlugin.show(
        0,
        "Testing",
        "How you doin ?",
        NotificationDetails(
            android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channel.description,
          importance: Importance.high,
          color: Colors.blue,
          playSound: true,
          icon: '@mipmap/ic_launcher',
        )));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: CColors.missonNormalWhiteColor,
        systemNavigationBarColor: CColors.missonNormalWhiteColor,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark));
    return GetMaterialApp(
      title: 'Mission Tasker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ).copyWith(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
          },
        ),
      ),
      home: SplashScreen(),
    );
  }
}
