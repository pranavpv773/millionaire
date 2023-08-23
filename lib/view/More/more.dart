import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:millionaire_app/utils/apppref.dart';
import 'package:millionaire_app/utils/button.dart';
import 'package:millionaire_app/utils/colors.dart';
import 'package:millionaire_app/utils/common_scaffold.dart';
import 'package:millionaire_app/utils/dialogs.dart';
import 'package:millionaire_app/utils/helpers.dart';
import 'package:millionaire_app/utils/size.dart';

class MoreScreen extends StatelessWidget {
  MoreScreen({super.key});
  final List moreOption = [
    'Tickets',
    'How to use',
    'Terms & Conditions',
    'Privacy policy',
    'Logout'
  ];
  final List moreOptionIcons = [
    Icons.local_attraction_rounded,
    Icons.info_outline_rounded,
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
          itemCount: 5,
          separatorBuilder: (context, index) => const SizeBoxH(h8),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(4),
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
                  title: Text(moreOption[index]),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 24,
                    color: AppColors.secondary.withOpacity(0.7),
                  ),
                  onTap: () {
                    if (index == 4) {
                      commonBottomSheetDialog(
                          context, 0.22, 0.22, 0.22, const LogoutDialogChild());
                    }
                  },
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
                  Get.offAllNamed('/');
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
                      print("object");
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
