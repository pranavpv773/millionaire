import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:OWPM/app/app_images/app_images.dart';
import 'package:OWPM/utils/button.dart';
import 'package:OWPM/utils/helpers.dart';
import 'package:OWPM/utils/routes/app_routes.dart';
// ignore: depend_on_referenced_packages
import 'package:OWPM/utils/size.dart';

class TicketEmptyScreen extends StatelessWidget {
  const TicketEmptyScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: context.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(children: [
            Image.asset(
              AppImages.emptyPath,
              width: context.width / 2,
            ),
            const SizeBoxH(h2),
            Text(
              "No Ticket Found",
              style: context.textTheme.bodyLarge!.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizeBoxH(h4),
            Text(
              "Please buy Ticket",
              style: context.textTheme.bodyMedium,
            ),
            const SizeBoxH(32),
          ]),
          PrimaryCommonButton(
              onPressed: () {
                Get.toNamed(AppRoutes.buynowScreen);
              },
              label: 'BUY NOW'),
        ],
      ),
    );
  }
}
