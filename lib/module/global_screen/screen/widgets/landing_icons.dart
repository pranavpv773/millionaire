import 'package:OWPM/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class LandingIcons extends StatelessWidget {
  final IconData icons;
  final String title;
  final double size;
  final Color iconcolor;
  final Color? imageColor;
  final Color textcolor;
  final bool isImage;
  final String? image;
  const LandingIcons({
    Key? key,
    required this.icons,
    required this.title,
    required this.iconcolor,
    required this.textcolor,
    required this.size,
    required this.isImage,
    this.imageColor,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isImage
            ? Image.asset(
                image.toString(),
                width: 28,
                color: imageColor,
              )
            : Icon(
                icons,
                color: iconcolor,
              ),
        SizeBoxH(size),
        Text(
          title,
          style: context.textTheme.bodySmall!.copyWith(
            color: textcolor,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        )
      ],
    );
  }
}
