import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:millionaire_app/utils/colors.dart';
import 'package:millionaire_app/utils/common_scaffold.dart';
import 'package:another_stepper/another_stepper.dart';

class HowToUseScreen extends StatefulWidget {
  const HowToUseScreen({super.key});

  @override
  State<HowToUseScreen> createState() => _HowToUseScreenState();
}

class _HowToUseScreenState extends State<HowToUseScreen> {
  @override
  Widget build(BuildContext context) {
    var headerStyle =
        context.textTheme.bodyMedium!.copyWith(color: AppColors.black);
    List<StepperData> stepperData = [
      StepperData(
          title: StepperText(
            "Home Screen",
            textStyle: headerStyle,
          ),
          subtitle:
              StepperText("Click on the buy now under the Green Certificate"),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.7),
                borderRadius: const BorderRadius.all(Radius.circular(30))),
            child: const Icon(Icons.looks_one_outlined, color: Colors.white),
          )),
      StepperData(
          title: StepperText("Buy now screen", textStyle: headerStyle),
          subtitle: StepperText(
              "After reading about Green Certificate, click on the Buy Now button below."),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.7),
                borderRadius: const BorderRadius.all(Radius.circular(30))),
            child: const Icon(Icons.looks_two_outlined, color: Colors.white),
          )),
      StepperData(
          title: StepperText("Buy now dialog box", textStyle: headerStyle),
          subtitle: StepperText(
              "If you have coins, you can buy the ticket directly."),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.7),
                borderRadius: const BorderRadius.all(Radius.circular(30))),
            child: const Icon(Icons.looks_3_outlined, color: Colors.white),
          )),
      StepperData(
          title: StepperText("Buy now dialog box", textStyle: headerStyle),
          subtitle: StepperText(
              "If you don't have coins, you have to buy coins first and after that ticket would purchase automatically."),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.7),
                borderRadius: const BorderRadius.all(Radius.circular(30))),
            child: const Icon(Icons.looks_4_outlined, color: Colors.white),
          )),
      StepperData(
          title: StepperText("Ticket Puchased", textStyle: headerStyle),
          subtitle: StepperText(
              "After all these steps you would be able to see the tickets on my ticket screen."),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.7),
                borderRadius: const BorderRadius.all(Radius.circular(30))),
            child:
                const Icon(Icons.local_activity_outlined, color: Colors.white),
          )),
    ];
    return CommonScaffoldWithAppbar(
      header: 'How to play',
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: AnotherStepper(
          stepperList: stepperData,
          stepperDirection: Axis.vertical,
          iconWidth: 50,
          iconHeight: 50,
          activeBarColor: AppColors.secondary.withOpacity(0.7),
          inActiveBarColor: AppColors.secondary.withOpacity(0.7),
          inverted: false,
          verticalGap: 40,
          activeIndex: 3,
          barThickness: 8,
        ),
      ),
    );
  }
}
