import 'package:OWPM/module/claim/cubit/claim_cubit.dart';
import 'package:OWPM/module/claim/screen/claim.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:OWPM/module/global_screen/cubit/global_screen_cubit.dart';
import 'package:OWPM/module/home/cubit/home_cubit_cubit.dart';
import 'package:OWPM/utils/colors.dart';
import 'package:OWPM/module/more_options/screen/more.dart';
import 'package:OWPM/module/my_tickets/screen/tickets.dart';
import 'package:OWPM/module/home/screen/home_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../home/screen/buy_now.dart';
import 'widgets/landing_icons.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  void initState() {
    context.read<HomeCubit>().getWalletBalance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<BottomNavCubit>(context);

    return BlocBuilder<BottomNavCubit, BottomNavState>(
      builder: (context, state) {
        return Scaffold(
            body: Container(
          alignment: Alignment.center,
          child: SizedBox(
            width: context.width,
            child: PersistentTabView(
              context,
              onItemSelected: (value) {
                cubit.changeiconIndex(value);
                print(value);
                if (value == 3) {
                  context.read<ClaimCubit>().clearState();
                }
              },
              controller: state.controller,
              navBarHeight: 76,
              padding: const NavBarPadding.symmetric(vertical: 15),
              screens: _buildScreens(),
              items: [
                presistentBottomNavBar(
                  state.index == 0
                      ? LandingIcons(
                          isImage: true,
                          image: 'asset/v2/home.png',
                          size: 2,
                          icons: Icons.home_outlined,
                          title: 'Home',
                          iconcolor: AppColors.primary,
                          imageColor: AppColors.primary,
                          textcolor: AppColors.primary,
                        )
                      : LandingIcons(
                          isImage: true,
                          image: 'asset/v2/home.png',
                          size: 4,
                          icons: Icons.home_outlined,
                          title: 'Home',
                          iconcolor: AppColors.primary.withOpacity(0.6),
                          textcolor: AppColors.primary.withOpacity(0.6),
                          imageColor: AppColors.primary.withOpacity(0.6),
                        ),
                ),
                presistentBottomNavBar(
                  state.index == 1
                      ? LandingIcons(
                          isImage: true,
                          image: 'asset/v2/movie-tickets (1).png',
                          size: 2,
                          icons: Icons.local_attraction_outlined,
                          title: 'Tickets',
                          iconcolor: AppColors.primary,
                          textcolor: AppColors.primary,
                          imageColor: AppColors.primary,
                        )
                      : LandingIcons(
                          isImage: true,
                          image: 'asset/v2/movie-tickets (1).png',
                          size: 4,
                          icons: Icons.local_attraction_outlined,
                          title: 'Tickets',
                          iconcolor: AppColors.primary.withOpacity(0.6),
                          textcolor: AppColors.primary.withOpacity(0.6),
                          imageColor: AppColors.primary.withOpacity(0.6),
                        ),
                ),
                presistentBottomNavBar(
                  state.index == 2
                      ? LandingIcons(
                          image: 'asset/v2/claim.png',
                          isImage: false,
                          size: 2,
                          icons: Icons.diamond_rounded,
                          title: 'BUY NOW',
                          iconcolor: AppColors.primary,
                          textcolor: AppColors.primary,
                          imageColor: AppColors.primary,
                        )
                      : LandingIcons(
                          image: 'asset/v2/payment-method (2).png',
                          isImage: false,
                          size: 4,
                          icons: Icons.diamond_rounded,
                          title: 'BUY NOW',
                          iconcolor: AppColors.primary.withOpacity(0.6),
                          textcolor: AppColors.primary.withOpacity(0.6),
                        ),
                ),
                presistentBottomNavBar(
                  state.index == 3
                      ? LandingIcons(
                          image: 'asset/v2/claim.png',
                          isImage: true,
                          size: 2,
                          icons: Icons.diamond,
                          title: 'Claim',
                          iconcolor: AppColors.primary,
                          textcolor: AppColors.primary,
                        )
                      : LandingIcons(
                          image: 'asset/v2/claim.png',
                          isImage: true,
                          size: 4,
                          icons: Icons.diamond,
                          title: 'Claim',
                          iconcolor: AppColors.primary.withOpacity(0.6),
                          textcolor: AppColors.primary.withOpacity(0.6),
                          imageColor: AppColors.primary.withOpacity(0.6),
                        ),
                ),
                presistentBottomNavBar(
                  state.index == 4
                      ? LandingIcons(
                          isImage: true,
                          image: 'asset/v2/app.png',
                          size: 2,
                          icons: Icons.menu_rounded,
                          title: 'More',
                          iconcolor: AppColors.primary,
                          textcolor: AppColors.primary,
                          imageColor: AppColors.primary,
                        )
                      : LandingIcons(
                          isImage: true,
                          image: 'asset/v2/app.png',
                          size: 2,
                          icons: Icons.menu_rounded,
                          title: 'More',
                          iconcolor: AppColors.primary.withOpacity(0.6),
                          textcolor: AppColors.primary.withOpacity(0.6),
                          imageColor: AppColors.primary.withOpacity(0.6),
                        ),
                ),
              ],
              confineInSafeArea: true,
              backgroundColor: AppColors.bgColor,
              handleAndroidBackButtonPress: true,
              resizeToAvoidBottomInset: true,
              stateManagement: true,
              hideNavigationBarWhenKeyboardShows: true,
              decoration: NavBarDecoration(
                border: Border.all(
                  color: Colors.transparent.withOpacity(0.1),
                ),
                boxShadow: [
                  const BoxShadow(color: Colors.transparent),
                ],
              ),
              popAllScreensOnTapOfSelectedTab: true,
              popActionScreens: PopActionScreensType.all,
              itemAnimationProperties: const ItemAnimationProperties(
                duration: Duration(milliseconds: 200),
                curve: Curves.ease,
              ),
              screenTransitionAnimation: const ScreenTransitionAnimation(
                animateTabTransition: false,
                curve: Curves.ease,
                duration: Duration(milliseconds: 100),
              ),
              navBarStyle: NavBarStyle.style6,
            ),
          ),
        ));
      },
    );
  }

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const TicketsScreen(),
      const BuyNowScreen(),
      const ClaimScreen(),
      MoreScreen(),
    ];
  }

  PersistentBottomNavBarItem presistentBottomNavBar(dynamic icon) {
    return PersistentBottomNavBarItem(
      textStyle: context.textTheme.bodySmall!.copyWith(fontSize: 14),
      icon: icon,
    );
  }
}
