import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:millionaire_app/backend/api_urls.dart';
import 'package:millionaire_app/utils/apppref.dart';

import '../../model/home/banner_model.dart';

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
}