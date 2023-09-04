import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

class UserModel {
  dynamic statusCode;
  Data? data;
  String? message;
  bool? status;

  UserModel({
    this.statusCode,
    this.data,
    this.message,
    this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        statusCode: json["statusCode"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
        status: json["status"],
      );
}

class Data {
  String? id;
  String? owpId;
  String? email;
  String? firstName;
  String? lastName;
  dynamic dob;
  String? communityId;
  String? tier;
  String? countryCode;
  String? countryName;
  dynamic mobileNumber;
  String? place;
  String? currency;
  String? roles;
  bool? isActive;
  bool? isDeleted;
  dynamic v;

  Data({
    this.id,
    this.owpId,
    this.email,
    this.firstName,
    this.lastName,
    this.dob,
    this.communityId,
    this.tier,
    this.countryCode,
    this.countryName,
    this.mobileNumber,
    this.place,
    this.currency,
    this.roles,
    this.isActive,
    this.isDeleted,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        owpId: json["owp_id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        dob: json["dob"],
        communityId: json["community_id"],
        tier: json["tier"],
        countryCode: json["country_code"],
        countryName: json["country_name"],
        mobileNumber: json["mobile_number"],
        place: json["place"],
        currency: json["currency"],
        roles: json["roles"],
        isActive: json["is_active"],
        isDeleted: json["is_deleted"],
        v: json["__v"],
      );
}
