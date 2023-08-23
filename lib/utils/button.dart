import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:millionaire_app/utils/colors.dart';

class CommonButton extends StatelessWidget {
  final String? label;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onPressed;
  final double textSize;
  final Color? labelColor;
  final Color bgColor;
  final Widget? child;
  final double? height;
  final double? hor;
  final double? width;
  final double elevation;
  final bool? isWidth;

  const CommonButton({
    required this.onPressed,
    this.label,
    this.child,
    this.isWidth = false,
    this.elevation = 0,
    this.padding = const EdgeInsets.all(14),
    this.textSize = 18.0,
    this.height = 50,
    this.labelColor,
    this.bgColor = const Color(0xff0CABDF),
    Key? key,
    this.width,
    this.hor = 16,
  })  : assert(child == null || label == null, "cannot assign both at once."),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hor!),
      child: context.width > 650
          ? SizedBox(
              height: height,
              width: isWidth == true
                  ? width
                  : context.width > 650
                      ? width ?? 400
                      : context.width,
              child: ElevatedButton(
                onPressed: onPressed,
                clipBehavior: Clip.hardEdge,
                style: ElevatedButton.styleFrom(
                  shadowColor: AppColors.primary.withOpacity(0.9),
                  elevation: elevation,
                  padding: padding,
                  backgroundColor: bgColor,
                  disabledForegroundColor: AppColors.white,
                  disabledBackgroundColor: AppColors.white,
                ),
                child: Center(
                  child: child,
                ),
              ),
            )
          : SizedBox(
              height: height,
              child: ElevatedButton(
                onPressed: onPressed,
                clipBehavior: Clip.hardEdge,
                style: ElevatedButton.styleFrom(
                  shadowColor: AppColors.primary.withOpacity(0.9),
                  elevation: elevation,
                  padding: padding,
                  backgroundColor: bgColor,
                  disabledForegroundColor: AppColors.white,
                  disabledBackgroundColor: AppColors.white,
                ),
                child: Center(
                  child: child,
                ),
              ),
            ),
    );
  }
}

class CommonButtonSecondary extends StatelessWidget {
  final String? label;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onPressed;
  final double textSize;
  final Color labelColor;
  final Color bgColor;
  final Widget? child;
  final double? height;

  const CommonButtonSecondary({
    required this.onPressed,
    this.label,
    this.child,
    this.padding = const EdgeInsets.all(14),
    this.textSize = 18.0,
    this.height = 50,
    this.labelColor = Colors.white,
    this.bgColor = const Color(0xff0CABDF),
    Key? key,
  })  : assert(child == null || label == null, "cannot assign both at once."),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: SizedBox(
        height: height,
        child: ElevatedButton(
          onPressed: onPressed,
          clipBehavior: Clip.hardEdge,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: AppColors.secondary)),
            elevation: 0,
            padding: padding,
            backgroundColor: AppColors.white,
            disabledForegroundColor: AppColors.white,
            disabledBackgroundColor: AppColors.white,
          ),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
