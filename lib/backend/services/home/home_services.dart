import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:millionaire_app/backend/api_urls.dart';
import 'package:millionaire_app/backend/model/home/get_wallet_model.dart';
import 'package:millionaire_app/backend/model/home/post_purchase_model.dart';
import 'package:millionaire_app/utils/apppref.dart';

import '../../model/home/banner_model.dart';
import '../../model/home/url_model.dart';

class HomeServices extends Endpoints {
  Future<BannerModel> getbannersList() async {
    try {
      final response = await dio.get(
        bannerlist,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${AppPref.userToken}',
          },
        ),
      );
      final body = bannerModelFromJson(jsonEncode(response.data));
      return body;
    } catch (e) {
      rethrow;
    }
  }

  Future<GetUrlModel> getUrl() async {
    try {
      final response = await dio.get(
        getLiveUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${AppPref.userToken}',
          },
        ),
      );
      final body = getUrlModelFromMap(jsonEncode(response.data));
      return body;
    } catch (e) {
      rethrow;
    }
  }

  Future<GetWalletModel> getWalletBalance() async {
    try {
      final response = await dio.get(
        walletUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${AppPref.userToken}',
          },
        ),
      );
      final body = getWalletModelFromMap(jsonEncode(response.data));
      return body;
    } catch (e) {
      rethrow;
    }
  }

  Future<PostPurchaseModel> postPurchaseTicketService(
      {required dynamic data}) async {
    try {
      final response = await dio.post(
        purchaseTicket,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${AppPref.userToken}',
          },
        ),
      );
      final body = postPurchaseModelFromMap(jsonEncode(response.data));
      return body;
    } catch (e) {
      rethrow;
    }
  }
}
