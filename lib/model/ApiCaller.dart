import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:misson_tasker/model/api_models/GetProfileDataModel.dart';

import 'api_models/ForgetPasswordModel.dart';
import 'api_models/LoginUserModel.dart';
import 'package:http/http.dart' as http;

import 'api_models/RegisterNewUserModel.dart';
import 'api_models/UpdateProfileDataModel.dart';

class ApiCaller {
  String baseUrl = "https://dev.netscapelabs.com/mission/public/api/";
  String provider = "provider/";
  String login = "login";
  String register = "register";
  String forgetPassword = "reset-password";
  String getProfile = "get-profile";
  String updateProfile = "update";

  Future<LoginUserModel> loginUser({@required String email,
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
    if (response.statusCode == 200 || response.statusCode == 422) {
      loginUserModel = loginUserModelFromJson(response.body);
      return loginUserModel;
    } else {
      print(
          "THERE IS AN ERROR IN THE API WITH RESPONSE CODE ${response
              .statusCode}");
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

    if (response.statusCode == 201 || response.statusCode == 422) {
      print("QWERTY ${response.body}");
      return forgetPasswordModel = forgetPasswordModelFromJson(response.body);
    } else {
      print(
          "THERE IS AN ERROR INT THE FORGET PASSWORD API WITH STATUS CODE ${response
              .statusCode}");
    }
  }

  Future<GetProfileDataModel> getProfileData({@required String auth}) async {
    GetProfileDataModel getProfileDataModel;
    var response = await http.post(
      Uri.parse(baseUrl + getProfile),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer " + auth
      },
    );

    if (response.statusCode == 200) {
      print("QWERTY ${response.body}");
      return getProfileDataModel = getProfileDataModelFromJson(response.body);
    } else {
      print("QWERTY ${response.body}");
      print(
          "THERE IS AN ERROR INT THE GET PROFILE DATA API WITH STATUS CODE ${response
              .statusCode}");
    }
  }

  Future<RegisterNewUserModel> registerUser({@required String fullName,
    @required String email,
    @required String password,
    @required String phonenumber,
    @required String location,
    @required String idName,
    @required String idNumber,
    @required String lat,
    @required String lang,
    @required String deviceType,
    @required deviceToken,
    @required postalCode}) async {
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

    if (response.statusCode == 201 || response.statusCode == 422) {
      print("QWERTY ${response.body}");
      return registerNewUserModel = registerNewUserModelFromJson(response.body);
    } else {
      print(
          "THERE IS AN ERROR INT THE REGISTER API WITH STATUS CODE ${response
              .statusCode}");
      print(
          "THERE IS AN ERROR INT THE REGISTER API WITH STATUS CODE ${response
              .body}");
    }
  }

  Future<UpdateProfileDataModel> updateUserApi(
      {File file, String auth, Map<String, String> params}) async {
    print(auth);

    final postUri = Uri.parse(baseUrl + provider + updateProfile);
    UpdateProfileDataModel dataModel;
    http.MultipartRequest request = http.MultipartRequest('POST', postUri);
    request.headers['Authorization'] = "Bearer "+ auth;
    request.fields.addAll(params);
    // print(updateUrl.toString());
    if (file != null) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
          'image', file.path); //returns a Future<MultipartFile>
      request.files.add(multipartFile);
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      print("${response.body}");
      dataModel = updateProfileDataModelFromJson(response.body);
      // var map = Map<String, dynamic>.from(jsonData);
      // return UpdateUserData.fromJson(map);
      return dataModel;
    }
    else {
      print(
          "THERE IS AN ERROR IN THE UPDATE USER PROFILE API WITH STATUS CODE ${response
              .statusCode}");
      print("${response.body}");
    }
  }
}

Future<bool> isConnectedToInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  } else {
    return false;
  }
}
