import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:OWPM/backend/api_urls.dart';
import 'package:OWPM/module/my_tickets/model/my_tickets.dart';
import 'package:OWPM/utils/apppref.dart';

class TicketServices extends Endpoints {
  Future<MyTicketModel> myTicketApiService() async {
    log(AppPref.userToken);
    try {
      final response = await dio.get(
        myTickets,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${AppPref.userToken}',
          },
        ),
      );
      final body = myTicketModelFromMap(jsonEncode(response.data));
      return body;
    } catch (e) {
      rethrow;
    }
  }
}
