import 'dart:convert';
import 'package:millionaire_app/backend/api_urls.dart';
import 'package:millionaire_app/backend/model/login/onboarding_model.dart';

class OnbaordingServices extends Endpoints {
  Future<OnBoardingModel> userOnboarding(
      {required String email, required String password}) async {
    print(" SUCCESSS $email, $password");
    try {
      final response = await dio.post(
        onboardUser,
        data: {"email": email, "password": password},
      );
      print("${response.statusCode}");
      final body = onBoardingModelFromMap(jsonEncode(response.data));
      return body;
    } catch (e) {
      rethrow;
    }
  }
}
