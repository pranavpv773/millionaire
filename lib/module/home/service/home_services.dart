import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:OWPM/backend/api_urls.dart';
import 'package:OWPM/module/home/model/banner_model.dart';
import 'package:OWPM/module/home/model/get_wallet_model.dart';
import 'package:OWPM/module/home/model/post_purchase_model.dart';
import 'package:OWPM/module/home/model/url_model.dart';
import 'package:OWPM/module/onboarding/model/user_model.dart';
import 'package:OWPM/utils/apppref.dart';

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

  Future<GetWalletModel> getWalletBalances() async {
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
    if (response.statusCode == 409) {}
    final body = postPurchaseModelFromMap(jsonEncode(response.data));
    return body;
  }
  /* USER INFO API SERVICES */

  Future<UserModel> userInfoService() async {
    try {
      final response = await dio.get(
        userInfo,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${AppPref.userToken}',
          },
        ),
      );
      return userModelFromJson(jsonEncode(response.data));
    } catch (e) {
      rethrow;
    }
  }
}
