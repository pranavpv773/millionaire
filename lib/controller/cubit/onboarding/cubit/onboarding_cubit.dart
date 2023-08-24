// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:millionaire_app/backend/api_urls.dart';
import 'package:millionaire_app/backend/model/login/onboarding_model.dart';
import 'package:millionaire_app/backend/services/onboarding/onbording_services.dart';
import 'package:millionaire_app/utils/animations/loading_overlay.dart';
import 'package:millionaire_app/utils/apppref.dart';
import 'package:millionaire_app/utils/routes/app_routes.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> with Endpoints {
  OnbaordingServices services = OnbaordingServices();
  OnboardingCubit() : super(OnboardingState.initial());

  onboardTheUser(BuildContext context) async {
    emit(state.copyWith(loginStatus: LoginStatus.loading));
    LoadingOverlay.of(context).show();
    try {
      final userOnboard = await services.userOnboarding(
        email: state.emailController.text,
        password: state.passwordController.text,
      );
      emit(
        state.copyWith(
          loginStatus: LoginStatus.loaded,
          onboardingData: userOnboard.data,
        ),
      );
      AppPref.userToken = state.onboardingData.accessToken.toString();
      LoadingOverlay.of(context).hide();
      Get.offAllNamed(AppRoutes.landingScreen);
      // ignore: deprecated_member_use
    } on DioError catch (_) {
      emit(state.copyWith(
        loginStatus: LoginStatus.error,
      ));
      LoadingOverlay.of(context).hide();
    }
  }
}
