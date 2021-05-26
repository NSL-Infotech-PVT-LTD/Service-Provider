// To parse this JSON data, do
//
//     final logoutModel = logoutModelFromJson(jsonString);

import 'dart:convert';

LogoutModel logoutModelFromJson(String str) => LogoutModel.fromJson(json.decode(str));

String logoutModelToJson(LogoutModel data) => json.encode(data.toJson());

class LogoutModel {
  LogoutModel({
    this.status,
    this.code,
    this.error,
    this.data,
  });

  bool status;
  int code;
  String error;
  Data data;

  factory LogoutModel.fromJson(Map<String, dynamic> json) => LogoutModel(
    status: json["status"],
    code: json["code"],
    error: json["error"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "error": error,
    "data": data.toJson(),
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
