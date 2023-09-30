import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:OWPM/utils/colors.dart';

import 'helpers.dart';
import 'size.dart';

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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hor!),
      child: SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: onPressed,
          clipBehavior: Clip.hardEdge,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
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
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(
                  color: AppColors.white,
                )),
            elevation: 0,
            padding: padding,
            backgroundColor: AppColors.primary,
            disabledForegroundColor: AppColors.primary,
            disabledBackgroundColor: AppColors.primary,
          ),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}

class CommonButtonV1 extends StatefulWidget {
  final String label;
  final void Function()? onPressed;
  final Color? bgColor;
  final double? btnHeight;
  const CommonButtonV1(
      {super.key,
      required this.label,
      required this.onPressed,
      this.bgColor,
      this.btnHeight});

  @override
  State<CommonButtonV1> createState() => _CommonButtonV1State();
}

class _CommonButtonV1State extends State<CommonButtonV1> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: widget.btnHeight ?? 40,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          shadowColor: AppColors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: AppColors.btnV2,
          elevation: 4.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.play_circle_outline_rounded,
              size: 24,
              color: Colors.white,
            ),
            const SizeBoxV(h8),
            Text(
              widget.label,
              style: context.textTheme.labelMedium!.copyWith(
                color: AppColors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrimaryCommonButton extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  final Color? backgroundColor;
  final double? radius;
  const PrimaryCommonButton(
      {super.key,
      required this.onPressed,
      required this.label,
      this.radius,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: 46,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shadowColor: AppColors.btnV2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 15),
          ),
          backgroundColor: backgroundColor ?? AppColors.btnV2,
          elevation: 4.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Text(
              label,
              style: context.textTheme.titleMedium!.copyWith(
                color: AppColors.white,
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded)
          ],
        ),
      ),
    );
  }
}
