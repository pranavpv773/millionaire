import 'dart:convert';

OnBoardingModel onBoardingModelFromMap(String str) =>
    OnBoardingModel.fromMap(json.decode(str));

String onBoardingModelToMap(OnBoardingModel data) => json.encode(data.toMap());

class OnBoardingModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? status;

  OnBoardingModel({
    this.statusCode,
    this.data,
    this.message,
    this.status,
  });

  factory OnBoardingModel.fromMap(Map<String, dynamic> json) => OnBoardingModel(
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
  String? accessToken;
  String? refreshToken;

  Data({
    this.accessToken,
    this.refreshToken,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toMap() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
      };
}
