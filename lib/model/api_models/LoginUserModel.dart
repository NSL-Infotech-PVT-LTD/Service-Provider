// To parse this JSON data, do
//
//     final loginUserModel = loginUserModelFromJson(jsonString);

import 'dart:convert';

LoginUserModel loginUserModelFromJson(String str) => LoginUserModel.fromJson(json.decode(str));

String loginUserModelToJson(LoginUserModel data) => json.encode(data.toJson());

class LoginUserModel {
  LoginUserModel({
    this.status,
    this.code,
    this.data,
    this.error,
  });

  bool status;
  int code;
  Data data;
  String error;

  factory LoginUserModel.fromJson(Map<String, dynamic> json) => LoginUserModel(
    status: json["status"],
    code: json["code"],
      data: json["data"] != null &&
          (json["data"] as Map<String, dynamic>).isNotEmpty
          ? Data.fromJson(json["data"]):null,
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
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.gender,
    this.status,
    this.radius,
    this.image,
    this.location,
    this.categoryId,
    this.description,
    this.isNotify,
    this.stripeAccountId,
    this.image1,
    this.image2,
    this.image3,
    this.image4,
    this.image5,
    this.image6,
    this.hourlyRate,
    this.toolboxInfo,
    this.role,
  });

  int id;
  String name;
  String email;
  String mobile;
  String gender;
  String status;
  String radius;
  dynamic image;
  String location;
  List<dynamic> categoryId;
  String description;
  String isNotify;
  dynamic stripeAccountId;
  dynamic image1;
  dynamic image2;
  dynamic image3;
  dynamic image4;
  dynamic image5;
  dynamic image6;
  dynamic hourlyRate;
  dynamic toolboxInfo;
  Role role;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    mobile: json["mobile"],
    gender: json["gender"],
    status: json["status"],
    radius: json["radius"],
    image: json["image"],
    location: json["location"],
    categoryId: List<dynamic>.from(json["category_id"].map((x) => x)),
    description: json["description"],
    isNotify: json["is_notify"],
    stripeAccountId: json["stripe_account_id"],
    image1: json["image_1"],
    image2: json["image_2"],
    image3: json["image_3"],
    image4: json["image_4"],
    image5: json["image_5"],
    image6: json["image_6"],
    hourlyRate: json["hourly_rate"],
    toolboxInfo: json["toolbox_info"],
    role: Role.fromJson(json["role"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "mobile": mobile,
    "gender": gender,
    "status": status,
    "radius": radius,
    "image": image,
    "location": location,
    "category_id": List<dynamic>.from(categoryId.map((x) => x)),
    "description": description,
    "is_notify": isNotify,
    "stripe_account_id": stripeAccountId,
    "image_1": image1,
    "image_2": image2,
    "image_3": image3,
    "image_4": image4,
    "image_5": image5,
    "image_6": image6,
    "hourly_rate": hourlyRate,
    "toolbox_info": toolboxInfo,
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
