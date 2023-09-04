import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:OWPM/app/app_images/app_images.dart';
import 'package:OWPM/module/home/cubit/home_cubit_cubit.dart';
import 'package:OWPM/utils/colors.dart';
import 'package:OWPM/utils/dialogs.dart';
import 'package:OWPM/utils/helpers.dart';
import 'package:OWPM/utils/routes/app_routes.dart';
import 'package:OWPM/utils/shimmers.dart';
import 'package:OWPM/utils/size.dart';

import 'widgets/logout_child.dart';

class MoreScreen extends StatelessWidget {
  MoreScreen({super.key});
  final List moreOption = [
    // 'My Wallet',
    'How to play',
    'Terms & Conditions',
    'Privacy Policy',
    'Logout'
  ];
  final List moreOptionIcons = [
    // Icons.wallet_rounded,
    Icons.info_rounded,
    Icons.assignment_rounded,
    Icons.privacy_tip_rounded,
    Icons.logout_rounded
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Scaffold(
          body: Column(
        children: [
          Container(
            color: AppColors.primary,
            width: context.width,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizeBoxH(40),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          image: AssetImage(AppImages.avatharPath))),
                ),
                const SizeBoxH(h8),
                state.userModelStatus == UserModelStatus.loading
                    ? SizedBox(
                        height: 26,
                        child: ShimmerText(height: 26),
                      )
                    : Text(
                        state.userModelStatus == UserModelStatus.error
                            ? ''
                            : "${state.userModel.data!.firstName.toString()} ${state.userModel.data!.lastName.toString()}",
                        style: context.textTheme.displayMedium!
                            .copyWith(color: AppColors.white),
                      ),
              ],
            ),
          ),
          // const SizeBoxH(h10),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: moreOption.length,
            separatorBuilder: (context, index) => const SizeBoxH(16),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.grey.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.white),
                    child: Center(
                      child: ListTile(
                        minLeadingWidth: context.width * 0.02,
                        leading: Icon(
                          moreOptionIcons[index],
                          size: 24,
                          color: index == 4
                              ? Colors.red.withOpacity(0.7)
                              : AppColors.primary.withOpacity(0.7),
                        ),
                        title: Text(
                          moreOption[index],
                          style: context.textTheme.titleMedium!
                              .copyWith(color: AppColors.grey, fontSize: 16),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 24,
                          color: AppColors.secondary.withOpacity(0.7),
                        ),
                        onTap: () {
                          if (index == 0) {
                            Get.toNamed(AppRoutes.howtoUseScreen);
                          } else if (index == 3) {
                            commonBottomSheetDialog(context, 0.30, 0.30, 0.30,
                                const LogoutDialogChild());
                          } else if (index == 2) {
                            Get.toNamed(AppRoutes.privacyPolicyScreen,
                                arguments: {
                                  'url':
                                      'https://adamtechnologies.github.io/AdamWeb/privacy.html'
                                });
                          } else if (index == 1) {
                            Get.toNamed(AppRoutes.privacyPolicyScreen,
                                arguments: {
                                  'url':
                                      'https://adamtechnologies.github.io/AdamWeb/termsAndConditions.html'
                                });
                          }
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ));
    });
  }
}
