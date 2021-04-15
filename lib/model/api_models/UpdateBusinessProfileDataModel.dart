import 'dart:convert';

UpdateBusinessProfileDataModel updateBusinessProfileDataModelFromJson(String str) => UpdateBusinessProfileDataModel.fromJson(json.decode(str));

String updateBusinessProfileDataModelToJson(UpdateBusinessProfileDataModel data) => json.encode(data.toJson());

class UpdateBusinessProfileDataModel {
  UpdateBusinessProfileDataModel({
    this.status,
    this.code,
    this.data,
  });

  bool status;
  int code;
  Data data;

  factory UpdateBusinessProfileDataModel.fromJson(Map<String, dynamic> json) => UpdateBusinessProfileDataModel(
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
    this.message,
    this.user,
  });

  String message;
  dynamic user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    message: json["message"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "user": user,
  };
}
