import 'package:OWPM/module/global_screen/screen/global_screen.dart';
import 'package:OWPM/module/home/screen/buy_now.dart';
import 'package:OWPM/module/more_options/screen/how_to_use_screen.dart';
import 'package:OWPM/module/more_options/screen/privacy_policy.dart';
import 'package:OWPM/module/my_tickets/screen/tickets.dart';
import 'package:OWPM/module/onboarding/screens/login_screen.dart';
import 'package:OWPM/module/splash/screens/no_internet/no_internet.dart';
import 'package:OWPM/module/splash/screens/splash_screen.dart';
import 'package:OWPM/utils/apppref.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final url = settings.name;
    final args = settings.arguments;

    switch (url) {
      case "/":
        return pagetransition(settings, const SplashScreen());
      case AppRoutes.loginOrHome:
        return AppPref.userToken != ''
            ? pagetransition(settings, const Landing())
            : pagetransition(settings, const LoginScreen());
      case AppRoutes.landingScreen:
        return pagetransition(settings, const Landing());
      case AppRoutes.ticketScreen:
        return pagetransition(settings, const TicketsScreen());

      case AppRoutes.howtoUseScreen:
        return pagetransition(settings, const HowToUseScreen());
      case AppRoutes.noInternetScreen:
        return pagetransition(settings, const NoInternetScreen());
      case AppRoutes.buynowScreen:
        return pagetransition(settings, const BuyNowScreen());
      case AppRoutes.privacyPolicyScreen:
        if (args is Map) {
          return pagetransition(settings, const WebViewXPage());
        }
        break;
      default:
        return pagetransition(
          settings,
          const SplashScreen(),
        );
    }
    return MaterialPageRoute(
        builder: (_) => const Scaffold(
              body: Center(child: Error()),
            ));
  }

  static PageTransition<dynamic> pagetransition(
      RouteSettings settings, Widget widget) {
    return PageTransition(
      child: widget,
      type: PageTransitionType.fade,
      settings: settings,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 100),
    );
  }

  static PageTransition<dynamic> pagetransitionLeft(
      RouteSettings settings, Widget widget) {
    return PageTransition(
      child: widget,
      type: PageTransitionType.rightToLeft,
      settings: settings,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 100),
    );
  }
}

class Error extends StatelessWidget {
  const Error({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Text('Oops');
  }
}
