import 'package:flutter/material.dart';

import 'colors.dart';

class CommonShadowContainer extends StatelessWidget {
  final Widget child;
  final double? padding;
  const CommonShadowContainer({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding ?? 16.0),
      child: Material(
        elevation: 12,
        borderRadius: BorderRadius.circular(10),
        shadowColor: AppColors.black,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: child,
        ),
      ),
    );
  }
}
