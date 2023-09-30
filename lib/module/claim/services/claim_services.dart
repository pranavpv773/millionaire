import 'package:dio/dio.dart';
import 'package:OWPM/backend/api_urls.dart';
import 'package:OWPM/utils/apppref.dart';

class ClaimServices extends Endpoints {
  Future getCountryList() async {
    try {
      final response = await dio.get(
        "https://theowpc.com/api/world/get-bank-countries",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${AppPref.userToken}',
          },
        ),
      );
      print(response.data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future getCountryBankList() async {
    try {
      final response = await dio.get(
        "https://theowpc.com/api/world/get-banklist-by-country/${AppPref.countryName}",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${AppPref.userToken}',
          },
        ),
      );
      print(response.data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future postClaimTicket({required String raffleId}) async {
    try {
      final response = await dio.post(
        claimTicket,
        data: {"raffle_id": raffleId},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${AppPref.userToken}',
          },
        ),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future postClaimBankDetails({required dynamic body}) async {
    try {
      final response = await dio.post(
        claimBankDetails,
        data: body,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${AppPref.userToken}',
          },
        ),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
