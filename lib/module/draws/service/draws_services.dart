import 'dart:convert';
import 'package:OWPM/module/draws/model/prize_model.dart';
import 'package:dio/dio.dart';
import 'package:OWPM/backend/api_urls.dart';
import 'package:OWPM/module/draws/model/past_draws.dart';
import 'package:OWPM/utils/apppref.dart';

class DrawServices extends Endpoints {
  Future<PastDrawModel> getPastDrawsList() async {
    try {
      final response = await dio.get(
        pastDrawList,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${AppPref.userToken}',
          },
        ),
      );
      return pastDrawModelFromMap(jsonEncode(response.data));
    } catch (e) {
      rethrow;
    }
  }

  Future<PrizeModel> getPrizeList() async {
    try {
      final response = await dio.get(
        prizeList,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${AppPref.userToken}',
          },
        ),
      );
      return prizeModelFromMap(jsonEncode(response.data));
    } catch (e) {
      rethrow;
    }
  }
}
