import 'dart:convert';

PostPurchaseModel postPurchaseModelFromMap(String str) =>
    PostPurchaseModel.fromMap(json.decode(str));

String postPurchaseModelToMap(PostPurchaseModel data) =>
    json.encode(data.toMap());

class PostPurchaseModel {
  int? statusCode;
  PurchaseData? data;
  String? message;
  bool? status;

  PostPurchaseModel({
    this.statusCode,
    this.data,
    this.message,
    this.status,
  });

  factory PostPurchaseModel.fromMap(Map<String, dynamic> json) =>
      PostPurchaseModel(
        statusCode: json["statusCode"],
        data: json["data"] == null ? null : PurchaseData.fromMap(json["data"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "statusCode": statusCode,
        "data": data?.toMap(),
        "message": message,
        "status": status,
      };
}

class PurchaseData {
  String? message;
  String? error;
  int? statusCode;
  String? userId;
  String? raffleId;
  List<dynamic>? number;
  String? date;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? v;

  PurchaseData({
    this.userId,
    this.raffleId,
    this.number,
    this.date,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.message,
    this.error,
    this.statusCode,
  });

  factory PurchaseData.fromMap(Map<String, dynamic> json) => PurchaseData(
      userId: json["user_id"],
      raffleId: json["raffle_id"],
      number: json["number"] == null
          ? []
          : List<dynamic>.from(json["number"]!.map((x) => x)),
      date: json["date"],
      id: json["_id"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      v: json["__v"],
      message: json["message"],
      error: json["error"],
      statusCode: json["statusCode"]);

  Map<String, dynamic> toMap() => {
        "user_id": userId,
        "raffle_id": raffleId,
        "number":
            number == null ? [] : List<dynamic>.from(number!.map((x) => x)),
        "date": date,
        "_id": id,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "__v": v,
      };
}
