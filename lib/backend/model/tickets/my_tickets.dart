import 'dart:convert';

MyTicketModel myTicketModelFromMap(String str) =>
    MyTicketModel.fromMap(json.decode(str));

String myTicketModelToMap(MyTicketModel data) => json.encode(data.toMap());

class MyTicketModel {
  int? statusCode;
  List<MyTicketData>? data;
  String? message;
  bool? status;

  MyTicketModel({
    this.statusCode,
    this.data,
    this.message,
    this.status,
  });

  factory MyTicketModel.fromMap(Map<String, dynamic> json) => MyTicketModel(
        statusCode: json["statusCode"],
        data: json["data"] == null
            ? []
            : List<MyTicketData>.from(
                json["data"]!.map((x) => MyTicketData.fromMap(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "statusCode": statusCode,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "message": message,
        "status": status,
      };
}

class MyTicketData {
  String? id;
  String? userId;
  String? raffleId;
  List<dynamic>? number;
  String? date;
  String? createdAt;
  String? updatedAt;
  int? v;

  MyTicketData({
    this.id,
    this.userId,
    this.raffleId,
    this.number,
    this.date,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory MyTicketData.fromMap(Map<String, dynamic> json) => MyTicketData(
        id: json["_id"],
        userId: json["user_id"],
        raffleId: json["raffle_id"],
        number: json["number"] == null
            ? []
            : List<dynamic>.from(json["number"]!.map((x) => x)),
        date: json["date"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "user_id": userId,
        "raffle_id": raffleId,
        "number":
            number == null ? [] : List<dynamic>.from(number!.map((x) => x)),
        "date": date,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "__v": v,
      };
}
