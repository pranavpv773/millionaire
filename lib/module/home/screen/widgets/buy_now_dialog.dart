import 'package:OWPM/module/home/cubit/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
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
    final HomeController hController = Get.put(HomeController());

    var rowTextStyle = context.textTheme.bodyMedium!.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.white,
    );
    final sundayDate = calculateUpcomingFirstSunday();
    String formattedSundayDate = DateFormat("dd MMM yyyy").format(sundayDate);
    String postDate = DateFormat('yyyy-MM-dd').format(sundayDate);
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Container(
        color: AppColors.primary,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Buy Now",
                style: context.textTheme.titleMedium!.copyWith(
                    fontSize: 16,
                    color: AppColors.white,
                    fontWeight: FontWeight.w600),
              ),
              const SizeBoxH(16),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     Text(
              //       "Wallet balance:",
              //       style: rowTextStyle,
              //     ),
              //     Row(
              //       children: [
              //         Image.asset(
              //           AppImages.coinPath,
              //           width: context.width / 30,
              //         ),
              //         Text(
              //           " ${state.walletData.balance ?? "0"}",
              //           style: rowTextStyle,
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              const SizeBoxH(14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Ticket price:",
                    style: rowTextStyle,
                  ),
                  Text(
                    r"$ 10",
                    style: rowTextStyle,
                  ),
                ],
              ),
              const SizeBoxH(14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
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
              const SizeBoxH(14),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Selected number:",
                      style: rowTextStyle,
                    ),
                    SizedBox(
                      height: 44.0,
                      child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            hController.numberList.length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Center(
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: AppColors.white,
                                      border:
                                          Border.all(color: AppColors.grey)),
                                  child: Text(
                                    // ignore: invalid_use_of_protected_member
                                    "${hController.numberList[index].toString()} ",
                                    style: rowTextStyle.copyWith(
                                        color: AppColors.black),
                                  ),
                                ),
                              ),
                            ),
                          )),
                    )
                  ],
                ),
              ),
              const SizeBoxH(36),
              PrimaryCommonButton(
                  onPressed: () {
                    Navigator.pop(context);
                    controller.makePaymentFromCheckout(ctxt,
                        date: postDate, numbers: hController.numberList);
                  },
                  label: "Check out")
            ],
          ),
        ),
      );
    });
  }
}

DateTime calculateUpcomingFirstSunday() {
  DateTime currentDate = DateTime.now();

  // Calculate the next 1st date of the month
  DateTime nextFirstDate = DateTime(currentDate.year, currentDate.month + 1, 1);

  return nextFirstDate;
}
