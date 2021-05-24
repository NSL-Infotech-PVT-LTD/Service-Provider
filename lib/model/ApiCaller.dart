import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:misson_tasker/model/api_models/GetProfileDataModel.dart';
import 'package:misson_tasker/model/api_models/ListOfServicesModel.dart';
import 'package:misson_tasker/model/api_models/MissionRequestModel.dart';
import 'package:misson_tasker/model/api_models/GetJobByIdModel.dart';
import 'package:misson_tasker/model/api_models/ChnageJobStatusModel.dart';
import 'package:misson_tasker/model/api_models/NotificationModel.dart';
import 'package:misson_tasker/view/Chat/ChatModels/ChatHistoryModel.dart';
import 'package:misson_tasker/view/Chat/ChatModels/ListChatUserModel.dart';

import 'package:misson_tasker/view/ProfileView/ConfigurationScreen.dart';

import 'api_models/ChangePasswordModel.dart';
import 'api_models/ConfigurationModel.dart';
import 'api_models/ForgetPasswordModel.dart';
import 'api_models/LoginUserModel.dart';
import 'package:http/http.dart' as http;

import 'api_models/NotificationReadModel.dart';
import 'api_models/NotificationToggle.dart';
import 'api_models/RegisterNewUserModel.dart';
import 'api_models/UpdateBusinessProfileDataModel.dart';
import 'api_models/UpdateProfileDataModel.dart';

class ApiCaller {
  String baseUrl = "https://dev.netscapelabs.com/mission/public/api/";
  String provider = "provider/";
  String login = "login";
  String register = "register";
  String forgetPassword = "reset-password";
  String getProfile = "get-profile";
  String updateProfile = "update";
  String category = "category/";
  String list = "list";
  String changePassword = "change-password";
  String termsAndCondition = "terms_and_conditions";
  String aboutUs = "about_us";
  String PrivacyPolicy = "privacy_policy";
  String config = "config/";
  String notification = "notification/";
  String job = "job/";
  String listofJob = "list";
  String jobById = "ById";
  String changeJobStatusApi = "change-job-status";
  String chat = "chat/";
  String oneToMany = "getItemByReceiverId";
  String oneToOne = "getItemsByReceiverId";
  String uploadMedia = "upload-media";
  String notificationList = "list";
  String notificationRead = "read";

  String status = "status";

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
    if (response.statusCode == 200 || response.statusCode == 422) {
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

    if (response.statusCode == 201 || response.statusCode == 422) {
      print("QWERTY ${response.body}");
      return forgetPasswordModel = forgetPasswordModelFromJson(response.body);
    } else {
      print(
          "THERE IS AN ERROR INT THE FORGET PASSWORD API WITH STATUS CODE ${response.statusCode}");
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
      print("Job List ${response.body}");
      return getProfileDataModel = getProfileDataModelFromJson(response.body);
    } else {
      print("QWERTY ${response.body}");
      print(
          "THERE IS AN ERROR IN THE GET PROFILE DATA API WITH STATUS CODE ${response.statusCode}");
    }
  }

  Future<NotificationToggleModel> doNotificationToggle(
      {@required String auth, String value}) async {
    NotificationToggleModel notificationToggleModel;
    var response = await http.post(
      Uri.parse(baseUrl + notification + status),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer " + auth
      },
      body: jsonEncode(<String, String>{
        'is_notify': value,
      }),
    );

    if (response.statusCode == 20) {
      print("QWERTY ${response.body}");
      return notificationToggleModel =
          notificationToggleModelFromJson(response.body);
    } else {
      print("QWERTY ${response.body}");
      print(
          "THERE IS AN ERROR IN doNotificationToggle API WITH STATUS CODE ${response.statusCode}");
    }
  }

  Future<ListOfServicesModel> getServiceList({@required String auth}) async {
    ListOfServicesModel listOfServicesModel;
    var response = await http.post(
      Uri.parse(baseUrl + category + list),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer " + auth
      },
      body: jsonEncode(<String, String>{
        'parent_id': "0",
      }),
    );

    if (response.statusCode == 200) {
      print("QWERTY ${response.body}");
      return listOfServicesModel = listOfServicesModelFromJson(response.body);
    } else {
      print("QWERTY ${response.body}");
      print(
          "THERE IS AN ERROR IN getServiceList API WITH STATUS CODE ${response.statusCode}");
    }
  }

  Future<ListOfServicesModel> getChildScerviceList(
      {@required String id, @required auth}) async {
    ListOfServicesModel listOfServicesModel;
    var response = await http.post(
      Uri.parse(baseUrl + category + list),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer " + auth
      },
      body: jsonEncode(<String, String>{
        'parent_id': "$id",
      }),
    );

    if (response.statusCode == 200) {
      print("QWERTY ${response.body}");
      return listOfServicesModel = listOfServicesModelFromJson(response.body);
    } else {
      print("QWERTY ${response.body}");
      print(
          "THERE IS AN ERROR INT THE GET CHILD SERVICE LIST API WITH STATUS CODE ${response.statusCode}");
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
          "THERE IS AN ERROR INT THE REGISTER API WITH STATUS CODE ${response.statusCode}");
      print(
          "THERE IS AN ERROR INT THE REGISTER API WITH STATUS CODE ${response.body}");
    }
  }

  Future<UpdateProfileDataModel> updateUserApi(
      {File file, String auth, Map<String, String> params}) async {
    print(auth);

    final postUri = Uri.parse(baseUrl + provider + updateProfile);
    UpdateProfileDataModel dataModel;
    http.MultipartRequest request = http.MultipartRequest('POST', postUri);
    request.headers['Authorization'] = "Bearer " + auth;
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
      return dataModel = updateProfileDataModelFromJson(response.body);
      // var map = Map<String, dynamic>.from(jsonData);
      // return UpdateUserData.fromJson(map);
      // return dataModel;
    } else {
      print(
          "THERE IS AN ERROR IN THE UPDATE USER PROFILE API WITH STATUS CODE ${response.statusCode}");
      print("${response.body}");
    }
  }

  Future<UpdateProfileDataModel> updateBusinessDetailApi(
      {List<File> listFile, String auth, Map<String, String> params}) async {
    var names = [
      "image_one",
      "image_two",
      "image_three",
      "image_four",
      "image_five",
      "image_six",
    ];
    print(auth);

    final postUri = Uri.parse(baseUrl + provider + updateProfile);
    UpdateProfileDataModel dataModel;
    http.MultipartRequest request = http.MultipartRequest('POST', postUri);
    request.headers['Authorization'] = "Bearer " + auth;
    request.fields.addAll(params);
    // print(updateUrl.toString());

    if (listFile.length > 0) {
      for (int i = 0; i < listFile.length; i++) {
        http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
            // 'image_${i + 1}',
            '${names.elementAt(i)}',
            listFile[i].path); //returns a Future<MultipartFile>
        request.files.add(multipartFile);
      }
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      print("${response.body}");
      dataModel = updateProfileDataModelFromJson(response.body);
      // var map = Map<String, dynamic>.from(jsonData);
      // return UpdateUserData.fromJson(map);
      return dataModel;
    } else {
      print(
          "THERE IS AN ERROR IN THE UPDATE USER PROFILE API WITH STATUS CODE ${response.statusCode}");
      print("${response.body}");
    }
  }

  Future<UpdateBusinessProfileDataModel> addChooseCategories(
      {@required String parent_id,
      @required List<int> child_id,
      @required String auth}) async {
    UpdateBusinessProfileDataModel businessProfileDataModel;
    var response = await http.post(
      Uri.parse(baseUrl + provider + updateProfile),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer " + auth
      },
      body: jsonEncode(<String, dynamic>{
        'parent_category_id': parent_id,
        "child_category_id": child_id.toList().toString()
      }),
    );

    if (response.statusCode == 200) {
      print("QWERTY ${response.body}");
      return businessProfileDataModel =
          updateBusinessProfileDataModelFromJson(response.body);
    } else {
      print("QWERTY ${response.body}");
      print(
          "THERE IS AN ERROR INT THE ADD CHOOSE CATEGORIES API WITH STATUS CODE ${response.statusCode}");
    }
  }

  Future<ChangePasswordModel> changePasswordApi(
      {@required String oldPassword,
      @required String newPassword,
      @required String reNewPassword,
      @required String auth}) async {
    ChangePasswordModel changePasswordModel;
    var response = await http.post(
      Uri.parse(baseUrl + provider + changePassword),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer " + auth
      },
      body: jsonEncode(<String, dynamic>{
        'old_password': oldPassword,
        "password": newPassword,
        "confirm_password": reNewPassword
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 422) {
      print("QWERTY ${response.body}");
      return changePasswordModel = changePasswordModelFromJson(response.body);
    } else {
      print("QWERTY ${response.body}");
      print(
          "THERE IS AN ERROR INT THE CHANGE PASSWORD API WITH STATUS CODE ${response.statusCode}");
    }
  }

  Future<ConfigurationModel> termsAndConditionsApi() async {
    ConfigurationModel configurationModel;
    var response = await http.get(
      Uri.parse(baseUrl + config + termsAndCondition),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 422) {
      print("QWERTY ${response.body}");
      return configurationModel = configurationModelFromJson(response.body);
    } else {
      print("QWERTY ${response.body}");
      print(
          "THERE IS AN ERROR INT THE TERMS AND CONDITION API WITH STATUS CODE ${response.statusCode}");
    }
  }

  Future<ConfigurationModel> privacyPolicyApi() async {
    ConfigurationModel configurationModel;
    var response = await http.get(
      Uri.parse(baseUrl + config + PrivacyPolicy),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 422) {
      print("QWERTY ${response.body}");
      return configurationModel = configurationModelFromJson(response.body);
    } else {
      print("QWERTY ${response.body}");
      print(
          "THERE IS AN ERROR INT THE TERMS AND CONDITION API WITH STATUS CODE ${response.statusCode}");
    }
  }

  Future<ConfigurationModel> aboutUsApi() async {
    ConfigurationModel configurationModel;
    var response = await http.get(
      Uri.parse(baseUrl + config + aboutUs),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 422) {
      print("QWERTY ${response.body}");
      return configurationModel = configurationModelFromJson(response.body);
    } else {
      print("QWERTY ${response.body}");
      print(
          "THERE IS AN ERROR INT THE TERMS AND CONDITION API WITH STATUS CODE ${response.statusCode}");
    }
  }

  Future<MissionRequestModel> missionRequest(
      {String auth,
      String jobType,
      String latitude,
      String longitude,
      String jobStatus}) async {
    MissionRequestModel missionRequestModel;
    var response = await http.post(
      Uri.parse(baseUrl + provider + job + listofJob),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer " + auth
      },
      body: jsonEncode(<String, dynamic>{
        'job_type': "$jobType",
        'latitude': "$latitude",
        'longitude': "$longitude",
        "job_status": jobStatus,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 422) {
      print(" missionRequestModel ${response.body}");
      return missionRequestModel = missionRequestModelFromJson(response.body);
    } else {
      print("missionRequestModel ${response.body}");
      print(
          "THERE IS AN ERROR INT THE TERMS AND CONDITION API WITH STATUS CODE ${response.statusCode}");
    }
  }

  Future<GetJobByIdModel> getJobDetailsByID({String auth, String Id}) async {
    GetJobByIdModel getJobByIdModel;
    var response = await http.post(
      Uri.parse(baseUrl + provider + job + jobById),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer " + auth
      },
      body: jsonEncode(<String, dynamic>{
        'id': "$Id",
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 422) {
      print("getJobByIdModel ${response.body}");
      return getJobByIdModel = getJobByIdModelFromJson(response.body);
    } else {
      print("getJobByIdModel ${response.body}");
      print(
          "THERE IS AN ERROR INT THE TERMS AND CONDITION API WITH STATUS CODE ${response.statusCode}");
    }
  }

  Future<NotificationModel> getListOfNotification({String auth}) async {
    NotificationModel notificationModel;
    var response = await http.post(
      Uri.parse(baseUrl + notification + notificationList),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer " + auth
      },
      body:  jsonEncode(
          <String, dynamic>{"limit": "1000"}),
    );

    if (response.statusCode == 200 || response.statusCode == 422) {
      print("getJobByIdModel ${response.body}");
      return notificationModel = notificationModelFromJson(response.body);
    } else {
      print("getJobByIdModel ${response.body}");
      print(
          "THERE IS AN ERROR INT THE getListOfNotification API WITH STATUS CODE ${response.statusCode}");
    }
  }

  Future<NotificationReadModel> readNotification(
      {String auth, String Id}) async {
    NotificationReadModel notificationReadModel;
    var response = await http.post(
      Uri.parse(baseUrl + notification + notificationRead),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer " + auth
      },
      body: jsonEncode(<String, dynamic>{
        'id': "$Id",
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 422) {
      print("readNotification ${response.body}");
      return notificationReadModel =
          notificationReadModelFromJson(response.body);
    } else {
      print("readNotification ${response.body}");
      print(
          "THERE IS AN ERROR INT THE readNotification API WITH STATUS CODE ${response.statusCode}");
    }
  }

  Future<ChangeJobStatusModel> changeJobStatus(
      {String auth, String Id, String jobStatus}) async {
    ChangeJobStatusModel changeJobStatusModel;
    var response = await http.post(
      Uri.parse(baseUrl + provider + changeJobStatusApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer " + auth
      },
      body: jsonEncode(
          <String, dynamic>{'job_id': "$Id", 'job_status': '$jobStatus'}),
    );

    if (response.statusCode == 200 || response.statusCode == 422) {
      print("changeJobStatusModel ${response.body}");
      return changeJobStatusModel = ChangeJobStatusModelFromJson(response.body);
    } else {
      print("changeJobStatusModel ${response.body}");
      print(
          "THERE IS AN ERROR INT THE TERMS AND CONDITION API WITH STATUS CODE ${response.statusCode}");
    }
  }

  Future<ListChatUserModel> getListOfChatUsers(
      {String auth, String limit}) async {
    ListChatUserModel mssageDemoDart;
    var response = await http.post(
      Uri.parse(baseUrl + chat + oneToMany),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer " + auth
      },
      body: jsonEncode(<String, dynamic>{'limit': "$limit"}),
    );

    if (response.statusCode == 200 || response.statusCode == 422) {
      print("mssageDemoDart ${response.body}");
      return mssageDemoDart = listChatUserModelFromJson(response.body);
    } else {
      print("mssageDemoDart ${response.body}");
      print(
          "THERE IS AN ERROR INT THE TERMS AND CONDITION API WITH STATUS CODE ${response.statusCode}");
    }
  }

  Future<ChatHistoryModel> getHistoryOfChat(
      {String auth, String reciverId}) async {
    ChatHistoryModel chatHistoryModel;
    var response = await http.post(
      Uri.parse(baseUrl + chat + oneToOne),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer " + auth
      },
      body: jsonEncode(
          <String, dynamic>{'receiver_id': "$reciverId", "limit": "1000"}),
    );

    if (response.statusCode == 200 || response.statusCode == 422) {
      print("chatHistoryModel 123 ${response.body}");
      return chatHistoryModel = chatHistoryModelFromJson(response.body);
    } else {
      print("chatHistoryModel ERROR+_+_+_++__+_+_++_+_+ ${response.body}");
      print(
          "THERE IS AN ERROR INT THE TERMS AND CONDITION API WITH STATUS CODE ${response.statusCode}");
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
