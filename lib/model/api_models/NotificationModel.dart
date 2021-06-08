// //
// // import 'dart:convert';
// //
// // NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));
// //
// // String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());
// //
// // class NotificationModel {
// //   NotificationModel({
// //     this.status,
// //     this.code,
// //     this.data,
// //     this.error
// //   });
// //
// //   bool status;
// //   int code;
// //   Data data;
// //   String error;
// //
// //   factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
// //     status: json["status"],
// //     code: json["code"],
// //     data: json["data"] != null &&
// //         (json["data"] as Map<String, dynamic>).isNotEmpty
// //         ? Data.fromJson(json["data"])
// //         : null,
// //     error: json["error"],
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "status": status,
// //     "code": code,
// //     "data": data.toJson(),
// //     "error": error,
// //   };
// // }
// //
// // class Data {
// //   Data({
// //     this.isNotify,
// //     this.currentPage,
// //     this.data,
// //     this.firstPageUrl,
// //     this.from,
// //     this.lastPage,
// //     this.lastPageUrl,
// //     this.nextPageUrl,
// //     this.path,
// //     this.perPage,
// //     this.prevPageUrl,
// //     this.to,
// //     this.total,
// //   });
// //
// //   String isNotify;
// //   int currentPage;
// //   List<Datum> data;
// //   String firstPageUrl;
// //   int from;
// //   int lastPage;
// //   String lastPageUrl;
// //   String nextPageUrl;
// //   String path;
// //   int perPage;
// //   dynamic prevPageUrl;
// //   int to;
// //   int total;
// //
// //   factory Data.fromJson(Map<String, dynamic> json) => Data(
// //     isNotify: json["is_notify"],
// //     currentPage: json["current_page"],
// //     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
// //     firstPageUrl: json["first_page_url"],
// //     from: json["from"],
// //     lastPage: json["last_page"],
// //     lastPageUrl: json["last_page_url"],
// //     nextPageUrl: json["next_page_url"],
// //     path: json["path"],
// //     perPage: json["per_page"],
// //     prevPageUrl: json["prev_page_url"],
// //     to: json["to"],
// //     total: json["total"],
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "is_notify": isNotify,
// //     "current_page": currentPage,
// //     "data": List<dynamic>.from(data.map((x) => x.toJson())),
// //     "first_page_url": firstPageUrl,
// //     "from": from,
// //     "last_page": lastPage,
// //     "last_page_url": lastPageUrl,
// //     "next_page_url": nextPageUrl,
// //     "path": path,
// //     "per_page": perPage,
// //     "prev_page_url": prevPageUrl,
// //     "to": to,
// //     "total": total,
// //   };
// // }
// //
// // class Datum {
// //   Datum({
// //     this.id,
// //     this.title,
// //     this.body,
// //     this.message,
// //     this.targetId,
// //     this.createdBy,
// //     this.isRead,
// //     this.params,
// //     this.status,
// //     this.createdAt,
// //     this.updatedAt,
// //     this.deletedAt,
// //     this.bookingDetail,
// //     this.customerDetail,
// //   });
// //
// //   String id;
// //   Title title;
// //   String body;
// //   String message;
// //   String targetId;
// //   String createdBy;
// //   String isRead;
// //   dynamic params;
// //   String status;
// //   DateTime createdAt;
// //   DateTime updatedAt;
// //   dynamic deletedAt;
// //   BookingDetail bookingDetail;
// //   CustomerDetail customerDetail;
// //
// //   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
// //     id: json["id"],
// //     title: titleValues.map[json["title"]],
// //     body: json["body"],
// //     message: json["message"],
// //     targetId: json["target_id"],
// //     createdBy: json["created_by"],
// //     isRead: json["is_read"],
// //     params: json["params"],
// //     status: json["status"],
// //     createdAt: DateTime.parse(json["created_at"]),
// //     updatedAt: DateTime.parse(json["updated_at"]),
// //     deletedAt: json["deleted_at"],
// //     bookingDetail: BookingDetail.fromJson(json["booking_detail"]),
// //     customerDetail: CustomerDetail.fromJson(json["customer_detail"]),
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "id": id,
// //     "title": titleValues.reverse[title],
// //     "body": body,
// //     "message": message,
// //     "target_id": targetId,
// //     "created_by": createdBy,
// //     "is_read": isRead,
// //     "params": params,
// //     "status": status,
// //     "created_at": createdAt.toIso8601String(),
// //     "updated_at": updatedAt.toIso8601String(),
// //     "deleted_at": deletedAt,
// //     "booking_detail": bookingDetail.toJson(),
// //     "customer_detail": customerDetail.toJson(),
// //   };
// // }
// //
// // class BookingDetail {
// //   BookingDetail({
// //     this.targetId,
// //     this.targetModel,
// //     this.dataType,
// //   });
// //
// //   String targetId;
// //   TargetModel targetModel;
// //   DataType dataType;
// //
// //   factory BookingDetail.fromJson(Map<String, dynamic> json) => BookingDetail(
// //     targetId: json["target_id"],
// //     targetModel: targetModelValues.map[json["target_model"]],
// //     dataType: dataTypeValues.map[json["data_type"]],
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "target_id": targetId,
// //     "target_model": targetModelValues.reverse[targetModel],
// //     "data_type": dataTypeValues.reverse[dataType],
// //   };
// // }
// //
// // enum DataType { JOB }
// //
// // final dataTypeValues = EnumValues({
// //   "Job": DataType.JOB
// // });
// //
// // enum TargetModel { JOB_COMPLETED, JOB_PROCESSING, JOB_ACCEPTED, JOB_CONFIRMED }
// //
// // final targetModelValues = EnumValues({
// //   "Job-accepted": TargetModel.JOB_ACCEPTED,
// //   "Job-completed": TargetModel.JOB_COMPLETED,
// //   "Job-confirmed": TargetModel.JOB_CONFIRMED,
// //   "Job-processing": TargetModel.JOB_PROCESSING
// // });
// //
// // class CustomerDetail {
// //   CustomerDetail({
// //     this.id,
// //     this.name,
// //     this.image,
// //     this.role,
// //     this.images,
// //     this.profileProgressBar,
// //   });
// //
// //   int id;
// //   CustomerDetailName name;
// //   String image;
// //   Role role;
// //   List<dynamic> images;
// //   int profileProgressBar;
// //
// //   factory CustomerDetail.fromJson(Map<String, dynamic> json) => CustomerDetail(
// //     id: json["id"],
// //     name: customerDetailNameValues.map[json["name"]],
// //     image: json["image"],
// //     role: Role.fromJson(json["role"]),
// //     images: List<dynamic>.from(json["images"].map((x) => x)),
// //     profileProgressBar: json["profile_progress_bar"],
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "id": id,
// //     "name": customerDetailNameValues.reverse[name],
// //     "image": image,
// //     "role": role.toJson(),
// //     "images": List<dynamic>.from(images.map((x) => x)),
// //     "profile_progress_bar": profileProgressBar,
// //   };
// // }
// //
// // enum CustomerDetailName { TASKER, SWATI }
// //
// // final customerDetailNameValues = EnumValues({
// //   "swati": CustomerDetailName.SWATI,
// //   "Tasker": CustomerDetailName.TASKER
// // });
// //
// // class Role {
// //   Role({
// //     this.name,
// //     this.id,
// //     this.permission,
// //   });
// //
// //   RoleName name;
// //   int id;
// //   List<dynamic> permission;
// //
// //   factory Role.fromJson(Map<String, dynamic> json) => Role(
// //     name: roleNameValues.map[json["name"]],
// //     id: json["id"],
// //     permission: List<dynamic>.from(json["permission"].map((x) => x)),
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "name": roleNameValues.reverse[name],
// //     "id": id,
// //     "permission": List<dynamic>.from(permission.map((x) => x)),
// //   };
// // }
// //
// // enum RoleName { SERVICEPROVIDER, CUSTOMER }
// //
// // final roleNameValues = EnumValues({
// //   "customer": RoleName.CUSTOMER,
// //   "serviceprovider": RoleName.SERVICEPROVIDER
// // });
// //
// // enum Title { JOB_COMPLETED, JOB_STARTED, JOB_STATUS, JOB_CONFIRMED }
// //
// // final titleValues = EnumValues({
// //   "Job Completed": Title.JOB_COMPLETED,
// //   "Job Confirmed": Title.JOB_CONFIRMED,
// //   "Job Started": Title.JOB_STARTED,
// //   "Job Status": Title.JOB_STATUS
// // });
// //
// // class EnumValues<T> {
// //   Map<String, T> map;
// //   Map<T, String> reverseMap;
// //
// //   EnumValues(this.map);
// //
// //   Map<T, String> get reverse {
// //     if (reverseMap == null) {
// //       reverseMap = map.map((k, v) => new MapEntry(v, k));
// //     }
// //     return reverseMap;
// //   }
// // }
// // To parse this JSON data, do
// //
// //     final notificationModel = notificationModelFromJson(jsonString);
// // To parse this JSON data, do
// //
// //     final notificationModel = notificationModelFromJson(jsonString);
//
// // To parse this JSON data, do
// //
// //     final notificationModel = notificationModelFromJson(jsonString);
// // To parse this JSON data, do
// //
// //     final notificationModel = notificationModelFromJson(jsonString);
//
// import 'dart:convert';
//
// NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));
//
// String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());
//
// class NotificationModel {
//   NotificationModel({
//     this.status,
//     this.code,
//     this.error,
//     this.data,
//   });
//
//   bool status;
//   int code;
//   String error;
//   Data data;
//
//   factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
//     status: json["status"],
//     code: json["code"],
//     error: json["error"],
//       data: json["data"] != null &&
//         (json["data"] as Map<String, dynamic>).isNotEmpty
//             ? Data.fromJson(json["data"])
//             : null,
//       );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "code": code,
//     "error": error,
//     "data": data.toJson(),
//   };
// }
//
// class Data {
//   Data({
//     this.isNotify,
//     this.currentPage,
//     this.data,
//     this.firstPageUrl,
//     this.from,
//     this.lastPage,
//     this.lastPageUrl,
//     this.nextPageUrl,
//     this.path,
//     this.perPage,
//     this.prevPageUrl,
//     this.to,
//     this.total,
//   });
//
//   String isNotify;
//   int currentPage;
//   List<Datum> data;
//   String firstPageUrl;
//   int from;
//   int lastPage;
//   String lastPageUrl;
//   dynamic nextPageUrl;
//   String path;
//   String perPage;
//   dynamic prevPageUrl;
//   int to;
//   int total;
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     isNotify: json["is_notify"],
//     currentPage: json["current_page"],
//     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//     firstPageUrl: json["first_page_url"],
//     from: json["from"],
//     lastPage: json["last_page"],
//     lastPageUrl: json["last_page_url"],
//     nextPageUrl: json["next_page_url"],
//     path: json["path"],
//     perPage: json["per_page"],
//     prevPageUrl: json["prev_page_url"],
//     to: json["to"],
//     total: json["total"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "is_notify": isNotify,
//     "current_page": currentPage,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     "first_page_url": firstPageUrl,
//     "from": from,
//     "last_page": lastPage,
//     "last_page_url": lastPageUrl,
//     "next_page_url": nextPageUrl,
//     "path": path,
//     "per_page": perPage,
//     "prev_page_url": prevPageUrl,
//     "to": to,
//     "total": total,
//   };
// }
//
// class Datum {
//   Datum({
//     this.id,
//     this.title,
//     this.body,
//     this.message,
//     this.targetId,
//     this.createdBy,
//     this.isRead,
//     this.params,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//     this.bookingDetail,
//     this.customerDetail,
//   });
//
//   int id;
//   String title;
//   String body;
//   String message;
//   int targetId;
//   int createdBy;
//   String isRead;
//   dynamic params;
//   String status;
//   DateTime createdAt;
//   DateTime updatedAt;
//   dynamic deletedAt;
//   BookingDetail bookingDetail;
//   CustomerDetail customerDetail;
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     id: json["id"],
//     title: json["title"],
//     body: json["body"],
//     message: json["message"],
//     targetId: json["target_id"],
//     createdBy: json["created_by"],
//     isRead: json["is_read"],
//     params: json["params"],
//     status: json["status"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//     deletedAt: json["deleted_at"],
//     bookingDetail: BookingDetail.fromJson(json["booking_detail"]),
//     customerDetail: CustomerDetail.fromJson(json["customer_detail"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "body": body,
//     "message": message,
//     "target_id": targetId,
//     "created_by": createdBy,
//     "is_read": isRead,
//     "params": params,
//     "status": status,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//     "deleted_at": deletedAt,
//     "booking_detail": bookingDetail.toJson(),
//     "customer_detail": customerDetail.toJson(),
//   };
// }
//
// class BookingDetail {
//   BookingDetail({
//     this.targetId,
//     this.targetModel,
//     this.dataType,
//   });
//
//  var targetId;
//   String targetModel;
//   String dataType;
//
//   factory BookingDetail.fromJson(Map<String, dynamic> json) => BookingDetail(
//     targetId: json["target_id"],
//     targetModel: json["target_model"],
//     dataType: json["data_type"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "target_id": targetId,
//     "target_model": targetModel,
//     "data_type": dataType,
//   };
// }
//
// class CustomerDetail {
//   CustomerDetail({
//     this.id,
//     this.name,
//     this.image,
//     this.role,
//     this.images,
//     this.profileProgressBar,
//   });
//
//   int id;
//   String name;
//   String image;
//   Role role;
//   List<dynamic> images;
//   int profileProgressBar;
//
//   factory CustomerDetail.fromJson(Map<String, dynamic> json) => CustomerDetail(
//     id: json["id"],
//     name: json["name"],
//     image: json["image"],
//     role: Role.fromJson(json["role"]),
//     images: List<dynamic>.from(json["images"].map((x) => x)),
//     profileProgressBar: json["profile_progress_bar"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "image": image,
//     "role": role.toJson(),
//     "images": List<dynamic>.from(images.map((x) => x)),
//     "profile_progress_bar": profileProgressBar,
//   };
// }
//
// class Role {
//   Role({
//     this.name,
//     this.id,
//     this.permission,
//   });
//
//   String name;
//   int id;
//   List<dynamic> permission;
//
//   factory Role.fromJson(Map<String, dynamic> json) => Role(
//     name: json["name"],
//     id: json["id"],
//     permission: List<dynamic>.from(json["permission"].map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "name": name,
//     "id": id,
//     "permission": List<dynamic>.from(permission.map((x) => x)),
//   };
// }
// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.status,
    this.code,
    this.data,
    this.error
  });

  bool status;
  int code;
  Data data;
  String error;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    status: json["status"],
    code: json["code"],
    error: json["error"],
      data: json["data"] != null &&
        (json["data"] as Map<String, dynamic>).isNotEmpty
            ? Data.fromJson(json["data"])
            : null,
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
    this.isNotify,
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

  String isNotify;
  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  String perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    isNotify: json["is_notify"],
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
    "is_notify": isNotify,
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
    this.title,
    this.body,
    this.message,
    this.targetId,
    this.createdBy,
    this.isRead,
    this.params,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.bookingDetail,
    this.targetIdDetail,
    this.customerDetail,
  });

  int id;
  Title title;
  String body;
  String message;
  int targetId;
  int createdBy;
  String isRead;
  dynamic params;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  BookingDetail bookingDetail;
  TargetIdDetail targetIdDetail;
  CustomerDetail customerDetail;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: titleValues.map[json["title"]],
    body: json["body"],
    message: json["message"],
    targetId: json["target_id"],
    createdBy: json["created_by"],
    isRead: json["is_read"],
    params: json["params"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    bookingDetail: json["booking_detail"] == null ? null : BookingDetail.fromJson(json["booking_detail"]),
    targetIdDetail: TargetIdDetail.fromJson(json["target_id_detail"]),
    customerDetail: CustomerDetail.fromJson(json["customer_detail"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": titleValues.reverse[title],
    "body": body,
    "message": message,
    "target_id": targetId,
    "created_by": createdBy,
    "is_read": isRead,
    "params": params,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "booking_detail": bookingDetail == null ? null : bookingDetail.toJson(),
    "target_id_detail": targetIdDetail.toJson(),
    "customer_detail": customerDetail.toJson(),
  };
}

class BookingDetail {
  BookingDetail({
    this.targetId,
    this.targetModel,
    this.dataType,
    this.jobId,
    this.userJobId,
  });

  dynamic targetId;
  TargetModel targetModel;
  TargetModel dataType;
  int jobId;
  String userJobId;

  factory BookingDetail.fromJson(Map<String, dynamic> json) => BookingDetail(
    targetId: json["target_id"],
    targetModel: targetModelValues.map[json["target_model"]],
    dataType: json["data_type"] == null ? null : targetModelValues.map[json["data_type"]],
    jobId: json["job_id"] == null ? null : json["job_id"],
    userJobId: json["user_job_id"] == null ? null : json["user_job_id"],
  );

  Map<String, dynamic> toJson() => {
    "target_id": targetId,
    "target_model": targetModelValues.reverse[targetModel],
    "data_type": dataType == null ? null : targetModelValues.reverse[dataType],
    "job_id": jobId == null ? null : jobId,
    "user_job_id": userJobId == null ? null : userJobId,
  };
}

enum TargetModel { JOB, JOB_PROPOSAL, JOB_ACCEPTED, MESSAGE, JOB_CONFIRMED }

final targetModelValues = EnumValues({
  "Job": TargetModel.JOB,
  "Job-accepted": TargetModel.JOB_ACCEPTED,
  "Job-confirmed": TargetModel.JOB_CONFIRMED,
  "JobProposal": TargetModel.JOB_PROPOSAL,
  "Message": TargetModel.MESSAGE
});

class CustomerDetail {
  CustomerDetail({
    this.id,
    this.name,
    this.image,
    this.role,
    this.images,
    this.profileProgressBar,
  });

  int id;
  String name;
  String image;
  Role role;
  List<dynamic> images;
  int profileProgressBar;

  factory CustomerDetail.fromJson(Map<String, dynamic> json) => CustomerDetail(
    id: json["id"],
    name: json["name"],
    image: json["image"] == null ? null : json["image"],
    role: Role.fromJson(json["role"]),
    images: List<dynamic>.from(json["images"].map((x) => x)),
    profileProgressBar: json["profile_progress_bar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image == null ? null : image,
    "role": role.toJson(),
    "images": List<dynamic>.from(images.map((x) => x)),
    "profile_progress_bar": profileProgressBar,
  };
}





class Role {
  Role({
    this.name,
    this.id,
    this.permission,
  });

  RoleName name;
  int id;
  List<dynamic> permission;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    name: roleNameValues.map[json["name"]],
    id: json["id"],
    permission: List<dynamic>.from(json["permission"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": roleNameValues.reverse[name],
    "id": id,
    "permission": List<dynamic>.from(permission.map((x) => x)),
  };
}

enum RoleName { SERVICEPROVIDER, CUSTOMER }

final roleNameValues = EnumValues({
  "customer": RoleName.CUSTOMER,
  "serviceprovider": RoleName.SERVICEPROVIDER
});

class TargetIdDetail {
  TargetIdDetail({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.gender,
    this.postalCode,
    this.description,
    this.image,
    this.location,
    this.latitude,
    this.longitude,
    this.radius,
    this.saudiId,
    this.iqamaId,
    this.cvrNo,
    this.categoryId,
    this.stripeAccountId,
    this.appleId,
    this.fbId,
    this.isNotify,
    this.imageOne,
    this.imageTwo,
    this.imageThree,
    this.imageFour,
    this.imageFive,
    this.imageSix,
    this.hourlyRate,
    this.toolboxInfo,
    this.params,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.stripeId,
    this.cardBrand,
    this.cardLastFour,
    this.trialEndsAt,
    this.role,
    this.images,
    this.profileProgressBar,
  });

  int id;
  String name;
  String mobile;
  Email email;
  Gender gender;
  String postalCode;
  String description;
  String image;
  Location location;
  String latitude;
  String longitude;
  dynamic radius;
  String saudiId;
  dynamic iqamaId;
  dynamic cvrNo;
  List<dynamic> categoryId;
  dynamic stripeAccountId;
  dynamic appleId;
  dynamic fbId;
  String isNotify;
  String imageOne;
  String imageTwo;
  String imageThree;
  String imageFour;
  String imageFive;
  String imageSix;
  String hourlyRate;
  ToolboxInfo toolboxInfo;
  dynamic params;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  dynamic stripeId;
  dynamic cardBrand;
  dynamic cardLastFour;
  dynamic trialEndsAt;
  Role role;
  List<String> images;
  int profileProgressBar;

  factory TargetIdDetail.fromJson(Map<String, dynamic> json) => TargetIdDetail(
    id: json["id"],
    name: json["name"],
    mobile: json["mobile"],
    email: emailValues.map[json["email"]],
    gender: genderValues.map[json["gender"]],
    postalCode: json["postal_code"],
    description: json["description"],
    image: json["image"],
    location: locationValues.map[json["location"]],
    latitude: json["latitude"],
    longitude: json["longitude"],
    radius: json["radius"],
    saudiId: json["saudi_id"],
    iqamaId: json["iqama_id"],
    cvrNo: json["cvr_no"],
    categoryId: List<dynamic>.from(json["category_id"].map((x) => x)),
    stripeAccountId: json["stripe_account_id"],
    appleId: json["apple_id"],
    fbId: json["fb_id"],
    isNotify: json["is_notify"],
    imageOne: json["image_one"],
    imageTwo: json["image_two"],
    imageThree: json["image_three"],
    imageFour: json["image_four"],
    imageFive: json["image_five"],
    imageSix: json["image_six"],
    hourlyRate: json["hourly_rate"],
    toolboxInfo: toolboxInfoValues.map[json["toolbox_info"]],
    params: json["params"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    stripeId: json["stripe_id"],
    cardBrand: json["card_brand"],
    cardLastFour: json["card_last_four"],
    trialEndsAt: json["trial_ends_at"],
    role: Role.fromJson(json["role"]),
    images: List<String>.from(json["images"].map((x) => x)),
    profileProgressBar: json["profile_progress_bar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mobile": mobile,
    "email": emailValues.reverse[email],
    "gender": genderValues.reverse[gender],
    "postal_code": postalCode,
    "description": description,
    "image": image,
    "location": locationValues.reverse[location],
    "latitude": latitude,
    "longitude": longitude,
    "radius": radius,
    "saudi_id": saudiId,
    "iqama_id": iqamaId,
    "cvr_no": cvrNo,
    "category_id": List<dynamic>.from(categoryId.map((x) => x)),
    "stripe_account_id": stripeAccountId,
    "apple_id": appleId,
    "fb_id": fbId,
    "is_notify": isNotify,
    "image_one": imageOne,
    "image_two": imageTwo,
    "image_three": imageThree,
    "image_four": imageFour,
    "image_five": imageFive,
    "image_six": imageSix,
    "hourly_rate": hourlyRate,
    "toolbox_info": toolboxInfoValues.reverse[toolboxInfo],
    "params": params,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "stripe_id": stripeId,
    "card_brand": cardBrand,
    "card_last_four": cardLastFour,
    "trial_ends_at": trialEndsAt,
    "role": role.toJson(),
    "images": List<dynamic>.from(images.map((x) => x)),
    "profile_progress_bar": profileProgressBar,
  };
}

enum Email { PRINCE_GMAIL_COM }

final emailValues = EnumValues({
  "prince@gmail.com": Email.PRINCE_GMAIL_COM
});

enum Gender { MALE }

final genderValues = EnumValues({
  "male": Gender.MALE
});

enum Location { THE_209_KRISHNA_NAGAR_HOSHIARPUR_PUNJAB_146001_INDIA }

final locationValues = EnumValues({
  "209, Krishna Nagar, Hoshiarpur, Punjab 146001, India": Location.THE_209_KRISHNA_NAGAR_HOSHIARPUR_PUNJAB_146001_INDIA
});

enum ToolboxInfo { PC }

final toolboxInfoValues = EnumValues({
  "pc": ToolboxInfo.PC
});

enum Title { JOB_ACCEPTED, MESSAGE_FROM_CUSTOMER, MESSAGE_FROM_VIKAS, NEW_JOB, PROPOSAL_SENT, JOB_CONFIRMED }

final titleValues = EnumValues({
  "Job accepted": Title.JOB_ACCEPTED,
  "Job Confirmed": Title.JOB_CONFIRMED,
  "Message from Customer": Title.MESSAGE_FROM_CUSTOMER,
  "Message from Vikas": Title.MESSAGE_FROM_VIKAS,
  "New Job": Title.NEW_JOB,
  "Proposal sent!": Title.PROPOSAL_SENT
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
