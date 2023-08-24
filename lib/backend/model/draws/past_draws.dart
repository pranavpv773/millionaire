import 'dart:convert';

PastDrawModel pastDrawModelFromMap(String str) =>
    PastDrawModel.fromMap(json.decode(str));

String pastDrawModelToMap(PastDrawModel data) => json.encode(data.toMap());

class PastDrawModel {
  int? statusCode;
  List<PastDrawData>? data;
  String? message;
  bool? status;

  PastDrawModel({
    this.statusCode,
    this.data,
    this.message,
    this.status,
  });

  factory PastDrawModel.fromMap(Map<String, dynamic> json) => PastDrawModel(
        statusCode: json["statusCode"],
        data: json["data"] == null
            ? []
            : List<PastDrawData>.from(
                json["data"]!.map((x) => PastDrawData.fromMap(x))),
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

class PastDrawData {
  String? id;
  String? date;
  List<int>? winningNumber;
  String? raffleId;
  int? v;

  PastDrawData({
    this.id,
    this.date,
    this.winningNumber,
    this.raffleId,
    this.v,
  });

  factory PastDrawData.fromMap(Map<String, dynamic> json) => PastDrawData(
        id: json["_id"],
        date: json["date"],
        winningNumber: json["winning_number"] == null
            ? []
            : List<int>.from(json["winning_number"]!.map((x) => x)),
        raffleId: json["raffle_id"],
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "date": date,
        "winning_number": winningNumber == null
            ? []
            : List<dynamic>.from(winningNumber!.map((x) => x)),
        "raffle_id": raffleId,
        "__v": v,
      };
}
