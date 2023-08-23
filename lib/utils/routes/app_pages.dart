import 'package:flutter/material.dart';
import 'package:millionaire_app/utils/apppref.dart';
import 'package:millionaire_app/utils/routes/app_routes.dart';
import 'package:millionaire_app/view/global_screen/global_screen.dart';
import 'package:millionaire_app/view/onboarding/login_screen.dart';
import 'package:page_transition/page_transition.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final url = settings.name;
    switch (url) {
      case "/":
        return AppPref.userToken != ''
            ? pagetransition(settings, const Landing())
            : pagetransition(settings, const LoginScreen());
      case AppRoutes.landingScreen:
        return pagetransition(settings, const Landing());

      default:
        return pagetransition(
          settings,
          const LoginScreen(),
        );
    }
  }

  static PageTransition<dynamic> pagetransition(
      RouteSettings settings, Widget widget) {
    return PageTransition(
      child: widget,
      type: PageTransitionType.fade,
      settings: settings,
      duration: const Duration(milliseconds: 1),
      reverseDuration: const Duration(milliseconds: 1),
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
