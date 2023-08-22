// ignore_for_file: must_be_immutable

part of 'home_cubit_cubit.dart';

enum BannerStatus {
  initial,
  loading,
  loaded,
  error,
}

class HomeState extends Equatable {
  final List<Datum> banners;
  final BannerStatus bannerStatus;

  const HomeState({
    required this.banners,
    required this.bannerStatus,
  });

  factory HomeState.initial() {
    return const HomeState(
      banners: [],
      bannerStatus: BannerStatus.initial,
    );
  }

  HomeState copyWith({
    List<Datum>? banners,
    final BannerStatus? bannerStatus,
  }) {
    return HomeState(
      banners: banners ?? this.banners,
      bannerStatus: bannerStatus ?? this.bannerStatus,
    );
  }

  @override
  List<Object> get props {
    return [
      banners,
      bannerStatus,
    ];
  }
}
