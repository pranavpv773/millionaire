import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:OWPM/app/app_images/app_images.dart';
import 'package:OWPM/module/home/cubit/home_cubit_cubit.dart';
import 'package:OWPM/utils/button.dart';
import 'package:OWPM/utils/colors.dart';
import 'package:OWPM/utils/common_scaffold.dart';
import 'package:OWPM/utils/dialogs.dart';
import 'package:OWPM/utils/helpers.dart';
import 'package:OWPM/utils/size.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'widgets/buy_now_dialog.dart';

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
            AppImages.logoPath,
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
                    image: DecorationImage(
                      image: AssetImage(
                        AppImages.greenCertificatePath,
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
                  "The Green Certificate you purchase is your contribution to the OWPP, OWPM Environmental Green Project.",
                  style: labelStyle,
                ),
                const SizeBoxH(h10),
                Container(
                  width: context.width,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.primary),
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
                    SizedBox(
                      height: 25,
                      width: 25,
                      child: Center(
                        child: Image.asset(
                          AppImages.coinPath,
                          width: context.width / 20,
                        ),
                      ),
                    ),
                    Text(
                      " 20 Per Green Certificate",
                      style: headerStyle,
                    ),
                  ],
                ),
                const SizeBoxH(h10),
                PrimaryCommonButton(
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
                  label: 'PURCHASE NOW',
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
