// To parse this JSON data, do
//
//     final acceptProposalModel = acceptProposalModelFromJson(jsonString);

import 'dart:convert';

AcceptProposalModel acceptProposalModelFromJson(String str) => AcceptProposalModel.fromJson(json.decode(str));

String acceptProposalModelToJson(AcceptProposalModel data) => json.encode(data.toJson());

class AcceptProposalModel {
  AcceptProposalModel({
    this.status,
    this.code,
    this.data,
  });

  bool status;
  int code;
  Data data;

  factory AcceptProposalModel.fromJson(Map<String, dynamic> json) => AcceptProposalModel(
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
  });

  String message;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
