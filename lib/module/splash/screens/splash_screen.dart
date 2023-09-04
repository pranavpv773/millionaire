import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:OWPM/app/app_images/app_images.dart';
import 'package:OWPM/utils/colors.dart';
import 'package:OWPM/utils/helpers.dart';
import 'package:OWPM/utils/routes/app_routes.dart';
import 'package:OWPM/utils/size.dart';

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
        child: AnimationLimiter(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => SlideAnimation(
                verticalOffset: context.height,
                duration: const Duration(seconds: 3),
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: [
                Center(
                  child: Image.asset(
                    AppImages.logoPath,
                    width: context.width * 0.3,
                    height: context.width * 0.3,
                  ),
                ),
                const SizeBoxH(h12),
                Center(
                    child: RichText(
                  // Controls visual overflow
                  overflow: TextOverflow.clip,
                  text: TextSpan(
                    text: '',
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: "OWP",
                        style: context.textTheme.displayLarge!.copyWith(
                          color: AppColors.white,
                          letterSpacing: 5,
                        ),
                      ),
                      TextSpan(
                        text: 'Millionaire',
                        style: context.textTheme.displayLarge!.copyWith(
                          color: AppColors.secondary,
                          letterSpacing: 5,
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
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
