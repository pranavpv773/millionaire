import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:OWPM/app/app_images/app_images.dart';
import 'package:OWPM/utils/colors.dart';
import 'package:OWPM/utils/helpers.dart';
import 'package:OWPM/utils/size.dart';

class TimeCountWidget extends StatelessWidget {
  final String count;
  final String text;
  const TimeCountWidget({super.key, required this.count, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: context.textTheme.bodySmall!
              .copyWith(fontWeight: FontWeight.w600, color: AppColors.black),
        ),
        const SizeBoxH(h8),
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage(
            AppImages.blueBallPath,
          ),
          foregroundColor: AppColors.transparent,
          backgroundColor: AppColors.transparent,
          child: Text(
            count,
            style: context.textTheme.labelMedium!.copyWith(
                color: AppColors.white,
                fontSize: 26,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
