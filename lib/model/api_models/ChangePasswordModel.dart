// To parse this JSON data, do
//
//     final changePasswordModel = changePasswordModelFromJson(jsonString);

import 'dart:convert';

ChangePasswordModel changePasswordModelFromJson(String str) => ChangePasswordModel.fromJson(json.decode(str));

String changePasswordModelToJson(ChangePasswordModel data) => json.encode(data.toJson());

class ChangePasswordModel {
  ChangePasswordModel({
    this.status,
    this.code,
    this.data,
    this.error,
  });

  bool status;
  int code;
  Data data;
String error;
  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) => ChangePasswordModel(
    status: json["status"],
    code: json["code"],
    data: json["data"] != null &&
        (json["data"] as Map<String, dynamic>).isNotEmpty
        ? Data.fromJson(json["data"])
        : null,
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": data.toJson(),
    "error": error
  };
}

class Data {
  Data({
    this.message,
  });

  String message;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
