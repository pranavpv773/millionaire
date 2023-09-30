import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:OWPM/app/app_images/app_images.dart';
import 'package:OWPM/utils/button.dart';
import 'package:OWPM/utils/colors.dart';
import 'package:OWPM/utils/helpers.dart';
import 'package:OWPM/utils/routes/app_routes.dart';
import 'package:OWPM/utils/size.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import 'buy_now_dialog.dart';

class BuyNowGreenCertificate extends StatelessWidget {
  const BuyNowGreenCertificate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final sundayDate = calculateUpcomingFirstSunday();
    String formattedSundayDate = DateFormat("dd MMM yyyy").format(sundayDate);

    return Container(
      color: AppColors.greenV2,
      child: Column(
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizeBoxH(h20),
                Text(
                  "Grand Prize",
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.yellowV2,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(
                  height: h8,
                ),
                Text(
                  "USD 10,000 * 12",
                  style: context.textTheme.bodyLarge!.copyWith(
                    color: AppColors.yellowV2,
                    fontSize: 28,
                  ),
                ),
              ]),
          const SizeBoxH(h20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              height: 600,
              width: context.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AppImages.greenCertificatePath,
                  ),
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: Stack(children: [
                Positioned(
                  top: 285,
                  left: 90,
                  child: Text(
                    formattedSundayDate,
                    style: context.textTheme.labelMedium!.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                        letterSpacing: 0.6),
                  ),
                ),
              ]),
            ),
          ),
          // const SizeBoxH(h20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: PrimaryCommonButton(
              radius: 15,
              onPressed: () {
                Get.toNamed(AppRoutes.buynowScreen);
              },
              label: 'BUY NOW',
            ),
          ),
        ],
      ),
    );
  }
}
