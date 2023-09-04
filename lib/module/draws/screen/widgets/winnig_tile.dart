import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:OWPM/app/app_images/app_images.dart';
import 'package:OWPM/utils/colors.dart';
import 'package:OWPM/utils/helpers.dart';
import 'package:OWPM/utils/size.dart';

// ignore: must_be_immutable
class WinningTileWidget extends StatelessWidget {
  final int index;
  WinningTileWidget({super.key, required this.index});
  List price = [
    'First prize',
    'Second prize',
    'Third prize',
    'Mega Raffle prize'
  ];
  List priceMoney = [
    r'$10,000.00',
    r'$5,000.00',
    r'$1,000.00',
    r'$10,000.00 per month',
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.secondary.withOpacity(0.5))),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.rewardPath,
                width: context.width * 0.3,
              ),
              Text(
                price[index],
                style: context.textTheme.bodyMedium!
                    .copyWith(color: Colors.grey, fontSize: 16),
              ),
              const SizeBoxH(h4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  priceMoney[index],
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium!.copyWith(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              )
            ]),
      ),
    );
  }
}
