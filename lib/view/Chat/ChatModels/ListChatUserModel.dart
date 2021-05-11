// To parse this JSON data, do
//
//     final listChatUserModel = listChatUserModelFromJson(jsonString);

import 'dart:convert';

ListChatUserModel listChatUserModelFromJson(String str) => ListChatUserModel.fromJson(json.decode(str));

String listChatUserModelToJson(ListChatUserModel data) => json.encode(data.toJson());

class ListChatUserModel {
  ListChatUserModel({
    this.status,
    this.code,
    this.data,
    this.error,
  });

  bool status;
  int code;
  Data data;
  String error;

  factory ListChatUserModel.fromJson(Map<String, dynamic> json) => ListChatUserModel(
    status: json["status"],
    code: json["code"],
    data: Data.fromJson(json["data"]),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": data.toJson(),
    "error": error,
  };
}

class Data {
  Data({
    this.list,
  });

  List<ListElement> list;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class ListElement {
  ListElement({
    this.id,
    this.senderId,
    this.receiverId,
    this.message,
    this.type,
    this.createdAt,
    this.isReadCustomer,
    this.isReadProvider,
    this.isReadCount,
    this.senderName,
    this.senderImage,
    this.receiverName,
    this.receiverImage,
  });

  int id;
  int senderId;
  int receiverId;
  String message;
  String type;
  DateTime createdAt;
  int isReadCustomer;
  int isReadProvider;
  int isReadCount;
  String senderName;
  String senderImage;
  String receiverName;
  String receiverImage;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    id: json["id"],
    senderId: json["sender_id"],
    receiverId: json["receiver_id"],
    message: json["message"],
    type: json["type"],
    createdAt: DateTime.parse(json["created_at"]),
    isReadCustomer: json["is_read_customer"],
    isReadProvider: json["is_read_provider"],
    isReadCount: json["is_read_count"],
    senderName: json["sender_name"],
    senderImage: json["sender_image"],
    receiverName: json["receiver_name"],
    receiverImage: json["receiver_image"] == null ? null : json["receiver_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sender_id": senderId,
    "receiver_id": receiverId,
    "message": message,
    "type": type,
    "created_at": createdAt.toIso8601String(),
    "is_read_customer": isReadCustomer,
    "is_read_provider": isReadProvider,
    "is_read_count": isReadCount,
    "sender_name": senderName,
    "sender_image": senderImage,
    "receiver_name": receiverName,
    "receiver_image": receiverImage == null ? null : receiverImage,
  };
}
