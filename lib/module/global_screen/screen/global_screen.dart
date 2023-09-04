import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:OWPM/module/global_screen/cubit/global_screen_cubit.dart';
import 'package:OWPM/module/home/cubit/home_cubit_cubit.dart';
import 'package:OWPM/utils/colors.dart';
import 'package:OWPM/module/more_options/screen/more.dart';
import 'package:OWPM/module/my_tickets/screen/tickets.dart';
import 'package:OWPM/module/draws/screen/draws.dart';
import 'package:OWPM/module/home/screen/home_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

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
              },
              controller: state.controller,
              navBarHeight: 76,
              padding: const NavBarPadding.symmetric(vertical: 15),
              screens: _buildScreens(),
              items: [
                presistentBottomNavBar(
                  state.index == 0
                      ? LandingIcons(
                          icons: Icons.home_outlined,
                          title: 'Home',
                          iconcolor: AppColors.primary,
                          textcolor: AppColors.primary,
                        )
                      : LandingIcons(
                          icons: Icons.home_outlined,
                          title: 'Home',
                          iconcolor: AppColors.grey,
                          textcolor: AppColors.grey,
                        ),
                ),
                presistentBottomNavBar(
                  state.index == 1
                      ? LandingIcons(
                          icons: Icons.filter_1_rounded,
                          title: 'Draws',
                          iconcolor: AppColors.primary,
                          textcolor: AppColors.primary,
                        )
                      : LandingIcons(
                          icons: Icons.filter_1_rounded,
                          title: 'Draws',
                          iconcolor: AppColors.grey,
                          textcolor: AppColors.grey,
                        ),
                ),
                presistentBottomNavBar(
                  state.index == 2
                      ? LandingIcons(
                          icons: Icons.local_attraction_outlined,
                          title: 'Tickets',
                          iconcolor: AppColors.primary,
                          textcolor: AppColors.primary,
                        )
                      : LandingIcons(
                          icons: Icons.local_attraction_outlined,
                          title: 'Tickets',
                          iconcolor: AppColors.grey,
                          textcolor: AppColors.grey,
                        ),
                ),
                presistentBottomNavBar(
                  state.index == 3
                      ? LandingIcons(
                          icons: Icons.menu_rounded,
                          title: 'More',
                          iconcolor: AppColors.primary,
                          textcolor: AppColors.primary,
                        )
                      : LandingIcons(
                          icons: Icons.menu_rounded,
                          title: 'More',
                          iconcolor: AppColors.grey,
                          textcolor: AppColors.grey,
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
      const DrawsScreen(),
      const TicketsScreen(),
      MoreScreen(),
    ];
  }

  PersistentBottomNavBarItem presistentBottomNavBar(dynamic icon) {
    return PersistentBottomNavBarItem(
      icon: icon,
    );
  }
}
