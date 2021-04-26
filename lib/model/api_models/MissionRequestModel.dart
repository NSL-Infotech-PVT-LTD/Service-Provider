// To parse this JSON data, do
//
//     final missionRequestModel = missionRequestModelFromJson(jsonString);

import 'dart:convert';

MissionRequestModel missionRequestModelFromJson(String str) => MissionRequestModel.fromJson(json.decode(str));

String missionRequestModelToJson(MissionRequestModel data) => json.encode(data.toJson());

class MissionRequestModel {
  MissionRequestModel({
    this.status,
    this.code,
    this.data,
  });

  bool status;
  int code;
  Data data;

  factory MissionRequestModel.fromJson(Map<String, dynamic> json) => MissionRequestModel(
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
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Datum {
  Datum({
    this.id,
    this.jobType,
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
  String jobType;
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    jobType: json["job_type"],
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
    "job_type": jobType,
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
