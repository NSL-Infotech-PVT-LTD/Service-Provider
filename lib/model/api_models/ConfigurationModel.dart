// To parse this JSON data, do
//
//     final configurationModel = configurationModelFromJson(jsonString);

import 'dart:convert';

ConfigurationModel configurationModelFromJson(String str) => ConfigurationModel.fromJson(json.decode(str));

String configurationModelToJson(ConfigurationModel data) => json.encode(data.toJson());

class ConfigurationModel {
  ConfigurationModel({
    this.status,
    this.code,
    this.data,
  });

  bool status;
  int code;
  Data data;

  factory ConfigurationModel.fromJson(Map<String, dynamic> json) => ConfigurationModel(
    status: json["status"],
    code: json["code"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.config,
  });

  String config;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    config: json["config"],
  );

  Map<String, dynamic> toJson() => {
    "config": config,
  };
}
