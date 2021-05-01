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
  });

  bool status;
  int code;
  Data data;

  factory ListChatUserModel.fromJson(Map<String, dynamic> json) => ListChatUserModel(
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
    this.localMessageId,
    this.messageId,
    this.replyId,
    this.senderId,
    this.receiverId,
    this.attachment,
    this.message,
    this.type,
    this.isRead,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.senderName,
    this.senderImage,
    this.receiverName,
    this.receiverImage,
    this.replyCount,
  });

  int id;
  String localMessageId;
  String messageId;
  int replyId;
  int senderId;
  int receiverId;
  dynamic attachment;
  String message;
  String type;
  String isRead;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String senderName;
  dynamic senderImage;
  String receiverName;
  String receiverImage;
  int replyCount;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    id: json["id"],
    localMessageId: json["local_message_id"],
    messageId: json["message_id"],
    replyId: json["reply_id"],
    senderId: json["sender_id"],
    receiverId: json["receiver_id"],
    attachment: json["attachment"],
    message: json["message"],
    type: json["type"],
    isRead: json["is_read"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    senderName: json["sender_name"],
    senderImage: json["sender_image"],
    receiverName: json["receiver_name"],
    receiverImage: json["receiver_image"],
    replyCount: json["reply_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "local_message_id": localMessageId,
    "message_id": messageId,
    "reply_id": replyId,
    "sender_id": senderId,
    "receiver_id": receiverId,
    "attachment": attachment,
    "message": message,
    "type": type,
    "is_read": isRead,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "sender_name": senderName,
    "sender_image": senderImage,
    "receiver_name": receiverName,
    "receiver_image": receiverImage,
    "reply_count": replyCount,
  };
}
