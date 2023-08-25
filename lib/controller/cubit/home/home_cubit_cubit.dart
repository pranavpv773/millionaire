// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millionaire_app/backend/api_urls.dart';
import 'package:millionaire_app/backend/model/home/banner_model.dart';
import 'package:millionaire_app/backend/model/home/get_wallet_model.dart';
import 'package:millionaire_app/backend/model/home/post_purchase_model.dart';
import 'package:millionaire_app/backend/services/home/home_services.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:millionaire_app/controller/cubit/my_tickets/ticket_cubit.dart';
part 'home_cubit_state.dart';

class HomeCubit extends Cubit<HomeState> with Endpoints {
  HomeServices services = HomeServices();
  HomeCubit() : super(HomeState.initial());

  getallBanners() async {
    emit(state.copyWith(bannerStatus: BannerStatus.loading));
    try {
      final list = await services.getbannersList();
      emit(
        state.copyWith(bannerStatus: BannerStatus.loaded, banners: list.data),
      );
      // ignore: deprecated_member_use
    } on DioError catch (_) {
      emit(state.copyWith(
        bannerStatus: BannerStatus.error,
      ));
    }
  }

  getUrl() async {
    emit(state.copyWith(urlStatus: UrlStatus.loading));
    try {
      final list = await services.getUrl();
      emit(state.copyWith(
          urlStatus: UrlStatus.loaded, liveUrl: list.data!.liveUrl.toString()));
      // ignore: deprecated_member_use
    } on DioError catch (_) {
      emit(state.copyWith(
        urlStatus: UrlStatus.error,
      ));
    }
  }

  getWalletBalance() async {
    emit(state.copyWith(walletBalanceStatus: WalletBalanceStatus.loading));
    try {
      final list = await services.getWalletBalance();
      emit(state.copyWith(
          walletBalanceStatus: WalletBalanceStatus.loaded,
          walletData: list.data));
      // ignore: deprecated_member_use
    } on DioError catch (_) {
      emit(state.copyWith(
        walletBalanceStatus: WalletBalanceStatus.error,
      ));
    }
  }

  initPurchase() {
    emit(state.copyWith(purchaseTicketStatus: PurchaseTicketStatus.loaded));
  }

  purchaseTicketFns(
      {required dynamic data, required BuildContext context}) async {
    emit(state.copyWith(purchaseTicketStatus: PurchaseTicketStatus.loading));
    try {
      final list = await services.postPurchaseTicketService(data: data);
      if (list.statusCode == 201) {
        getWalletBalance();
        emit(state.copyWith(
            purchaseTicketStatus: PurchaseTicketStatus.loaded,
            purchaseData: list.data));
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: 'Raffle Id: ${state.purchaseData.raffleId}',
          title: 'Ticket created successfully!',
          autoCloseDuration: const Duration(seconds: 5),
        );
        context.read<TicketCubit>().getMyTickets();
        getWalletBalance();
        // Get.toNamed(AppRoutes.landingScreen);
      } else {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: 'Unable to buy ticket!',
          autoCloseDuration: const Duration(seconds: 5),
        );
      }

      // ignore: deprecated_member_use
    } on DioError catch (_) {
      emit(state.copyWith(
        purchaseTicketStatus: PurchaseTicketStatus.error,
      ));
    }
  }
}
