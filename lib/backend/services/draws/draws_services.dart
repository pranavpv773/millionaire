import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:millionaire_app/backend/api_urls.dart';
import 'package:millionaire_app/backend/model/draws/past_draws.dart';
import 'package:millionaire_app/utils/apppref.dart';

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
      print("Past dr ${response.data}");
      final body = pastDrawModelFromMap(jsonEncode(response.data));
      return body;
    } catch (e) {
      rethrow;
    }
  }
}
