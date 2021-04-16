// To parse this JSON data, do
//
//     final updateBusinessProfileDataModel = updateBusinessProfileDataModelFromJson(jsonString);

import 'dart:convert';

UpdateBusinessProfileDataModel updateBusinessProfileDataModelFromJson(String str) => UpdateBusinessProfileDataModel.fromJson(json.decode(str));

String updateBusinessProfileDataModelToJson(UpdateBusinessProfileDataModel data) => json.encode(data.toJson());

class UpdateBusinessProfileDataModel {
  UpdateBusinessProfileDataModel({
    this.status,
    this.code,
    this.data,
    this.error,
  });

  bool status;
  int code;
  Data data;
  String error;

  factory UpdateBusinessProfileDataModel.fromJson(Map<String, dynamic> json) => UpdateBusinessProfileDataModel(
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
  });

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
  dynamic imageTwo;
  dynamic imageThree;
  String imageFour;
  String imageFive;
  dynamic imageSix;
  String hourlyRate;
  String toolboxInfo;
  String saudiId;
  dynamic iqamaId;
  List<dynamic> role;

  factory User.fromJson(Map<String, dynamic> json) => User(
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
    role: List<dynamic>.from(json["role"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
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
    "role": List<dynamic>.from(role.map((x) => x)),
  };
}
