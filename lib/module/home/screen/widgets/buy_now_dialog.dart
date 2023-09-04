import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:OWPM/app/app_images/app_images.dart';
import 'package:OWPM/module/home/cubit/home_cubit_cubit.dart';
import 'package:OWPM/utils/button.dart';
import 'package:OWPM/utils/colors.dart';
import 'package:OWPM/utils/helpers.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:OWPM/module/global_screen/cubit/wallet_controller.dart';
// Import the intl package

class BuyNowWidget extends StatelessWidget {
  final BuildContext ctxt;
  BuyNowWidget({super.key, required this.ctxt});
  final WalletController controller = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    var rowTextStyle = context.textTheme.bodyMedium!
        .copyWith(fontSize: 14, fontWeight: FontWeight.w400);
    final sundayDate = calculateUpcomingFirstSunday();
    String formattedSundayDate = DateFormat("dd MMM yyyy").format(sundayDate);
    String postDate = DateFormat('yyyy-MM-dd').format(sundayDate);
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Buy Now",
              style: context.textTheme.titleMedium!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizeBoxH(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Wallet balance:",
                  style: rowTextStyle,
                ),
                Row(
                  children: [
                    Image.asset(
                      AppImages.coinPath,
                      width: context.width / 30,
                    ),
                    Text(
                      " ${state.walletData.balance ?? "0"}",
                      style: rowTextStyle,
                    ),
                  ],
                ),
              ],
            ),
            const SizeBoxH(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ticket price:",
                  style: rowTextStyle,
                ),
                Row(
                  children: [
                    Image.asset(
                      AppImages.coinPath,
                      width: context.width / 30,
                    ),
                    Text(
                      " 20",
                      style: rowTextStyle,
                    ),
                  ],
                ),
              ],
            ),
            const SizeBoxH(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ticket draw date:",
                  style: rowTextStyle,
                ),
                Text(
                  formattedSundayDate,
                  style: rowTextStyle,
                ),
              ],
            ),
            const SizeBoxH(36),
            int.parse(state.walletData.balance ?? "0") >= 20
                ? PrimaryCommonButton(
                    onPressed: () {
                      Navigator.pop(context);
                      context.read<HomeCubit>().purchaseTicketFns(data: {
                        "number": [],
                        "date": postDate,
                        "password": ""
                      }, context: ctxt);
                    },
                    label: "Check out")
                : PrimaryCommonButton(
                    onPressed: () {
                      Navigator.pop(context);
                      controller.makePaymentFromCheckout(ctxt, date: postDate);
                    },
                    backgroundColor: AppColors.primary.withOpacity(0.7),
                    label: "Recharge wallet")
          ],
        ),
      );
    });
  }

  DateTime calculateUpcomingFirstSunday() {
    DateTime now = DateTime.now();
    int daysUntilNextSunday = DateTime.sunday - now.weekday;
    if (daysUntilNextSunday <= 0) {
      daysUntilNextSunday += 7;
    }
    DateTime upcomingFirstSunday = now.add(Duration(days: daysUntilNextSunday));
    return upcomingFirstSunday;
  }
}
