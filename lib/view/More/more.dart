import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:millionaire_app/controller/cubit/draws/draws_cubit.dart';
import 'package:millionaire_app/controller/cubit/global_screen/global_screen_cubit.dart';
import 'package:millionaire_app/controller/cubit/home/home_cubit_cubit.dart';
import 'package:millionaire_app/controller/cubit/my_tickets/ticket_cubit.dart';
import 'package:millionaire_app/controller/cubit/onboarding/cubit/onboarding_cubit.dart';
import 'package:millionaire_app/utils/apppref.dart';
import 'package:millionaire_app/utils/button.dart';
import 'package:millionaire_app/utils/colors.dart';
import 'package:millionaire_app/utils/common_scaffold.dart';
import 'package:millionaire_app/utils/dialogs.dart';
import 'package:millionaire_app/utils/helpers.dart';
import 'package:millionaire_app/utils/routes/app_routes.dart';
import 'package:millionaire_app/utils/size.dart';

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
    return CommonScaffold(
        child: Column(
      children: [
        const SizeBoxH(h32),
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
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.grey.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.white),
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
                      } else if (index == 2) {
                        commonBottomSheetDialog(context, 0.30, 0.30, 0.30,
                            const LogoutDialogChild());
                      }
                      // else if (index == 1) {
                      //   Get.toNamed(AppRoutes.howtoUseScreen);
                      // }
                    },
                  ),
                ),
              ),
            );
          },
        )
      ],
    ));
  }
}

class LogoutDialogChild extends StatelessWidget {
  const LogoutDialogChild({
    Key? key,
    this.widget,
  }) : super(key: key);
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Are you sure you want to logout?',
            style: context.textTheme.displaySmall!.copyWith(fontSize: 24),
          ),
          const SizeBoxH(30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizeBoxV(10),
              CommonButtonSecondary(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 2),
                onPressed: () {
                  AppPref.userToken = '';
                  Get.offAllNamed(AppRoutes.loginOrHome);
                  context.read<BottomNavCubit>().clearState();
                  context.read<HomeCubit>().clearState();
                  context.read<DrawsCubit>().clearState();
                  context.read<TicketCubit>().clearState();
                  context.read<OnboardingCubit>().clearState();
                },
                child: Text(
                  'Yes',
                  style: context.textTheme.labelMedium,
                ),
              ),

              widget ??
                  CommonButton(
                    bgColor: AppColors.primary,
                    labelColor: AppColors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 2),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'No',
                      style: context.textTheme.labelLarge!
                          .copyWith(color: AppColors.white),
                    ),
                  )
            ],
          )
        ],
      ),
    );
  }
}
