// To parse this JSON data, do
//
//     final ChangeJobStatusModel = ChangeJobStatusModelFromJson(jsonString);

import 'dart:convert';

ChangeJobStatusModel ChangeJobStatusModelFromJson(String str) => ChangeJobStatusModel.fromJson(json.decode(str));

String ChangeJobStatusModelToJson(ChangeJobStatusModel data) => json.encode(data.toJson());

class ChangeJobStatusModel {
  ChangeJobStatusModel({
    this.status,
    this.code,
    this.data,
    this.error,
  });

  bool status;
  int code;
  Data data;
  Data error;

  factory ChangeJobStatusModel.fromJson(Map<String, dynamic> json) => ChangeJobStatusModel(
    status: json["status"],
    code: json["code"],
    data: json["data"] != null &&
        (json["data"] as Map<String, dynamic>).isNotEmpty
        ? Data.fromJson(json["data"])
        : null,
    error: json["error"] != null &&
        (json["error"] as Map<String, dynamic>).isNotEmpty
        ? Data.fromJson(json["error"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": data.toJson(),
    "error": error.toJson(),
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
