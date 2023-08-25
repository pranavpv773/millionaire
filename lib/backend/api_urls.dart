import 'package:dio/dio.dart';

import 'interceptor.dart';

const String baseurl = 'http://3.6.123.80:3001/api';
const String walletBaseurl = 'http://13.234.42.189:3001/api/wallet';

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
  /* ONBOARDING */
  final onboardUser = "$baseurl/auth/login";
  /* HOME */
  final bannerlist = "$baseurl/banner";
  final getLiveUrl = "$baseurl/live-url/";
  final walletUrl = 'http://13.234.42.189:3001/api/wallet';
  /* DRAWS */
  final pastDrawList = "$baseurl/past-draws";
  /* MY TICKETS */
  final myTickets = "$baseurl/tickets";
  /* PURCHASE TICKET */
  final purchaseTicket = '$baseurl/tickets/purchase';
  /* WALLET */
  final getCoinCostUrl = '$walletBaseurl/get-cost';
  final validateTransaction = '$walletBaseurl/validate-transaction';
  final rechargeWalletUrl = '$walletBaseurl/recharge-wallet';
}
