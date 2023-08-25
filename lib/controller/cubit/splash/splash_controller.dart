import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:millionaire_app/utils/routes/app_routes.dart';

class SplashController extends GetxController {
  bool checkingButton = false;
  bool isLoad = false;
  Future<void> changeScreen(BuildContext context,
      {required bool isFromNoInternet}) async {
    final check = await checking(isFromNoInternet: isFromNoInternet);
    log(check.toString());
    if (!isFromNoInternet) {
      await Future.delayed(
        const Duration(seconds: 6),
      );
    }
    if (check) {
      Get.offAllNamed(AppRoutes.loginOrHome);
    } else {
      Get.offAllNamed(AppRoutes.noInternetScreen);
    }
  }

  Future<bool> checking({required bool isFromNoInternet}) async {
    checkingButton = true;
    if (isFromNoInternet) {
      isLoad = true;
    }
    update();
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        update();
        return true;
      }
      return false;
    } on SocketException catch (_) {
      update();
      return false;
    }
  }
}
