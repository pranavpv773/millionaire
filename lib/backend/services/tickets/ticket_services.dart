import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:millionaire_app/backend/api_urls.dart';
import 'package:millionaire_app/backend/model/tickets/my_tickets.dart';
import 'package:millionaire_app/utils/apppref.dart';

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
