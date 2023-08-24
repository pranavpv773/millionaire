import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:millionaire_app/backend/api_urls.dart';
import 'package:millionaire_app/backend/model/home/banner_model.dart';
import 'package:millionaire_app/backend/services/home/home_services.dart';

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
}
