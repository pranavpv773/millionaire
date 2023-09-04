import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class LandingIcons extends StatelessWidget {
  final IconData icons;
  final String title;
  final Color iconcolor;
  final Color textcolor;
  const LandingIcons({
    Key? key,
    required this.icons,
    required this.title,
    required this.iconcolor,
    required this.textcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icons,
          color: iconcolor,
        ),
        Text(
          title,
          style: context.textTheme.bodySmall!.copyWith(
            color: textcolor,
          ),
        )
      ],
    );
  }
}
