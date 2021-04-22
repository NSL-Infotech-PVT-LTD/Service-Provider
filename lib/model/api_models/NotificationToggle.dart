// To parse this JSON data, do
//
//     final notificationToggleModel = notificationToggleModelFromJson(jsonString);

import 'dart:convert';

NotificationToggleModel notificationToggleModelFromJson(String str) => NotificationToggleModel.fromJson(json.decode(str));

String notificationToggleModelToJson(NotificationToggleModel data) => json.encode(data.toJson());

class NotificationToggleModel {
  NotificationToggleModel({
    this.status,
    this.code,
    this.data,
  });

  bool status;
  int code;
  Data data;

  factory NotificationToggleModel.fromJson(Map<String, dynamic> json) => NotificationToggleModel(
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
  User user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    message: json["message"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "user": user.toJson(),
  };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.isNotify,
    this.role,
    this.images,
  });

  int id;
  String name;
  String email;
  String isNotify;
  Role role;
  List<dynamic> images;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    isNotify: json["is_notify"],
    role: Role.fromJson(json["role"]),
    images: List<dynamic>.from(json["images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "is_notify": isNotify,
    "role": role.toJson(),
    "images": List<dynamic>.from(images.map((x) => x)),
  };
}

class Role {
  Role({
    this.name,
    this.id,
    this.permission,
  });

  String name;
  int id;
  List<dynamic> permission;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    name: json["name"],
    id: json["id"],
    permission: List<dynamic>.from(json["permission"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "permission": List<dynamic>.from(permission.map((x) => x)),
  };
}
