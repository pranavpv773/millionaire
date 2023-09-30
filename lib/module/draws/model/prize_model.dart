// To parse this JSON data, do
//
//     final prizeModel = prizeModelFromMap(jsonString);

import 'dart:convert';

PrizeModel prizeModelFromMap(String str) =>
    PrizeModel.fromMap(json.decode(str));

class PrizeModel {
  int? statusCode;
  List<PrizeData>? data;
  String? message;
  bool? status;

  PrizeModel({
    this.statusCode,
    this.data,
    this.message,
    this.status,
  });

  factory PrizeModel.fromMap(Map<String, dynamic> json) => PrizeModel(
        statusCode: json["statusCode"],
        data:
            List<PrizeData>.from(json["data"].map((x) => PrizeData.fromMap(x))),
        message: json["message"],
        status: json["status"],
      );
}

class PrizeData {
  String? id;
  int? matchingCount;
  int? price;
  int? v;

  PrizeData({
    this.id,
    this.matchingCount,
    this.price,
    this.v,
  });

  factory PrizeData.fromMap(Map<String, dynamic> json) => PrizeData(
        id: json["_id"],
        matchingCount: json["matching_count"],
        price: json["price"],
        v: json["__v"],
      );
}
