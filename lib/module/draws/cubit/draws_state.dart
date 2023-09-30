// ignore_for_file: must_be_immutable

part of 'draws_cubit.dart';

enum WinningStatus {
  initial,
  loading,
  loaded,
  error,
}

enum PastDrawStatus {
  initial,
  loading,
  loaded,
  error,
}

enum PrizeStatus {
  initial,
  loading,
  loaded,
  error,
}

class DrawsState extends Equatable {
  final WinningStatus winningStatus;
  final PastDrawStatus pastDrawStatus;
  final List<PastDrawData> pastDrawList;
  final List<PrizeData> priceList;
  final PrizeStatus prizeStatus;
  final int pastDrawLength;
  final String seePastDraw;
  const DrawsState({
    required this.priceList,
    required this.prizeStatus,
    required this.winningStatus,
    required this.pastDrawLength,
    required this.seePastDraw,
    required this.pastDrawList,
    required this.pastDrawStatus,
  });

  factory DrawsState.initial() {
    return const DrawsState(
      winningStatus: WinningStatus.initial,
      pastDrawLength: 3,
      seePastDraw: 'See all',
      pastDrawList: [],
      pastDrawStatus: PastDrawStatus.initial,
      priceList: [],
      prizeStatus: PrizeStatus.initial,
    );
  }

  DrawsState copyWith({
    WinningStatus? winningStatus,
    int? pastDrawLength,
    String? seePastDraw,
    List<PastDrawData>? pastDrawList,
    PastDrawStatus? pastDrawStatus,
    List<PrizeData>? priceList,
    PrizeStatus? prizeStatus,
  }) {
    return DrawsState(
      seePastDraw: seePastDraw ?? this.seePastDraw,
      winningStatus: winningStatus ?? this.winningStatus,
      pastDrawLength: pastDrawLength ?? this.pastDrawLength,
      pastDrawList: pastDrawList ?? this.pastDrawList,
      pastDrawStatus: pastDrawStatus ?? this.pastDrawStatus,
      priceList: priceList ?? this.priceList,
      prizeStatus: prizeStatus ?? this.prizeStatus,
    );
  }

  @override
  List<Object> get props {
    return [
      winningStatus,
      pastDrawLength,
      seePastDraw,
      pastDrawStatus,
      pastDrawList,
      priceList,
      prizeStatus,
    ];
  }
}
