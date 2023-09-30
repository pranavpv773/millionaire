import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:OWPM/utils/colors.dart';

class TimeCountWidget extends StatelessWidget {
  final String count;
  final String text;
  const TimeCountWidget({super.key, required this.count, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: 60,
      height: 112,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: AppColors.white),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          count,
          style: context.textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 35,
              color: AppColors.primary),
        ),
        Divider(
          color: AppColors.primary,
          thickness: 1.5,
        ),
        Text(
          text,
          style: context.textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.primary,
              letterSpacing: 0.6),
        ),
      ]),
    );
  }
}
