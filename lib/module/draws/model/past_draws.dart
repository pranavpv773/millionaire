// To parse this JSON data, do
//
//     final pastDrawModel = pastDrawModelFromMap(jsonString);

import 'dart:convert';

PastDrawModel pastDrawModelFromMap(String str) =>
    PastDrawModel.fromMap(json.decode(str));

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
        data: List<PastDrawData>.from(
            json["data"].map((x) => PastDrawData.fromMap(x))),
        message: json["message"],
        status: json["status"],
      );
}

class PastDrawData {
  String? id;
  String? date;
  List<int>? winningNumbers;
  int? fiveMatch;
  int? fourMatch;
  int? threeMatch;
  String? raffleId;
  int? v;

  PastDrawData({
    this.id,
    this.date,
    this.winningNumbers,
    this.fiveMatch,
    this.fourMatch,
    this.threeMatch,
    this.raffleId,
    this.v,
  });

  factory PastDrawData.fromMap(Map<String, dynamic> json) => PastDrawData(
        id: json["_id"],
        date: json["date"],
        winningNumbers: List<int>.from(json["winning_numbers"].map((x) => x)),
        fiveMatch: json["five_match"],
        fourMatch: json["four_match"],
        threeMatch: json["three_match"],
        raffleId: json["raffle_id"],
        v: json["__v"],
      );
}
