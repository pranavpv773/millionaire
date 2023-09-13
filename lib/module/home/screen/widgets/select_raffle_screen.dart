import 'package:OWPM/app/app_images/app_images.dart';
import 'package:OWPM/module/home/cubit/controller/home_controller.dart';
import 'package:OWPM/module/home/cubit/home_cubit_cubit.dart';
import 'package:OWPM/utils/button.dart';
import 'package:OWPM/utils/colors.dart';
import 'package:OWPM/utils/common_scaffold.dart';
import 'package:OWPM/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

import 'buy_now_dialog.dart';

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
          floating: SizedBox(
            height: 60,
            width: context.width,
            child: PrimaryCommonButton(
              onPressed: () {
                if (controller.numberList.length < 7) {
                  Get.snackbar("Warning", "You have to select seven numbers",
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
                }
              },
              label: 'BUY NOW',
            ),
          ),
          header: 'Select Number',
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80.0),
            child: Obx(
              () => GridView.count(
                crossAxisCount: 5,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 8.0,
                children: List.generate(100, (index) {
                  return InkWell(
                    onTap: () => controller.addOrRemoveFromList(item: index),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: controller.numberList.contains(index)
                              ? Colors.amberAccent
                              : AppColors.white,
                          border: Border.all(color: Colors.black45),
                        ),
                        width: 60,
                        height: 60,
                        child: Center(
                          child: Text("$index"),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      );
    });
  }
}
