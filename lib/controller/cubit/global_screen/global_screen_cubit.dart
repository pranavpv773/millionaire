import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:millionaire_app/backend/api_urls.dart';
import 'package:millionaire_app/backend/services/home/home_services.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

part 'global_screen_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> with Endpoints {
  HomeServices services = HomeServices();
  BottomNavCubit() : super(BottomNavState.initial());

  void changeiconIndex(int value) {
    switch (value) {
      case 0:
        emit(state.copyWith(index: 0));
        break;
      case 1:
        emit(state.copyWith(index: 1));
        break;
      case 2:
        emit(state.copyWith(index: 2));
        break;
      case 3:
        emit(state.copyWith(index: 3));
        break;
      case 4:
        emit(state.copyWith(index: 4));

        break;

      default:
    }
  }

  clearState() {
    emit(state.copyWith(
        index: 0, controller: PersistentTabController(initialIndex: 0)));
  }
}
