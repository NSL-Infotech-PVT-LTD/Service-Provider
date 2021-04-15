// To parse this JSON data, do
//
//     final getProfileDataModel = getProfileDataModelFromJson(jsonString);

import 'dart:convert';

GetProfileDataModel getProfileDataModelFromJson(String str) => GetProfileDataModel.fromJson(json.decode(str));

String getProfileDataModelToJson(GetProfileDataModel data) => json.encode(data.toJson());

class GetProfileDataModel {
  GetProfileDataModel({
    this.status,
    this.code,
    this.data,
    this.error,
  });

  bool status;
  int code;
  Data data;String error;

  factory GetProfileDataModel.fromJson(Map<String, dynamic> json) => GetProfileDataModel(
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
    this.user,
  });

  User user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
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

  String name;
  String mobile;
  String email;
  String status;
  String image;
  String location;
  String latitude;
  String longitude;
  List<dynamic> categoryId;
  dynamic description;
  String postalCode;
  String isNotify;
  dynamic radius;
  dynamic stripeAccountId;
  dynamic appleId;
  dynamic fbId;
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
    "role": List<dynamic>.from(role.map((x) => x)),
  };
}
