// To parse this JSON data, do
//
//     final claimCountryBank = claimCountryBankFromMap(jsonString);

import 'dart:convert';

List<ClaimCountryBank> claimCountryBankFromMap(String str) =>
    List<ClaimCountryBank>.from(
        json.decode(str).map((x) => ClaimCountryBank.fromMap(x)));

String claimCountryBankToMap(List<ClaimCountryBank> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ClaimCountryBank {
  String? id;
  String? branchBic;
  String? branchName;
  String? country;
  String? parentBranch;
  String? parentBranchName;
  String? fin;
  String? scoreFileActRealTime;
  String? scoreFileActStoreForward;

  ClaimCountryBank({
    this.id,
    this.branchBic,
    this.branchName,
    this.country,
    this.parentBranch,
    this.parentBranchName,
    this.fin,
    this.scoreFileActRealTime,
    this.scoreFileActStoreForward,
  });

  factory ClaimCountryBank.fromMap(Map<String, dynamic> json) =>
      ClaimCountryBank(
        id: json["_id"],
        branchBic: json["branch_BIC"],
        branchName: json["branch_name"],
        country: json["country"],
        parentBranch: json["parent_branch"],
        parentBranchName: json["parent_branch_name"],
        fin: json["FIN"],
        scoreFileActRealTime: json["SCORE_FileAct_Real Time"],
        scoreFileActStoreForward: json["SCORE_FileAct_Store_Forward"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "branch_BIC": branchBic,
        "branch_name": branchName,
        "country": country,
        "parent_branch": parentBranch,
        "parent_branch_name": parentBranchName,
        "FIN": fin,
        "SCORE_FileAct_Real Time": scoreFileActRealTime,
        "SCORE_FileAct_Store_Forward": scoreFileActStoreForward,
      };
}
