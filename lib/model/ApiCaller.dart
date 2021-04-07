import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'api_models/LoginUserModel.dart';
import 'package:http/http.dart' as http;

import 'api_models/RegisterNewUserModel.dart';

class ApiCaller {
  String baseUrl = "https://dev.netscapelabs.com/mission/public/api/";
  String provider = "provider/";
  String login = "login";
  String register = "register";

  Future<LoginUserModel> loginUser(
      {@required String email,
      @required String password,
      @required deviceType,
      @required deviceToken}) async {
    var response = await http.post(
      Uri.parse(baseUrl + provider + login),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        "device_type": deviceType,
        "device_token": deviceToken
      }),
    );
    LoginUserModel loginUserModel;
    if (response.statusCode == 200) {
      loginUserModel = loginUserModelFromJson(response.body);
      return loginUserModel;
    } else {
      print(
          "THERE IS AN ERROR IN THE API WITH RESPONSE CODE ${response.statusCode}");
    }
  }

  Future<RegisterNewUserModel> registerUser()async{



  }
}
