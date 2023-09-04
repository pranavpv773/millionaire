// To parse this JSON data, do
//
//     final getUrlModel = getUrlModelFromMap(jsonString);

import 'dart:convert';

GetUrlModel getUrlModelFromMap(String str) =>
    GetUrlModel.fromMap(json.decode(str));

String getUrlModelToMap(GetUrlModel data) => json.encode(data.toMap());

class GetUrlModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? status;

  GetUrlModel({
    this.statusCode,
    this.data,
    this.message,
    this.status,
  });

  factory GetUrlModel.fromMap(Map<String, dynamic> json) => GetUrlModel(
        statusCode: json["statusCode"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
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

class Data {
  String? id;
  int? v;
  String? liveUrl;

  Data({
    this.id,
    this.v,
    this.liveUrl,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["_id"],
        v: json["__v"],
        liveUrl: json["live_url"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "__v": v,
        "live_url": liveUrl,
      };
}
