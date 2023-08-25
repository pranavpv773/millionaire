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

enum WalletBalanceStatus {
  initial,
  loading,
  loaded,
  error,
}

enum PurchaseTicketStatus {
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
  final WalletBalanceStatus walletBalanceStatus;
  final WalletData walletData;
  final PurchaseTicketStatus purchaseTicketStatus;
  final PurchaseData purchaseData;
  const HomeState({
    required this.banners,
    required this.bannerStatus,
    required this.liveUrl,
    required this.urlStatus,
    required this.walletBalanceStatus,
    required this.walletData,
    required this.purchaseData,
    required this.purchaseTicketStatus,
  });

  factory HomeState.initial() {
    return HomeState(
      banners: const [],
      bannerStatus: BannerStatus.initial,
      liveUrl: '',
      urlStatus: UrlStatus.initial,
      walletBalanceStatus: WalletBalanceStatus.initial,
      walletData: WalletData(),
      purchaseData: PurchaseData(),
      purchaseTicketStatus: PurchaseTicketStatus.initial,
    );
  }

  HomeState copyWith({
    List<Datum>? banners,
    BannerStatus? bannerStatus,
    UrlStatus? urlStatus,
    String? liveUrl,
    WalletBalanceStatus? walletBalanceStatus,
    WalletData? walletData,
    PurchaseTicketStatus? purchaseTicketStatus,
    PurchaseData? purchaseData,
  }) {
    return HomeState(
      banners: banners ?? this.banners,
      bannerStatus: bannerStatus ?? this.bannerStatus,
      liveUrl: liveUrl ?? this.liveUrl,
      urlStatus: urlStatus ?? this.urlStatus,
      walletBalanceStatus: walletBalanceStatus ?? this.walletBalanceStatus,
      walletData: walletData ?? this.walletData,
      purchaseData: purchaseData ?? this.purchaseData,
      purchaseTicketStatus: purchaseTicketStatus ?? this.purchaseTicketStatus,
    );
  }

  @override
  List<Object> get props {
    return [
      banners,
      bannerStatus,
      urlStatus,
      liveUrl,
      walletBalanceStatus,
      walletData,
      purchaseData,
      purchaseTicketStatus,
    ];
  }
}
