// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:OWPM/app/extensions.dart';
import 'package:OWPM/module/claim/services/claim_services.dart';
import 'package:OWPM/utils/apppref.dart';
import 'package:bloc/bloc.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

part 'claim_state.dart';

class ClaimCubit extends Cubit<ClaimState> {
  ClaimServices services = ClaimServices();
  ClaimCubit() : super(ClaimState.initial());

  getcountryListFn() async {
    emit(state.copyWith(countryStatus: CountryStatus.loading));
    try {
      final list = await services.getCountryList();
      emit(
        state.copyWith(countryStatus: CountryStatus.loaded, countryList: list),
      );
      // ignore: deprecated_member_use
    } on DioError catch (_) {
      emit(state.copyWith(
        countryStatus: CountryStatus.error,
      ));
    }
  }

  getcountryBankListFn() async {
    emit(state.copyWith(bankStatus: BankStatus.loading));
    try {
      final list = await services.getCountryBankList();
      log("$list");
      emit(
        state.copyWith(bankStatus: BankStatus.loaded, bankList: list),
      );
      log("FINISHED ${state.bankList}}");
      // ignore: deprecated_member_use
    } on DioError catch (_) {
      emit(state.copyWith(
        bankStatus: BankStatus.error,
      ));
    }
  }

  getcliamFn(BuildContext context) async {
    emit(state.copyWith(claimTicketStatus: ClaimTicketStatus.loading));
    try {
      DateTime now = DateTime.now();

      // Format the date in the desired format
      String formattedDate = DateFormat('yyyy-MM-dd').format(now);

      final list = await services.postClaimBankDetails(body: {
        "raffle_id": state.raffleIdCntrllr.text,
        "country": AppPref.countryName,
        "bank_name": AppPref.bankName,
        "i_ban": state.ibanCntrllr.text,
        "current_date": formattedDate,
      });
      log("$list");
      emit(
        state.copyWith(
          claimTicketStatus: ClaimTicketStatus.loaded,
        ),
      );
      CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          title: "Error",
          textTextStyle: context.textTheme.bodyMedium!.copyWith(
            color: Colors.black,
          ),
          titleTextStyle: context.textTheme.bodyMedium!.copyWith(
            color: Colors.green,
          ),
          text: '${list.data['data']['message']}',
          autoCloseDuration: const Duration(seconds: 3),
          closeOnConfirmBtnTap: true);
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: "Error",
          textTextStyle: context.textTheme.bodyMedium!.copyWith(
            color: Colors.black,
          ),
          titleTextStyle: context.textTheme.bodyMedium!.copyWith(
            color: Colors.red,
          ),
          text: '${e.response!.data['data']['message']}',
          autoCloseDuration: const Duration(seconds: 3),
          closeOnConfirmBtnTap: true);
      emit(state.copyWith(
        claimTicketStatus: ClaimTicketStatus.error,
      ));
    }
  }

  postCliamBankDetailsFn() async {
    emit(state.copyWith(claimBankStatus: ClaimBankStatus.loading));
    try {
      final list =
          await services.postClaimTicket(raffleId: state.raffleIdCntrllr.text);
      log("$list");
      emit(
        state.copyWith(
          claimBankStatus: ClaimBankStatus.loaded,
        ),
      );
      // ignore: deprecated_member_use
    } on DioError {
      emit(state.copyWith(
        claimBankStatus: ClaimBankStatus.error,
      ));
    }
  }

  clearState() {
    emit(state.copyWith(
      claimTicketStatus: ClaimTicketStatus.initial,
      bankCntrllr: TextEditingController(text: ''),
      countryCntrllr: TextEditingController(text: ''),
      ibanCntrllr: TextEditingController(text: ''),
      raffleIdCntrllr: TextEditingController(text: ''),
      bankList: [],
    ));
  }
}
