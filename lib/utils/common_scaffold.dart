import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:millionaire_app/utils/colors.dart';

import 'helpers.dart';

class CommonScaffold extends StatefulWidget {
  final Widget child;
  const CommonScaffold({
    super.key,
    required this.child,
  });
// Column(children: const [
//           Text("Wallet"),
//           SizeBoxH(8),
//           Text(r"$125445555"),
  // ]),
  @override
  State<CommonScaffold> createState() => _CommonScaffoldState();
}

class _CommonScaffoldState extends State<CommonScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Wallet",
                    style: context.textTheme.bodySmall!.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.90),
                  ),
                  const SizeBoxH(8),
                  Text(
                    r"$1,254",
                    style: context.textTheme.bodySmall!.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.90),
                  ),
                ]),
          ),
        ],
        backgroundColor: AppColors.primary,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Image.asset(
            'asset/logos/logo.png',
            width: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: widget.child,
      ),
    );
  }
}
