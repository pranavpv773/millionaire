import 'dart:convert';
import 'package:OWPM/backend/api_urls.dart';
import 'package:OWPM/module/onboarding/model/onboarding_model.dart';

class OnbaordingServices extends Endpoints {
  Future<OnBoardingModel> userOnboarding(
      {required String email, required String password}) async {
    final response = await dio.post(
      onboardUser,
      data: {"email": email, "password": password},
    );
    final body = onBoardingModelFromMap(jsonEncode(response.data));
    return body;
  }

  Future signUpOnboarding({
    required dynamic data,
  }) async {
    final response = await dio.post(
      onboardSignUpUser,
      data: data,
    );
    final body = response.data;
    return body;
  }

  Future verifyOtpOnboarding({
    required dynamic data,
  }) async {
    final response = await dio.post(
      verifyOtpOnboard,
      data: data,
    );
    final body = response.data;
    return body;
  }
}
