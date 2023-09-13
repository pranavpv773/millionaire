import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:OWPM/app/app_images/app_images.dart';
import 'package:OWPM/module/home/cubit/home_cubit_cubit.dart';
import 'package:OWPM/utils/colors.dart';
import 'package:OWPM/utils/shimmers.dart';
import 'package:OWPM/utils/size.dart';

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
        toolbarHeight: 66,
        actions: [
          BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: state.walletBalanceStatus == WalletBalanceStatus.loading
                  ? ShimmerText(
                      height: 30,
                      width: 60,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                          Text(
                            "Wallet",
                            style: context.textTheme.bodySmall!.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.90),
                          ),
                          const SizeBoxH(8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: Center(
                                  child: Image.asset(
                                    AppImages.coinPath,
                                  ),
                                ),
                              ),
                              Text(
                                " ${state.walletData.balance.toString()}",
                                style: context.textTheme.bodySmall!.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.90),
                              ),
                            ],
                          ),
                        ]),
            );
          }),
        ],
        backgroundColor: AppColors.primary,
        leadingWidth: 200,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                AppImages.logoPath,
                width: 30,
              ),
              const SizeBoxV(h8),
              Text(
                "OWPM",
                style: context.textTheme.displayMedium!.copyWith(
                    color: Colors.amber, fontSize: 16, letterSpacing: 2),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: widget.child,
      ),
    );
  }
}

class CommonScaffoldWithAppbar extends StatefulWidget {
  final Widget child;
  final String header;
  final Widget? floating;
  final double? padding;
  const CommonScaffoldWithAppbar({
    super.key,
    required this.header,
    required this.child,
    this.padding,
    this.floating,
  });

  @override
  State<CommonScaffoldWithAppbar> createState() =>
      _CommonScaffoldWithAppbarState();
}

class _CommonScaffoldWithAppbarState extends State<CommonScaffoldWithAppbar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.floating ?? const SizedBox.shrink(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        leadingWidth: 32,
        title: Text(widget.header),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: EdgeInsets.all(widget.padding ?? 16.0),
        child: widget.child,
      ),
    );
  }
}
