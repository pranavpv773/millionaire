// ignore_for_file: depend_on_referenced_packages

import 'package:OWPM/module/home/cubit/controller/home_controller.dart';
import 'package:OWPM/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:OWPM/app/app_images/app_images.dart';
import 'package:OWPM/module/home/cubit/home_cubit_cubit.dart';
import 'package:OWPM/utils/button.dart';
import 'package:OWPM/utils/colors.dart';
import 'package:OWPM/utils/common_scaffold.dart';
import 'package:OWPM/utils/helpers.dart';
import 'package:OWPM/utils/size.dart';
import 'widgets/buy_now_dialog.dart';
import 'package:intl/intl.dart';

class BuyNowScreen extends StatefulWidget {
  const BuyNowScreen({super.key});

  @override
  State<BuyNowScreen> createState() => _BuyNowScreenState();
}

class _BuyNowScreenState extends State<BuyNowScreen> {
  @override
  void initState() {
    context.read<HomeCubit>().initPurchase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sundayDate = calculateUpcomingFirstSunday();
    String formattedSundayDate = DateFormat("dd MMM yyyy").format(sundayDate);
    final HomeController controller = Get.put(HomeController());

    var headerStyle = context.textTheme.bodyMedium!.copyWith(
        color: AppColors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        wordSpacing: 0.10,
        letterSpacing: 0.6);
    var labelStyle = context.textTheme.bodySmall!.copyWith(
      color: AppColors.black,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.2,
      fontSize: 14,
    );
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return CommonScaffold(
        // header: 'Buy Now',
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Green certificate",
                  style: headerStyle.copyWith(fontSize: 20),
                ),
                const SizeBoxH(h10),
                Text(
                  "The Green Certificate you purchase is your contribution to the OWPP, OWPM Environmental Green Project.",
                  style: labelStyle,
                ),
                Container(
                  height: 550,
                  width: context.width,
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(
                        AppImages.greenCertificatePath,
                      ),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                          top: 258,
                          left: 90,
                          child: Text(
                            formattedSundayDate,
                            style: labelStyle.copyWith(fontSize: 12),
                          )),
                    ],
                  ),
                ),
                const SizeBoxH(h10),
                Container(
                  width: context.width,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.greenV2),
                  child: Center(
                    child: Text(
                      "Each Green Certificate has a unique code which is your entry for the Raffle Draw and the Grand Prize Match 5 Numbers Draw. ",
                      style: context.textTheme.bodySmall!.copyWith(
                          color: AppColors.white,
                          fontSize: 14,
                          letterSpacing: 0.6),
                    ),
                  ),
                ),
                const SizeBoxH(h10),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    "If you buy one Green Certificate, you will have one entry to both draws. However, you will have two or more entries in the raffle draw if you buy two or more - and two or three more chances to win! ",
                    style: labelStyle,
                  ),
                ),
                const SizeBoxH(h10),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    r"$ 10 Per Green Certificate",
                    style: context.textTheme.displayMedium!
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizeBoxH(h15),
                PrimaryCommonButton(
                  onPressed: () {
                    controller.clearNumberList();
                    Get.toNamed(AppRoutes.selectNumberScreen);
                  },
                  label: 'SELECT NUMBER',
                ),
                const SizeBoxH(h15),
              ],
            ),
          ),
        ),
      );
    });
  }
}
