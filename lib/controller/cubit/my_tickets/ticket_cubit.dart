// ignore_for_file: deprecated_member_use

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:millionaire_app/backend/api_urls.dart';
import 'package:millionaire_app/backend/model/tickets/my_tickets.dart';
import 'package:millionaire_app/backend/services/tickets/ticket_services.dart';
part 'ticket_state.dart';

class TicketCubit extends Cubit<TicketState> with Endpoints {
  TicketServices services = TicketServices();
  TicketCubit() : super(TicketState.initial());

  getMyTickets() async {
    emit(state.copyWith(myticketStatus: MyTicketStatus.loading));
    try {
      final list = await services.myTicketApiService();
      emit(
        state.copyWith(
            myticketStatus: MyTicketStatus.loaded, myTickets: list.data),
      );
      // ignore: deprecated_member_uses
    } on DioError catch (_) {
      emit(state.copyWith(
        myticketStatus: MyTicketStatus.error,
      ));
    }
  }
}
