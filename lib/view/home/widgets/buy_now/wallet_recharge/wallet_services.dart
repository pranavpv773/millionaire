import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:millionaire_app/backend/api_urls.dart';
import 'package:millionaire_app/utils/apppref.dart';

class WalletServices with Endpoints {
//Get coin cost
  Future<Response> getCoinCost(dynamic body) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${AppPref.userToken}',
    };
    try {
      http.Response response = await http.post(Uri.parse(getCoinCostUrl),
          headers: headers, body: json.encode(body));
      log(response.statusCode.toString());
      log(response.body);
      return response;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

//get wallet
  Future<Response?> getWallet() async {
    try {
      http.Response response = await http.get(Uri.parse(walletUrl),
          headers: {'Authorization': 'Bearer ${AppPref.userToken}'});
      log("getWallet  : ${response.body}");
      return response;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

//recharge wallet
  Future<Response> rechargeWallet(dynamic body) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${AppPref.userToken}',
    };
    try {
      http.Response response = await http.post(Uri.parse(rechargeWalletUrl),
          headers: headers, body: json.encode(body));
      log(response.statusCode.toString());
      log(response.body);
      return response;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

//validate payment
  Future<Response> validatePayment(dynamic body) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${AppPref.userToken}',
    };
    try {
      http.Response response = await http.post(Uri.parse(validateTransaction),
          headers: headers, body: json.encode(body));
      log(response.statusCode.toString());
      log(response.body);
      return response;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
