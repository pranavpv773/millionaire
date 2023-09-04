import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:OWPM/backend/api_urls.dart';
import 'package:OWPM/module/draws/model/past_draws.dart';
import 'package:OWPM/module/draws/service/draws_services.dart';

part 'draws_state.dart';

class DrawsCubit extends Cubit<DrawsState> with Endpoints {
  DrawServices services = DrawServices();
  DrawsCubit() : super(DrawsState.initial());

  getPastDraws() async {
    emit(state.copyWith(pastDrawStatus: PastDrawStatus.loading));
    try {
      final list = await services.getPastDrawsList();
      emit(
        state.copyWith(
            pastDrawStatus: PastDrawStatus.loaded, pastDrawList: list.data),
      );
      // ignore: deprecated_member_use
    } on DioError catch (_) {
      emit(state.copyWith(
        pastDrawStatus: PastDrawStatus.error,
      ));
    }
  }

  changePastDrawsLength() {
    if (state.seePastDraw == 'See all') {
      emit(state.copyWith(
          pastDrawLength: state.pastDrawList.length, seePastDraw: 'See less'));
    } else {
      emit(state.copyWith(pastDrawLength: 3, seePastDraw: 'See all'));
    }
  }

  clearState() {
    emit(state.copyWith(
      winningStatus: WinningStatus.initial,
      pastDrawLength: 3,
      seePastDraw: 'See all',
      pastDrawList: [],
      pastDrawStatus: PastDrawStatus.initial,
    ));
  }
}
