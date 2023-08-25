import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:millionaire_app/utils/button.dart';
import 'package:millionaire_app/utils/colors.dart';
import 'package:millionaire_app/utils/helpers.dart';

import 'wallet_controller.dart';

class CostOfCoinScreen extends StatelessWidget {
  const CostOfCoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WalletController controller = Get.put(WalletController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: SizedBox(
            width: context.width,
            child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizeBoxH(20),
                    controller.isCostZero.value == true
                        ? const Icon(Icons.arrow_back)
                        : const SizedBox(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizeBoxH(50),
                        const SizeBoxH(20),
                        SizedBox(
                          child: Image.asset(
                            "asset/logos/logo.png",
                            height: 100,
                          ),
                        ),
                        const SizeBoxH(10),
                        const Text(
                          "GET MORE COINS!", //How many coins do you want?
                        ),
                        const SizeBoxH(30),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CustomTextFieldWidget(
                              label: "How many coins do you want?",
                              controller: controller.numberOfCoinController,
                              keybordType: TextInputType.number),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CommonButton(
                              child: const Text("Confirm"),
                              onPressed: () {
                                controller.getCoinCost();
                              }),
                        ),
                        const SizeBoxH(30),
                        controller.isCostZero.value == true
                            ? const SizedBox()
                            : SizedBox(
                                // width: 50,
                                // height: 15,
                                child: Card(
                                  shadowColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 2,
                                  color: const Color(0xff52aaff),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "You Pay",
                                        ),
                                        const SizeBoxH(10),
                                        Obx(
                                          () => Text(
                                            "\$${controller.cost.toString()}",
                                            style: context.textTheme.bodySmall!
                                                .copyWith(
                                                    color: AppColors.white,
                                                    fontSize: 14),
                                            // style: customTextStyle(
                                            //     color: Constants.whitColor,
                                            //     size: 14.sp,
                                            //     weight: FontWeight.w800),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                        const SizeBoxH(20),
                      ],
                    ),
                  ],
                )),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              controller.isCostZero.value == true
                  ? const SizedBox()
                  : commonRectangleButton(
                      context: context,
                      action: () {
                        controller.numberOfCoinController.clear();
                        controller.isCostZero.value = true;
                        Get.back();
                      },
                      title: "Cancel"),
              controller.isCostZero.value == true
                  ? const SizedBox()
                  : commonRectangleButton(
                      context: context,
                      action: () async {
                        await controller.makePayment(context, "100", "INR");
                      },
                      title: "Continue")
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextFieldWidget extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final TextInputType? keybordType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final void Function()? onTap;
  const CustomTextFieldWidget({
    required this.label,
    required this.controller,
    required this.keybordType,
    this.validator,
    this.suffixIcon,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keybordType,
      validator: validator,
      autofocus: false,
      style:
          const TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
      onTap: onTap,
      decoration: InputDecoration(
        label: Text(label!),
        labelStyle: const TextStyle(fontSize: 12),
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }
}

ElevatedButton commonRectangleButton(
    {required BuildContext context,
    required VoidCallback action,
    required String title}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 10),
      backgroundColor: AppColors.primary.withOpacity(0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      textStyle: const TextStyle(fontSize: 23),
    ),
    onPressed: action,
    child: SizedBox(
      width: 100,
      height: 18,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ),
  );
}
