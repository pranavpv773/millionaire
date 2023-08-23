import 'package:flutter/material.dart';
import 'package:millionaire_app/utils/colors.dart';

void commonBottomSheetDialog(BuildContext context, double max, double initial,
    double min, Widget child) {
  showModalBottomSheet(
    context: context, backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),

    isScrollControlled: true, // set this to true
    builder: (_) {
      return DraggableScrollableSheet(
        maxChildSize: max,
        initialChildSize: initial,
        minChildSize: min,
        expand: false,
        builder: (_, controller) {
          return Container(
            //color: Colors.black,
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              controller: controller,
              child: child,
            ),
          );
        },
      );
    },
  );
}
