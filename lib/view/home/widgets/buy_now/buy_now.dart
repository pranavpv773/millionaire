import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:millionaire_app/controller/cubit/home/home_cubit_cubit.dart';
import 'package:millionaire_app/utils/colors.dart';
import 'package:millionaire_app/utils/common_scaffold.dart';
import 'package:millionaire_app/utils/dialogs.dart';
import 'package:millionaire_app/utils/helpers.dart';
import 'package:millionaire_app/utils/size.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:millionaire_app/view/home/widgets/buy_now/wallet_recharge/wallet_controller.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart'; // Import the intl package

class BuyNowScreen extends StatefulWidget {
  const BuyNowScreen({super.key});

  @override
  State<BuyNowScreen> createState() => _BuyNowScreenState();
}

class _BuyNowScreenState extends State<BuyNowScreen> {
  @override
  void initState() {
    context.read<HomeCubit>().initPurchase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var headerStyle = context.textTheme.bodyMedium!.copyWith(
        color: AppColors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        wordSpacing: 0.10,
        letterSpacing: 0.6);
    var labelStyle = context.textTheme.labelMedium!.copyWith(
        color: AppColors.black,
        fontWeight: FontWeight.w400,
        fontSize: 14,
        wordSpacing: 0.10,
        letterSpacing: 0.6);
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return OverlayLoaderWithAppIcon(
        isLoading: state.purchaseTicketStatus == PurchaseTicketStatus.loading,
        appIconSize: 60,
        overlayBackgroundColor: AppColors.white,
        overlayOpacity: 0.9,
        circularProgressColor: AppColors.primary,
        appIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'asset/logos/logo.png',
            width: 60,
          ),
        ),
        child: CommonScaffoldWithAppbar(
          header: 'Buy Now',
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 600,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage(
                        "asset/logos/green certificate1.jpeg",
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizeBoxH(h10),
                Text(
                  "Green certificate",
                  style: headerStyle,
                ),
                const SizeBoxH(h10),
                Text(
                  "The Green Certificate you purchase is your contribution to the “Oasis Park”; O! Millionaire's Environmental Green Project.",
                  style: labelStyle,
                ),
                const SizeBoxH(h10),
                Container(
                  width: context.width,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.grey),
                  child: Center(
                    child: Text(
                      "Each Green Certificate has a unique code which is your entry for the Raffle Draw and the Grand Prize Match 7 Numbers Draw. ",
                      style: context.textTheme.bodyMedium!.copyWith(
                          color: AppColors.white,
                          wordSpacing: 0.10,
                          letterSpacing: 0.6),
                    ),
                  ),
                ),
                const SizeBoxH(h10),
                Text(
                  "If you buy one Green Certificate, you will have one entry to both draws. However, you will have two or more entries in the raffle draw if you buy two or more - and two or three more chances to win! ",
                  style: labelStyle,
                ),
                const SizeBoxH(h10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "asset/coin.png",
                      width: context.width / 20,
                    ),
                    Text(
                      " 20 Per Green Certificate",
                      style: headerStyle,
                    ),
                  ],
                ),
                const SizeBoxH(h10),
                SizedBox(
                  width: context.width,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      commonBottomSheetDialog(
                          context,
                          0.30,
                          0.30,
                          0.30,
                          BuyNowWidget(
                            ctxt: context,
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      shadowColor: AppColors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      backgroundColor: AppColors.primary.withOpacity(0.7),
                      elevation: 12.0,
                    ),
                    child: Text(
                      'BUY NOW',
                      style: context.textTheme.titleMedium!.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class BuyNowWidget extends StatelessWidget {
  final BuildContext ctxt;
  BuyNowWidget({super.key, required this.ctxt});
  final WalletController controller = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    var rowTextStyle = context.textTheme.bodyMedium!
        .copyWith(fontSize: 14, fontWeight: FontWeight.w400);
    final sundayDate = calculateUpcomingFirstSunday();
    String formattedSundayDate = DateFormat("dd MMM yyyy").format(sundayDate);
    String postDate = DateFormat('yyyy-MM-dd').format(sundayDate);
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Buy Now",
              style: context.textTheme.titleMedium!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizeBoxH(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Wallet balance:",
                  style: rowTextStyle,
                ),
                Row(
                  children: [
                    Image.asset(
                      "asset/coin.png",
                      width: context.width / 30,
                    ),
                    Text(
                      " ${state.walletData.balance ?? "0"}",
                      style: rowTextStyle,
                    ),
                  ],
                ),
              ],
            ),
            const SizeBoxH(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ticket price:",
                  style: rowTextStyle,
                ),
                Row(
                  children: [
                    Image.asset(
                      "asset/coin.png",
                      width: context.width / 30,
                    ),
                    Text(
                      " 20",
                      style: rowTextStyle,
                    ),
                  ],
                ),
              ],
            ),
            const SizeBoxH(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ticket draw date:",
                  style: rowTextStyle,
                ),
                Text(
                  formattedSundayDate,
                  style: rowTextStyle,
                ),
              ],
            ),
            const SizeBoxH(36),
            int.parse(state.walletData.balance ?? "0") >= 20
                ? CommonButtonNew(
                    onPressed: () {
                      Navigator.pop(context);
                      context.read<HomeCubit>().purchaseTicketFns(data: {
                        "number": [],
                        "date": postDate,
                        "password": ""
                      }, context: ctxt);
                    },
                    backgroundColor: AppColors.secondary.withOpacity(0.7),
                    label: "Check out")
                : CommonButtonNew(
                    onPressed: () {
                      Navigator.pop(context);
                      controller.makePaymentFromCheckout(ctxt, date: postDate);
                    },
                    backgroundColor: AppColors.primary.withOpacity(0.7),
                    label: "Recharge wallet")
          ],
        ),
      );
    });
  }

  DateTime calculateUpcomingFirstSunday() {
    DateTime now = DateTime.now();
    int daysUntilNextSunday = DateTime.sunday - now.weekday;

    if (daysUntilNextSunday <= 0) {
      daysUntilNextSunday += 7;
    }

    DateTime upcomingFirstSunday = now.add(Duration(days: daysUntilNextSunday));
    // String formattedDate = DateFormat('yyyy-MM-dd').format(upcomingFirstSunday);
    return upcomingFirstSunday;
  }
}

class CommonButtonNew extends StatelessWidget {
  final void Function()? onPressed;
  final Color? backgroundColor;
  final String label;
  const CommonButtonNew({
    super.key,
    required this.onPressed,
    required this.backgroundColor,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shadowColor: AppColors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          backgroundColor: backgroundColor,
          elevation: 12.0,
        ),
        child: Text(
          label,
          style: context.textTheme.titleMedium!.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16),
        ),
      ),
    );
  }
}
