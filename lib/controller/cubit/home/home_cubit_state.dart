// ignore_for_file: must_be_immutable

part of 'home_cubit_cubit.dart';

enum BannerStatus {
  initial,
  loading,
  loaded,
  error,
}

enum UrlStatus {
  initial,
  loading,
  loaded,
  error,
}

class HomeState extends Equatable {
  final List<Datum> banners;
  final BannerStatus bannerStatus;
  final UrlStatus urlStatus;
  final String liveUrl;
  const HomeState({
    required this.banners,
    required this.bannerStatus,
    required this.liveUrl,
    required this.urlStatus,
  });

  factory HomeState.initial() {
    return const HomeState(
      banners: [],
      bannerStatus: BannerStatus.initial,
      liveUrl: '',
      urlStatus: UrlStatus.initial,
    );
  }

  HomeState copyWith({
    List<Datum>? banners,
    BannerStatus? bannerStatus,
    UrlStatus? urlStatus,
    String? liveUrl,
  }) {
    return HomeState(
      banners: banners ?? this.banners,
      bannerStatus: bannerStatus ?? this.bannerStatus,
      liveUrl: liveUrl ?? this.liveUrl,
      urlStatus: urlStatus ?? this.urlStatus,
    );
  }

  @override
  List<Object> get props {
    return [
      banners,
      bannerStatus,
      urlStatus,
      liveUrl,
    ];
  }
}
