import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:millionaire_app/controller/cubit/global_screen/global_screen_cubit.dart';
import 'package:millionaire_app/controller/cubit/home/home_cubit_cubit.dart';
import 'package:millionaire_app/utils/colors.dart';
import 'package:millionaire_app/view/More/more.dart';
import 'package:millionaire_app/view/More/widgets/tickets/tickets.dart';
import 'package:millionaire_app/view/draws/draws.dart';
import 'package:millionaire_app/view/home/home_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

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
            width: context.width > 850 ? 600 : context.width,
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
                          icons: Icons.density_medium_rounded,
                          title: 'More',
                          iconcolor: AppColors.primary,
                          textcolor: AppColors.primary,
                        )
                      : LandingIcons(
                          icons: Icons.density_medium_rounded,
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
                border: Border.all(color: Colors.grey.withOpacity(0.1)),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                boxShadow: [
                  const BoxShadow(color: Colors.black),
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
      // iconSize: 10,
      // title: text,
      // activeColorPrimary:tActive,
      // inactiveColorPrimary: tInactive,
    );
  }
}

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
        Text(title,
            style: context.textTheme.bodySmall!.copyWith(color: textcolor))
      ],
    );
  }
}
