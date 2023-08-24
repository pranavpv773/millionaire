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
    await Future.delayed(
      const Duration(seconds: 8),
    );
    Get.offAllNamed(AppRoutes.loginOrHome);
    setState(() {});
  }
}
