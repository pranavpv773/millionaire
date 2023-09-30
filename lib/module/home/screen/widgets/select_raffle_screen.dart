import 'package:OWPM/app/app_images/app_images.dart';
import 'package:OWPM/module/home/cubit/controller/home_controller.dart';
import 'package:OWPM/module/home/cubit/home_cubit_cubit.dart';
import 'package:OWPM/module/home/screen/widgets/buy_now_dialog.dart';
import 'package:OWPM/utils/button.dart';
import 'package:OWPM/utils/colors.dart';
import 'package:OWPM/utils/common_scaffold.dart';
import 'package:OWPM/utils/dialogs.dart';
import 'package:OWPM/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

class SelectRaffleIdScreen extends StatefulWidget {
  const SelectRaffleIdScreen({super.key});

  @override
  State<SelectRaffleIdScreen> createState() => _SelectRaffleIdScreenState();
}

class _SelectRaffleIdScreenState extends State<SelectRaffleIdScreen> {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return OverlayLoaderWithAppIcon(
        isLoading: state.purchaseTicketStatus == PurchaseTicketStatus.loading,
        appIconSize: 60,
        overlayBackgroundColor: AppColors.white,
        overlayOpacity: 0.9,
        circularProgressColor: AppColors.primary,
        appIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            AppImages.logoPath,
            width: 60,
          ),
        ),
        child: CommonScaffoldWithAppbar(
          padding: 0,
          // floating: Padding(
          //   padding: const EdgeInsets.only(right: 8.0, left: 8, bottom: 8),
          //   child: Container(
          //     color: AppColors.transparent,
          //     height: 60,
          //     width: context.width,
          //     child: PrimaryCommonButton(
          //       radius: 30,
          //       backgroundColor: const Color(0xffEF476F),
          //       onPressed: () {
          //         if (controller.numberList.length < 7) {
          //           Get.snackbar("Warning", "You have to select seven numbers",
          //               snackPosition: SnackPosition.TOP);
          //         } else {
          //           commonBottomSheetDialog(
          //               context,
          //               0.40,
          //               0.40,
          //               0.40,
          //               BuyNowWidget(
          //                 ctxt: context,
          //               ));
          //         }
          //       },
          //       label: 'BUY NOW',
          //     ),
          //   ),
          // ),
          header: 'Select Number',
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 80.0, right: 16, left: 16, top: 16),
              child: Column(
                children: [
                  SizedBox(
                    width: context.width,
                    child: Obx(
                      () => GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 6,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 10.0,
                        children: List.generate(50, (index) {
                          return InkWell(
                            onTap: () =>
                                controller.addOrRemoveFromList(item: index),
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: controller.numberList.contains(index)
                                      ? AppColors.btnV2.withOpacity(0.7)
                                      : AppColors.primary.withOpacity(0.7),
                                  border: Border.all(
                                      color:
                                          controller.numberList.contains(index)
                                              ? AppColors.btnV2
                                              : AppColors.primary,
                                      width: 4),
                                ),
                                width: 48,
                                height: 48,
                                child: Center(
                                  child: Text(
                                    "$index",
                                    style: context.textTheme.displayMedium!
                                        .copyWith(
                                            color: AppColors.white,
                                            fontFamily: GoogleFonts.inriaSans()
                                                .fontFamily,
                                            fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  const SizeBoxH(20),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 8.0, left: 8, bottom: 8),
                    child: Container(
                      color: AppColors.transparent,
                      height: 60,
                      width: context.width,
                      child: PrimaryCommonButton(
                        radius: 30,
                        backgroundColor: const Color(0xffEF476F),
                        onPressed: () {
                          if (controller.numberList.length < 5) {
                            Get.snackbar(
                                "Warning", "You have to select five numbers",
                                snackPosition: SnackPosition.TOP);
                          } else {
                            commonBottomSheetDialog(
                                context,
                                0.40,
                                0.40,
                                0.40,
                                BuyNowWidget(
                                  ctxt: context,
                                ));
                            //   Get.toNamed(AppRoutes.paymentSheetScreen);
                          }
                        },
                        label: 'BUY NOW',
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
