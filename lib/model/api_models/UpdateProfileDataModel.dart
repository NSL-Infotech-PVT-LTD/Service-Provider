// To parse this JSON data, do
//
//     final updateProfileDataModel = updateProfileDataModelFromJson(jsonString);

import 'dart:convert';

UpdateProfileDataModel updateProfileDataModelFromJson(String str) => UpdateProfileDataModel.fromJson(json.decode(str));

String updateProfileDataModelToJson(UpdateProfileDataModel data) => json.encode(data.toJson());

class UpdateProfileDataModel {
  UpdateProfileDataModel({
    this.status,
    this.code,
    this.data,
  });

  bool status;
  int code;
  Data data;

  factory UpdateProfileDataModel.fromJson(Map<String, dynamic> json) => UpdateProfileDataModel(
    status: json["status"],
    code: json["code"],
    data: json["data"] != null &&
        (json["data"] as Map<String, dynamic>).isNotEmpty
        ? Data.fromJson(json["data"]):null,
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
    this.mobile,
    this.gender,
    this.status,
    this.radius,
    this.image,
    this.location,
    this.categoryId,
    this.description,
    this.postalCode,
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
    this.saudiId,
    this.iqamaId,
    this.role,
  });

  int id;
  String name;
  String email;
  String mobile;
  String gender;
  String status;
  dynamic radius;
  String image;
  String location;
  List<dynamic> categoryId;
  dynamic description;
  String postalCode;
  String isNotify;
  dynamic stripeAccountId;
  dynamic image1;
  dynamic image2;
  dynamic image3;
  dynamic image4;
  dynamic image5;
  dynamic image6;
  String hourlyRate;
  dynamic toolboxInfo;
  String saudiId;
  dynamic iqamaId;
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
    postalCode: json["postal_code"],
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
    saudiId: json["saudi_id"],
    iqamaId: json["iqama_id"],
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
    "postal_code": postalCode,
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
    "saudi_id": saudiId,
    "iqama_id": iqamaId,
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
