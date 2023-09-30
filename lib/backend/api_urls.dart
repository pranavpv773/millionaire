import 'package:dio/dio.dart';

import 'interceptor.dart';

const String baseurl = 'http://3.6.123.80:3001/api';
const String walletBaseurl = 'http://13.234.42.189:3001/api/wallet';
const String imageBaseurl = 'http://54.238.10.51:3003';
const String baseurlV2 = 'http://54.238.10.51:3003/api';

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
  final onboardUser = "$baseurlV2/auth/login";
  final onboardSignUpUser = "$baseurlV2/auth/sign-up";
  final verifyOtpOnboard = "$baseurlV2/auth/verify-email";
  /* HOME */
  final bannerlist = "$baseurlV2/banner";
  final getLiveUrl = "$baseurlV2/live-url/";
  final walletUrl = 'http://13.234.42.189:3001/api/wallet';
  final userInfo = '$baseurlV2/user/profile';
  /* DRAWS */
  final pastDrawList = "$baseurlV2/past-draws";
  final prizeList = "$baseurlV2/prize";
  /* MY TICKETS */
  final myTickets = "$baseurlV2/tickets";
  /* PURCHASE TICKET */
  final purchaseTicket = '$baseurlV2/tickets/purchase';
  /* CLAIM */
  final claimTicket = '$baseurlV2/tickets/claim-ticket';
  final claimBankDetails = '$baseurlV2/claim/claim-ticket';
}
