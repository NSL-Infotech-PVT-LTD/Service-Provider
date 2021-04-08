import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'api_models/ForgetPasswordModel.dart';
import 'api_models/LoginUserModel.dart';
import 'package:http/http.dart' as http;

import 'api_models/RegisterNewUserModel.dart';

class ApiCaller {
  String baseUrl = "https://dev.netscapelabs.com/mission/public/api/";
  String provider = "provider/";
  String login = "login";
  String register = "register";
  String forgetPassword = "reset-password";

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
    if (response.statusCode == 200 || response.statusCode==422) {
      loginUserModel = loginUserModelFromJson(response.body);
      return loginUserModel;
    } else {
      print(
          "THERE IS AN ERROR IN THE API WITH RESPONSE CODE ${response.statusCode}");
    }
  }

  Future<ForgetPasswordModel> forgetMyPassword({@required String email}) async {
    ForgetPasswordModel forgetPasswordModel;
    var response = await http.post(
      Uri.parse(baseUrl + forgetPassword),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );

    if (response.statusCode == 201) {
      print("QWERTY ${response.body}");
      return forgetPasswordModel = forgetPasswordModelFromJson(response.body);
    } else {
      print(
          "THERE IS AN ERROR INT THE FORGET PASSWORD API WITH STATUS CODE ${response.statusCode}");
    }
  }

  Future<RegisterNewUserModel> registerUser(
      {@required String fullName,
      @required String email,
      @required String password,
      @required String phonenumber,
      @required String location,
      @required String idName,
      @required String idNumber,
      @required String lat,
      @required String lang,
      @required String deviceType,
      @required deviceToken, @required postalCode}) async {
    RegisterNewUserModel registerNewUserModel;
    var response = await http.post(
      Uri.parse(baseUrl + provider + register),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': fullName,
        'email': email,
        'password': password,
        'mobile': phonenumber,
        'location': location,
        'device_type': deviceType,
        'device_token': deviceToken,
        'latitude': lat,
        'longitude': lang,
        'postal_code': postalCode,
        idName == "Saudi ID" ? 'saudi_id' : 'iqama_id': idNumber,
      }),
    );

    if (response.statusCode == 201 ||response.statusCode == 422) {
      print("QWERTY ${response.body}");
      return registerNewUserModel = registerNewUserModelFromJson(response.body);
    } else {
      print(
          "THERE IS AN ERROR INT THE REGISTER API WITH STATUS CODE ${response.statusCode}"); print(
          "THERE IS AN ERROR INT THE REGISTER API WITH STATUS CODE ${response.body}");
    }
  }
}
