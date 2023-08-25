import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:millionaire_app/utils/colors.dart';
import 'package:millionaire_app/utils/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    changeScreen(context);
    super.initState();
  }

  bool checkingButton = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SizedBox(
        height: context.height,
        child: Center(
          child: Image.asset(
            'asset/logos/logo.png',
            width: context.width * 0.5,
            height: context.width * 0.5,
          ),
        ),
      ),
    );
  }

  Future<void> changeScreen(BuildContext context) async {
    final check = await checking();
    log(check.toString());
    await Future.delayed(
      const Duration(seconds: 5),
    );
    if (check) {
      Get.offAllNamed(AppRoutes.loginOrHome);
    } else {
      Get.offAllNamed(AppRoutes.noInternetScreen);
    }

    setState(() {});
  }

  Future<bool> checking() async {
    checkingButton = true;
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        log('connected');
        checkingButton = false;
        return true;
      }
      checkingButton = false;

      return false;
    } on SocketException catch (_) {
      log('not connected');
      checkingButton = false;

      return false;
    }
  }
}
