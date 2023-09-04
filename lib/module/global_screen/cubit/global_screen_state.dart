// ignore_for_file: must_be_immutable

part of 'global_screen_cubit.dart';

class BottomNavState extends Equatable {
  final int index;
  final PersistentTabController controller;

  const BottomNavState({
    required this.index,
    required this.controller,
  });

  factory BottomNavState.initial() {
    return BottomNavState(
      index: 0,
      controller: PersistentTabController(
        initialIndex: 0,
      ),
    );
  }
  @override
  List<Object> get props => [
        index,
        controller,
      ];

  BottomNavState copyWith({int? index, PersistentTabController? controller}) {
    return BottomNavState(
      index: index ?? this.index,
      controller: controller ?? this.controller,
    );
  }
}
