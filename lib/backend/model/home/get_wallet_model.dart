import 'dart:convert';

GetWalletModel getWalletModelFromMap(String str) =>
    GetWalletModel.fromMap(json.decode(str));

String getWalletModelToMap(GetWalletModel data) => json.encode(data.toMap());

class GetWalletModel {
  dynamic statusCode;
  WalletData? data;
  String? message;
  bool? status;

  GetWalletModel({
    this.statusCode,
    this.data,
    this.message,
    this.status,
  });

  factory GetWalletModel.fromMap(Map<String, dynamic> json) => GetWalletModel(
        statusCode: json["statusCode"],
        data: json["data"] == null ? null : WalletData.fromMap(json["data"]),
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

class WalletData {
  String? id;
  String? userId;
  String? balance;
  String? currency;
  bool? status;
  String? createdAt;
  String? updatedAt;
  dynamic v;
  dynamic worth;

  WalletData({
    this.id,
    this.userId,
    this.balance,
    this.currency,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.worth,
  });

  factory WalletData.fromMap(Map<String, dynamic> json) => WalletData(
        id: json["_id"],
        userId: json["user_id"],
        balance: json["balance"],
        currency: json["currency"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        v: json["__v"],
        worth: json["worth"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "user_id": userId,
        "balance": balance,
        "currency": currency,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "__v": v,
        "worth": worth,
      };
}
