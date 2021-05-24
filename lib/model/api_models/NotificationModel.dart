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
//     this.data,
//     this.error
//   });
//
//   bool status;
//   int code;
//   Data data;
//   String error;
//
//   factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
//     status: json["status"],
//     code: json["code"],
//     data: json["data"] != null &&
//         (json["data"] as Map<String, dynamic>).isNotEmpty
//         ? Data.fromJson(json["data"])
//         : null,
//     error: json["error"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "code": code,
//     "data": data.toJson(),
//     "error": error,
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
//   String nextPageUrl;
//   String path;
//   int perPage;
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
//   String id;
//   Title title;
//   String body;
//   String message;
//   String targetId;
//   String createdBy;
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
//     title: titleValues.map[json["title"]],
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
//     "title": titleValues.reverse[title],
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
//   String targetId;
//   TargetModel targetModel;
//   DataType dataType;
//
//   factory BookingDetail.fromJson(Map<String, dynamic> json) => BookingDetail(
//     targetId: json["target_id"],
//     targetModel: targetModelValues.map[json["target_model"]],
//     dataType: dataTypeValues.map[json["data_type"]],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "target_id": targetId,
//     "target_model": targetModelValues.reverse[targetModel],
//     "data_type": dataTypeValues.reverse[dataType],
//   };
// }
//
// enum DataType { JOB }
//
// final dataTypeValues = EnumValues({
//   "Job": DataType.JOB
// });
//
// enum TargetModel { JOB_COMPLETED, JOB_PROCESSING, JOB_ACCEPTED, JOB_CONFIRMED }
//
// final targetModelValues = EnumValues({
//   "Job-accepted": TargetModel.JOB_ACCEPTED,
//   "Job-completed": TargetModel.JOB_COMPLETED,
//   "Job-confirmed": TargetModel.JOB_CONFIRMED,
//   "Job-processing": TargetModel.JOB_PROCESSING
// });
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
//   CustomerDetailName name;
//   String image;
//   Role role;
//   List<dynamic> images;
//   int profileProgressBar;
//
//   factory CustomerDetail.fromJson(Map<String, dynamic> json) => CustomerDetail(
//     id: json["id"],
//     name: customerDetailNameValues.map[json["name"]],
//     image: json["image"],
//     role: Role.fromJson(json["role"]),
//     images: List<dynamic>.from(json["images"].map((x) => x)),
//     profileProgressBar: json["profile_progress_bar"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": customerDetailNameValues.reverse[name],
//     "image": image,
//     "role": role.toJson(),
//     "images": List<dynamic>.from(images.map((x) => x)),
//     "profile_progress_bar": profileProgressBar,
//   };
// }
//
// enum CustomerDetailName { TASKER, SWATI }
//
// final customerDetailNameValues = EnumValues({
//   "swati": CustomerDetailName.SWATI,
//   "Tasker": CustomerDetailName.TASKER
// });
//
// class Role {
//   Role({
//     this.name,
//     this.id,
//     this.permission,
//   });
//
//   RoleName name;
//   int id;
//   List<dynamic> permission;
//
//   factory Role.fromJson(Map<String, dynamic> json) => Role(
//     name: roleNameValues.map[json["name"]],
//     id: json["id"],
//     permission: List<dynamic>.from(json["permission"].map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "name": roleNameValues.reverse[name],
//     "id": id,
//     "permission": List<dynamic>.from(permission.map((x) => x)),
//   };
// }
//
// enum RoleName { SERVICEPROVIDER, CUSTOMER }
//
// final roleNameValues = EnumValues({
//   "customer": RoleName.CUSTOMER,
//   "serviceprovider": RoleName.SERVICEPROVIDER
// });
//
// enum Title { JOB_COMPLETED, JOB_STARTED, JOB_STATUS, JOB_CONFIRMED }
//
// final titleValues = EnumValues({
//   "Job Completed": Title.JOB_COMPLETED,
//   "Job Confirmed": Title.JOB_CONFIRMED,
//   "Job Started": Title.JOB_STARTED,
//   "Job Status": Title.JOB_STATUS
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
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
  });

  bool status;
  int code;
  Data data;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
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
  dynamic nextPageUrl;
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
    bookingDetail: BookingDetail.fromJson(json["booking_detail"]),
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
    "booking_detail": bookingDetail.toJson(),
    "customer_detail": customerDetail.toJson(),
  };
}

class BookingDetail {
  BookingDetail({
    this.targetId,
    this.targetModel,
    this.dataType,
    this.jobId,
    this.status,
  });

  dynamic targetId;
  TargetModel targetModel;
  TargetModel dataType;
  int jobId;
  Status status;

  factory BookingDetail.fromJson(Map<String, dynamic> json) => BookingDetail(
    targetId: json["target_id"],
    targetModel: targetModelValues.map[json["target_model"]],
    dataType: json["data_type"] == null ? null : targetModelValues.map[json["data_type"]],
    jobId: json["job_id"] == null ? null : json["job_id"],
    status: json["status"] == null ? null : statusValues.map[json["status"]],
  );

  Map<String, dynamic> toJson() => {
    "target_id": targetId,
    "target_model": targetModelValues.reverse[targetModel],
    "data_type": dataType == null ? null : targetModelValues.reverse[dataType],
    "job_id": jobId == null ? null : jobId,
    "status": status == null ? null : statusValues.reverse[status],
  };
}

enum TargetModel { JOB_PROCESSING, JOB_COMPLETED, JOB_ACCEPTED, JOB_CONFIRMED, JOB }

final targetModelValues = EnumValues({
  "Job": TargetModel.JOB,
  "Job-accepted": TargetModel.JOB_ACCEPTED,
  "Job-completed": TargetModel.JOB_COMPLETED,
  "Job-confirmed": TargetModel.JOB_CONFIRMED,
  "Job-processing": TargetModel.JOB_PROCESSING
});

enum Status { PROCESSING, CONFIRMED, ACCEPTED, COMPLETED }

final statusValues = EnumValues({
  "accepted": Status.ACCEPTED,
  "completed": Status.COMPLETED,
  "confirmed": Status.CONFIRMED,
  "processing": Status.PROCESSING
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
  CustomerDetailName name;
  String image;
  Role role;
  List<dynamic> images;
  int profileProgressBar;

  factory CustomerDetail.fromJson(Map<String, dynamic> json) => CustomerDetail(
    id: json["id"],
    name: customerDetailNameValues.map[json["name"]],
    image: json["image"],
    role: Role.fromJson(json["role"]),
    images: List<dynamic>.from(json["images"].map((x) => x)),
    profileProgressBar: json["profile_progress_bar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": customerDetailNameValues.reverse[name],
    "image": image,
    "role": role.toJson(),
    "images": List<dynamic>.from(images.map((x) => x)),
    "profile_progress_bar": profileProgressBar,
  };
}

enum CustomerDetailName { TASKER, SWATI, CUSTOMER }

final customerDetailNameValues = EnumValues({
  "Customer": CustomerDetailName.CUSTOMER,
  "swati": CustomerDetailName.SWATI,
  "Tasker": CustomerDetailName.TASKER
});

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

enum Title { JOB_STARTED, JOB_COMPLETED, JOB_STATUS, JOB_CONFIRMED, NEW_JOB }

final titleValues = EnumValues({
  "Job Completed": Title.JOB_COMPLETED,
  "Job Confirmed": Title.JOB_CONFIRMED,
  "Job Started": Title.JOB_STARTED,
  "Job Status": Title.JOB_STATUS,
  "New Job": Title.NEW_JOB
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
