import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:misson_tasker/view/startup_screens/SplashScreen.dart';


import '../main.dart';

var myRoutes = [
  GetPage(name: '/', page: () => MyApp()),
  GetPage(name: '/splashscreen', page: () =>SplashScreen()),
  // GetPage(name: '/splashscreen/Login', page: () =>LoginScreen()),

];
