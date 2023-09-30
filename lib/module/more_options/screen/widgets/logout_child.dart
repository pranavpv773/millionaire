import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:OWPM/module/draws/cubit/draws_cubit.dart';
import 'package:OWPM/module/global_screen/cubit/global_screen_cubit.dart';
import 'package:OWPM/module/home/cubit/home_cubit_cubit.dart';
import 'package:OWPM/module/my_tickets/cubit/ticket_cubit.dart';
import 'package:OWPM/module/onboarding/cubit/onboarding_cubit.dart';
import 'package:OWPM/utils/apppref.dart';
import 'package:OWPM/utils/button.dart';
import 'package:OWPM/utils/colors.dart';
import 'package:OWPM/utils/helpers.dart';
import 'package:OWPM/utils/routes/app_routes.dart';

class LogoutDialogChild extends StatelessWidget {
  const LogoutDialogChild({
    Key? key,
    this.widget,
  }) : super(key: key);
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Are you sure you want to logout?',
            style: context.textTheme.bodySmall!.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: AppColors.white,
            ),
          ),
          const SizeBoxH(36),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  style: context.textTheme.labelLarge!
                      .copyWith(color: AppColors.white),
                ),
              ),

              widget ??
                  CommonButton(
                    bgColor: AppColors.btnV2,
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
