import 'package:OWPM/app/app_images/app_images.dart';
import 'package:OWPM/utils/button.dart';
import 'package:OWPM/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../utils/size.dart';

class SplashSecondScreen extends StatelessWidget {
  const SplashSecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
              AppImages.logoPath,
            ))),
            width: 50,
            height: 52,
          ),
          const SizeBoxH(h8),
          Text(
            "ONE WORLD PEACE",
            style:
                context.textTheme.bodyLarge!.copyWith(color: Colors.amber[600]),
          ),
          const SizeBoxH(h4),
          Text(
            "MILLIONAIRE",
            style:
                context.textTheme.bodyLarge!.copyWith(color: Colors.amber[800]),
          ),
          CommonButton(label: 'LOGIN', onPressed: () {}),
          CommonButton(label: 'SIGN UP', onPressed: () {}),
        ],
      ),
    );
  }
}
