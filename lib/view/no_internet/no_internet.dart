import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:millionaire_app/controller/cubit/splash/splash_controller.dart';
import 'package:millionaire_app/utils/button.dart';
import 'package:millionaire_app/utils/colors.dart';
import 'package:millionaire_app/utils/helpers.dart';
import 'package:millionaire_app/utils/routes/app_routes.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  final SplashController controller = Get.put(SplashController());
  bool checkingButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashController>(builder: (_) {
        return SizedBox(
          width: context.width,
          height: context.height,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'asset/no_internet.png',
                  width: context.width / 2,
                ),
                const SizeBoxH(16),
                Text(
                  "No internet connection!",
                  style: context.textTheme.bodyMedium!.copyWith(
                      color: const Color.fromARGB(255, 31, 31, 31),
                      fontWeight: FontWeight.w800,
                      fontSize: 18),
                ),
                const SizeBoxH(16),
                Text(
                  "Please check your internet connect and try again",
                  style: context.textTheme.titleMedium!.copyWith(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
                const SizeBoxH(16),
                CommonButton(
                  onPressed: () {
                    changeScreen(
                      context,
                    );
                  },
                  bgColor: const Color.fromARGB(234, 234, 78, 67),
                  child: controller.isLoad
                      ? const CircularProgressIndicator()
                      : Text(
                          "Try again",
                          style: context.textTheme.titleMedium!.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  Future<void> changeScreen(BuildContext context) async {
    final check = await checking();

    if (check) {
      Get.offAllNamed(AppRoutes.loginOrHome);
    } else {
      Get.snackbar("No internet", "Please check your internet",
          snackPosition: SnackPosition.TOP);
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
