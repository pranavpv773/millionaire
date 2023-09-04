// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:OWPM/backend/api_urls.dart';
import 'package:OWPM/module/onboarding/model/onboarding_model.dart';
import 'package:OWPM/module/onboarding/services/onbording_services.dart';
import 'package:OWPM/utils/animations/loading_overlay.dart';
import 'package:OWPM/utils/apppref.dart';
import 'package:OWPM/utils/routes/app_routes.dart';

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
    } on DioError catch (e) {
      LoadingOverlay.of(context).hide();
      emit(state.copyWith(
        loginStatus: LoginStatus.error,
      ));
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: "Error",
          textTextStyle: context.textTheme.bodyMedium!.copyWith(
            color: Colors.black,
          ),
          titleTextStyle: context.textTheme.bodyMedium!.copyWith(
            color: Colors.red,
          ),
          text: '${e.response!.data['data']['message']}',
          autoCloseDuration: const Duration(seconds: 3),
          closeOnConfirmBtnTap: true);
    }
  }

  validLoginEmail() {
    if (RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(state.emailController.text)) {
      emit(state.copyWith(isValidEmail: true));
    } else {
      emit(state.copyWith(isValidEmail: false));
    }
  }

  final numericRegex = RegExp(r'[0-9]');
  final specialchar = RegExp(r'[!@#\$&*~]');

  onPasswordChanged() {
    if (state.passwordController.text.length >= 8) {
      emit(state.copyWith(isValidPassword: true));
    } else {
      emit(state.copyWith(isValidPassword: false));
    }
  }

  onLoginFn({required BuildContext context}) async {
    await validLoginEmail();
    await onPasswordChanged();
    if (state.isValidEmail == true && state.isValidPassword == true) {
      onboardTheUser(context);
    }
  }

  clearState() {
    emit(state.copyWith(
      onboardingData: Data(),
      loginStatus: LoginStatus.initial,
      emailController: TextEditingController(),
      passwordController: TextEditingController(),
      isValidEmail: true,
      isValidPassword: true,
    ));
  }
}
