// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:OWPM/backend/api_urls.dart';
import 'package:OWPM/module/home/model/banner_model.dart';
import 'package:OWPM/module/home/model/get_wallet_model.dart';
import 'package:OWPM/module/home/model/post_purchase_model.dart';
import 'package:OWPM/module/home/service/home_services.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:OWPM/module/my_tickets/cubit/ticket_cubit.dart';
import 'package:OWPM/module/onboarding/model/userModel.dart';
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

  /* USER MODEL */
  getUserModel() async {
    emit(state.copyWith(userModelStatus: UserModelStatus.loading));
    try {
      final list = await services.userInfoService();
      emit(state.copyWith(
          userModelStatus: UserModelStatus.loaded, userModel: list));
      // ignore: deprecated_member_use
    } on DioError catch (_) {
      emit(state.copyWith(
        userModelStatus: UserModelStatus.error,
      ));
    }
  }

  clearState() {
    emit(state.copyWith(
      banners: const [],
      bannerStatus: BannerStatus.initial,
      liveUrl: '',
      urlStatus: UrlStatus.initial,
      walletBalanceStatus: WalletBalanceStatus.initial,
      walletData: WalletData(),
      purchaseData: PurchaseData(),
      purchaseTicketStatus: PurchaseTicketStatus.initial,
      userModel: UserModel(),
      userModelStatus: UserModelStatus.initial,
    ));
  }
}
