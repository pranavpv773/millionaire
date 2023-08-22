import 'package:dio/dio.dart';

import 'interceptor.dart';

const String baseurl = 'http://3.6.123.80:3001/api';

class Endpoints {
  void statuscode(Response<dynamic> response, double code) {
    if (response.statusCode != code) {
      throw Exception(response.data);
    }
  }

  Dio dio = Dio(BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(milliseconds: 12000),
      receiveTimeout: const Duration(milliseconds: 12000)))
    ..interceptors.add(ApiInterceptor());

  /* HOME */
  final bannerlist = "$baseurl/banner";
}
