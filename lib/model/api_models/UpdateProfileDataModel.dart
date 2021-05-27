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
    this.error,
  });

  bool status;
  int code;
  Data data;
String error;
  factory UpdateProfileDataModel.fromJson(Map<String, dynamic> json) => UpdateProfileDataModel(
    status: json["status"],
    error: json["error"],
    code: json["code"],
    data:json["data"] != null &&
        (json["data"] as Map<String, dynamic>).isNotEmpty
        ? Data.fromJson(json["data"]):null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "error": error,
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
    this.mobile,
    this.email,
    this.status,
    this.image,
    this.location,
    this.latitude,
    this.longitude,
    this.categoryId,
    this.description,
    this.postalCode,
    this.isNotify,
    this.radius,
    this.stripeAccountId,
    this.appleId,
    this.fbId,
    this.imageOne,
    this.imageTwo,
    this.imageThree,
    this.imageFour,
    this.imageFive,
    this.imageSix,
    this.hourlyRate,
    this.toolboxInfo,
    this.saudiId,
    this.iqamaId,
    this.role,
    this.images,
  });

  int id;
  String name;
  String mobile;
  String email;
  String status;
  String image;
  String location;
  String latitude;
  String longitude;
  List<dynamic> categoryId;
  String description;
  String postalCode;
  String isNotify;
  dynamic radius;
  dynamic stripeAccountId;
  dynamic appleId;
  dynamic fbId;
  String imageOne;
  String imageTwo;
  String imageThree;
  String imageFour;
  String imageFive;
  String imageSix;
  String hourlyRate;
  String toolboxInfo;
  String saudiId;
  String iqamaId;
  Role role;
  List<String> images;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    mobile: json["mobile"],
    email: json["email"],
    status: json["status"],
    image: json["image"],
    location: json["location"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    categoryId: List<dynamic>.from(json["category_id"].map((x) => x)),
    description: json["description"],
    postalCode: json["postal_code"],
    isNotify: json["is_notify"],
    radius: json["radius"],
    stripeAccountId: json["stripe_account_id"],
    appleId: json["apple_id"],
    fbId: json["fb_id"],
    imageOne: json["image_one"],
    imageTwo: json["image_two"],
    imageThree: json["image_three"],
    imageFour: json["image_four"],
    imageFive: json["image_five"],
    imageSix: json["image_six"],
    hourlyRate: json["hourly_rate"],
    toolboxInfo: json["toolbox_info"],
    saudiId: json["saudi_id"],
    iqamaId: json["iqama_id"],
    role: Role.fromJson(json["role"]),
    images: List<String>.from(json["images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mobile": mobile,
    "email": email,
    "status": status,
    "image": image,
    "location": location,
    "latitude": latitude,
    "longitude": longitude,
    "category_id": List<dynamic>.from(categoryId.map((x) => x)),
    "description": description,
    "postal_code": postalCode,
    "is_notify": isNotify,
    "radius": radius,
    "stripe_account_id": stripeAccountId,
    "apple_id": appleId,
    "fb_id": fbId,
    "image_one": imageOne,
    "image_two": imageTwo,
    "image_three": imageThree,
    "image_four": imageFour,
    "image_five": imageFive,
    "image_six": imageSix,
    "hourly_rate": hourlyRate,
    "toolbox_info": toolboxInfo,
    "saudi_id": saudiId,
    "iqama_id": iqamaId,
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
