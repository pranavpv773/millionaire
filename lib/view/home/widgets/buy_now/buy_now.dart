import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:millionaire_app/utils/colors.dart';
import 'package:millionaire_app/utils/common_scaffold.dart';
import 'package:millionaire_app/utils/helpers.dart';
import 'package:millionaire_app/utils/routes/app_routes.dart';
import 'package:millionaire_app/utils/size.dart';

class BuyNowScreen extends StatefulWidget {
  const BuyNowScreen({super.key});

  @override
  State<BuyNowScreen> createState() => _BuyNowScreenState();
}

class _BuyNowScreenState extends State<BuyNowScreen> {
  @override
  Widget build(BuildContext context) {
    var headerStyle = context.textTheme.bodyMedium!.copyWith(
        color: AppColors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        wordSpacing: 0.10,
        letterSpacing: 0.6);
    var labelStyle = context.textTheme.labelMedium!.copyWith(
        color: AppColors.black,
        fontWeight: FontWeight.w400,
        fontSize: 14,
        wordSpacing: 0.10,
        letterSpacing: 0.6);
    return CommonScaffoldWithAppbar(
      header: 'Buy Now',
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 600,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage(
                    "asset/logos/green certificate1.jpeg",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizeBoxH(h10),
            Text(
              "Green certificate",
              style: headerStyle,
            ),
            const SizeBoxH(h10),
            Text(
              "The Green Certificate you purchase is your contribution to the “Oasis Park”; O! Millionaire's Environmental Green Project.",
              style: labelStyle,
            ),
            const SizeBoxH(h10),
            Container(
              width: context.width,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.grey),
              child: Center(
                child: Text(
                  "Each Green Certificate has a unique code which is your entry for the Raffle Draw and the Grand Prize Match 7 Numbers Draw. ",
                  style: context.textTheme.bodyMedium!.copyWith(
                      color: AppColors.white,
                      wordSpacing: 0.10,
                      letterSpacing: 0.6),
                ),
              ),
            ),
            const SizeBoxH(h10),
            Text(
              "If you buy one Green Certificate, you will have one entry to both draws. However, you will have two or more entries in the raffle draw if you buy two or more - and two or three more chances to win! ",
              style: labelStyle,
            ),
            const SizeBoxH(h10),
            Text(
              "AED 25.00 Per Green Certificate",
              style: headerStyle,
            ),
            const SizeBoxH(h10),
            SizedBox(
              width: context.width,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.buynowScreen);
                },
                style: ElevatedButton.styleFrom(
                  shadowColor: AppColors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  backgroundColor: AppColors.primary,
                  elevation: 12.0,
                ),
                child: Text(
                  'BUY NOW',
                  style: context.textTheme.titleMedium!.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
