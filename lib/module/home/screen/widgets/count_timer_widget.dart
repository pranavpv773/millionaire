import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:OWPM/app/app_images/app_images.dart';
import 'package:OWPM/module/home/cubit/controller/home_controller.dart';
import 'package:OWPM/module/home/cubit/home_cubit_cubit.dart';
import 'package:OWPM/utils/button.dart';
import 'package:OWPM/utils/colors.dart';
import 'package:OWPM/utils/helpers.dart';
import 'package:OWPM/utils/lauch_urls.dart';
import 'package:OWPM/utils/size.dart';

import 'time_count_widget.dart';

class CountTimerWidget extends StatelessWidget {
  final bool home;
  const CountTimerWidget({super.key, this.home = true});
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FittedBox(
            child: Container(
              width: context.width,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primary),
              child: Center(
                child: Row(
                  children: [
                    Text(
                      "Join The Draw Every Sunday At 8PM (UAE) ",
                      style: context.textTheme.labelMedium!.copyWith(
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                          color: AppColors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizeBoxV(h4),
                    Image.asset(
                      AppImages.uaeFlagPath,
                      width: 18,
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizeBoxH(h32),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TimeCountWidget(
                    count: "${controller.days.value}", text: 'DAYS'),
                // SizeBoxV(h8),
                TimeCountWidget(
                    count: "${controller.hours.value}", text: 'HOURS'),
                // SizeBoxV(h8),
                TimeCountWidget(
                    count: "${controller.minutes.value}", text: 'MIN'),
                // SizeBoxV(h8),
                TimeCountWidget(
                    count: "${controller.seconds.value}", text: 'SEC'),
              ],
            ),
          ),
          const SizeBoxH(h32),
          CommonButtonV1(
            label: 'Watch videos',
            onPressed: () => launchURLs(state.liveUrl),
          ),
          const SizeBoxH(8),
        ],
      );
    });
  }
}
