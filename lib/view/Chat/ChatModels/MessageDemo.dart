import 'dart:convert';

import 'package:flutter/widgets.dart';

MessageDemoDart messageDemoDartFromJson(String str) {
  return MessageDemoDart.fromJson(json.decode(str));
}

String messageDemoDartToJson(MessageDemoDart data) {
  return json.encode(data.toJson());
}

class MessageDemoDart {
  MessageDemoDart({
    this.id,
    @required this.localMessageId,
    this.messageId,
    this.replyId,
    @required this.senderId,
    @required this.receiverId,
    this.attachment,
    @required this.message,
    @required this.type,
    this.isRead,
    this.createdAt,
    this.senderName,
    this.senderImage,
    this.receiverName,
    this.receiverImage,
    this.replyCount,
    this.is_read_count,
    this.media,
    @required this.deviceType,
  });

  int id;
  String localMessageId;
  String messageId;
  int replyId;
  int senderId;
  int receiverId;
  int is_read_count;
  dynamic attachment;
  dynamic message;
  String media;
  String type;
  String isRead;
  DateTime createdAt;
  String senderName;
  String senderImage;
  String receiverName;
  String receiverImage;
  int replyCount;
  String deviceType;

  factory MessageDemoDart.fromJson(Map<String, dynamic> json) =>
      MessageDemoDart(
        id: json["id"],
        localMessageId: json["local_message_id"],
        messageId: json["message_id"],
        replyId: json["reply_id"],
        media: json["media"],
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        is_read_count: json["is_read_count"],
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
        deviceType: json["device_type"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "local_message_id": localMessageId,
    "message_id": messageId,
    "reply_id": replyId,
    "media": media,
    "sender_id": senderId,
    "receiver_id": receiverId,
    "is_read_count": is_read_count,
    "attachment": attachment,
    "message": message,
    "type": type,
    "is_read": isRead,
    "created_at": createdAt.toString(),
    "sender_name": senderName,
    "sender_image": senderImage,
    "receiver_name": receiverName,
    "receiver_image": receiverImage,
    "reply_count": replyCount,
    "device_type": deviceType,
  };
}
