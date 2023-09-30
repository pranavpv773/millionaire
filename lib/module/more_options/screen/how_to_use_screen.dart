import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:OWPM/utils/colors.dart';
import 'package:OWPM/utils/common_scaffold.dart';
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
        iconWidget: StepperIconWidget(
          isIcon: false,
          index: '01',
          icons: Icons.looks_one_outlined,
        ),
      ),
      StepperData(
        title: StepperText(
          "Buy now screen",
          textStyle: headerStyle,
        ),
        subtitle: StepperText(
            "After reading about Green Certificate, click on the Buy Now button below."),
        iconWidget: StepperIconWidget(
          isIcon: false,
          index: '02',
          icons: Icons.looks_two_outlined,
        ),
      ),
      StepperData(
        title: StepperText(
          "Buy now dialog box",
          textStyle: headerStyle,
        ),
        subtitle:
            StepperText("If you have coins, you can buy the ticket directly."),
        iconWidget: StepperIconWidget(
          isIcon: false,
          index: '03',
          icons: Icons.looks_3_outlined,
        ),
      ),
      StepperData(
        title: StepperText(
          "Buy now dialog box",
          textStyle: headerStyle,
        ),
        subtitle: StepperText(
            "If you don't have coins, you have to buy coins first and after that ticket would purchase automatically."),
        iconWidget: StepperIconWidget(
          isIcon: false,
          index: '04',
          icons: Icons.looks_4_outlined,
        ),
      ),
      StepperData(
        title: StepperText(
          "Ticket Puchased",
          textStyle: headerStyle,
        ),
        subtitle: StepperText(
            "After all these steps you would be able to see the tickets on my ticket screen."),
        iconWidget: StepperIconWidget(
          index: '5',
          icons: Icons.local_activity_outlined,
          isIcon: true,
        ),
      ),
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
          activeBarColor: AppColors.greenV2,
          inActiveBarColor: AppColors.greenV2,
          inverted: false,
          verticalGap: 40,
          activeIndex: 3,
          barThickness: 8,
        ),
      ),
    );
  }
}

class StepperIconWidget extends StatelessWidget {
  StepperIconWidget(
      {super.key,
      required this.icons,
      required this.index,
      required this.isIcon});
  final IconData? icons;
  bool isIcon;
  final String index;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: isIcon == false
          ? Center(
              child: Text(
              index,
              style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 24),
            ))
          : Icon(icons, color: Colors.white),
    );
  }
}
