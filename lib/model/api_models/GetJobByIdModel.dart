// To parse this JSON data, do
//
//     final getJobByIdModel = getJobByIdModelFromJson(jsonString);

import 'dart:convert';

GetJobByIdModel getJobByIdModelFromJson(String str) => GetJobByIdModel.fromJson(json.decode(str));

String getJobByIdModelToJson(GetJobByIdModel data) => json.encode(data.toJson());

class GetJobByIdModel {
  GetJobByIdModel({
    this.status,
    this.code,
    this.data,
  });

  bool status;
  int code;
  Data data;

  factory GetJobByIdModel.fromJson(Map<String, dynamic> json) => GetJobByIdModel(
    status: json["status"],
    code: json["code"],
    data: json["data"] != null &&
        (json["data"] as Map<String, dynamic>).isNotEmpty
        ? Data.fromJson(json["data"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.jobStatus,
    this.title,
    this.estimatedHours,
    this.budget,
    this.description,
    this.startTime,
    this.startDate,
    this.location,
    this.latitude,
    this.longitude,
    this.distanceMiles,
  });

  int id;
  String jobStatus;
  String title;
  String estimatedHours;
  int budget;
  String description;
  String startTime;
  DateTime startDate;
  String location;
  String latitude;
  String longitude;
  String distanceMiles;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    jobStatus: json["job_status"],
    title: json["title"],
    estimatedHours: json["estimated_hours"],
    budget: json["budget"],
    description: json["description"],
    startTime: json["start_time"],
    startDate: DateTime.parse(json["start_date"]),
    location: json["location"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    distanceMiles: json["distance_miles"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "job_status": jobStatus,
    "title": title,
    "estimated_hours": estimatedHours,
    "budget": budget,
    "description": description,
    "start_time": startTime,
    "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "location": location,
    "latitude": latitude,
    "longitude": longitude,
    "distance_miles": distanceMiles,
  };
}
