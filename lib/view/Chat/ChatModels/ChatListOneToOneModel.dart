// To parse this JSON data, do
//
//     final chatListOneToOneModel = chatListOneToOneModelFromJson(jsonString);

import 'dart:convert';

ChatListOneToOneModel chatListOneToOneModelFromJson(String str) => ChatListOneToOneModel.fromJson(json.decode(str));

String chatListOneToOneModelToJson(ChatListOneToOneModel data) => json.encode(data.toJson());

class ChatListOneToOneModel {
  ChatListOneToOneModel({
    this.status,
    this.code,
    this.data,
  });

  bool status;
  int code;
  Data data;

  factory ChatListOneToOneModel.fromJson(Map<String, dynamic> json) => ChatListOneToOneModel(
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
    this.receiverDetail,
    this.chat,
  });

  ReceiverDetail receiverDetail;
  Chat chat;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    receiverDetail: ReceiverDetail.fromJson(json["receiver_detail"]),
    chat: Chat.fromJson(json["chat"]),
  );

  Map<String, dynamic> toJson() => {
    "receiver_detail": receiverDetail.toJson(),
    "chat": chat.toJson(),
  };
}

class Chat {
  Chat({
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

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
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
    this.localMessageId,
    this.messageId,
    this.replyId,
    this.senderId,
    this.receiverId,
    this.attachment,
    this.message,
    this.type,
    this.isRead,
    this.createdAt,
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
  DateTime createdAt;
  String senderName;
  dynamic senderImage;
  String receiverName;
  String receiverImage;
  int replyCount;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    createdAt: DateTime.parse(json["created_at"]),
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
    "created_at": createdAt.toIso8601String(),
    "sender_name": senderName,
    "sender_image": senderImage,
    "receiver_name": receiverName,
    "receiver_image": receiverImage,
    "reply_count": replyCount,
  };
}

class ReceiverDetail {
  ReceiverDetail({
    this.id,
    this.name,
    this.image,
    this.role,
    this.images,
  });

  int id;
  String name;
  dynamic image;
  Role role;
  List<dynamic> images;

  factory ReceiverDetail.fromJson(Map<String, dynamic> json) => ReceiverDetail(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    role: Role.fromJson(json["role"]),
    images: List<dynamic>.from(json["images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
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
