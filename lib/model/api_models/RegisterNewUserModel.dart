// To parse this JSON data, do
//
//     final registerNewUserModel = registerNewUserModelFromJson(jsonString);

import 'dart:convert';

RegisterNewUserModel registerNewUserModelFromJson(String str) =>
    RegisterNewUserModel.fromJson(json.decode(str));

String registerNewUserModelToJson(RegisterNewUserModel data) =>
    json.encode(data.toJson());

class RegisterNewUserModel {
  RegisterNewUserModel({
    this.status,
    this.code,
    this.data,
    this.error,
  });

  bool status;
  int code;
  Data data;
  String error;

  factory RegisterNewUserModel.fromJson(Map<String, dynamic> json) =>
      RegisterNewUserModel(
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
        "error": data.toJson(),
      };
}

class Data {
  Data({
    this.message,
    this.token,
    this.user,
  });

  String message;
  String token;
  User user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
        token: json["token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "user": user.toJson(),
      };
}

class User {
  User({
    this.name,
    this.email,
    this.mobile,
    this.location,
    this.description,
    this.latitude,
    this.longitude,
    this.postalCode,
    this.saudiId,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.role,
  });

  String name;
  String email;
  String mobile;
  String location;
  String description;
  String latitude;
  String longitude;
  String postalCode;
  String saudiId;
  String status;
  DateTime updatedAt;
  DateTime createdAt;
  int id;
  Role role;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        location: json["location"],
        description: json["description"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        postalCode: json["postal_code"],
        saudiId: json["saudi_id"],
        status: json["status"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        role: Role.fromJson(json["role"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "mobile": mobile,
        "location": location,
        "description": description,
        "latitude": latitude,
        "longitude": longitude,
        "postal_code": postalCode,
        "saudi_id": saudiId,
        "status": status,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
        "role": role.toJson(),
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
